require IEx

defmodule DoctorsApi.Guardian do
  use Guardian, otp_app: :doctors_api

  alias DoctorsApi.{Repo, User}

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    case Repo.get!(User, id) do
      nil -> {:error, :resource_not_found}
      user -> {:ok, user}
    end
  end
end

defmodule DoctorsApi.Guardian.AuthPipeline do
  @claims %{typ: "access"}

  use Guardian.Plug.Pipeline,
    otp_app: :doctors_api,
    module: DoctorsApi.Guardian,
    error_handler: DoctorsApi.Guardian.AuthErrorHandler

  # If there is a session token, restrict it to an access token and validate it
  plug Guardian.Plug.VerifySession, claims: @claims
  # If there is an authorization header, restrict it to an access token and validate it
  plug Guardian.Plug.VerifyHeader, claims: @claims, realm: "Bearer"
  # Load the user if either of the verifications worked
  plug Guardian.Plug.LoadResource, allow_blank: true
end

defmodule DoctorsApi.Guardian.AuthErrorHandler do
  import Plug.Conn

  def auth_error(conn, {type, reason}, _opts) do
    body = Poison.encode!(%{message: to_string(type)})
    send_resp(conn, 401, body)
  end
end

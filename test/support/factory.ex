defmodule DoctorsApi.Factory do
  use ExMachina.Ecto, repo: DoctorsApi.Repo

  alias DoctorsApi.{User, Channel}

  def patient_factory do
    %User{
      name: "Jane Smith",
      email: sequence(:email, &"email-#{&1}@example.com"),
      password: "my_secret_password",
      password_hash: "my_secret_pass_hashed",
      login: "janes",
    }
  end

  def doctor_factory do
    %User{
      name: "Dr Awesome",
      email: sequence(:email, &"email-#{&1}@example.com"),
      password: "my_secret_password",
      password_hash: "my_secret_pass_hashed",
      login: "doctor",
    }
  end

  def channel_factory do
    %Channel{
      name: "Doctor <--> Patient Communication",
    }
  end

  def user_channel_factory do
    %Channel{
      name: "some_cool_name",
      users: [ build(:patient) ]
    }
  end
end

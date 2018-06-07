# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :doctors_api,
  ecto_repos: [DoctorsApi.Repo]

# Configures the endpoint
config :doctors_api, DoctorsApi.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "nsqASUbUAHfyvg9S8C+n9FriGUCSAVEQfHmz5ql1z5rlIBQMDd0GLbx/L8zhZudl",
  render_errors: [view: DoctorsApi.ErrorView, accepts: ~w(html json)],
  pubsub: [name: DoctorsApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

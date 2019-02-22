defmodule Froggy.Repo do
  use Ecto.Repo,
    otp_app: :froggy,
    adapter: Ecto.Adapters.Postgres
end

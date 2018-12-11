defmodule Lani.Repo do
  use Ecto.Repo,
    otp_app: :lani,
    adapter: Ecto.Adapters.Postgres
end

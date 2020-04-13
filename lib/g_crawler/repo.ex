defmodule GCrawler.Repo do
  use Ecto.Repo,
    otp_app: :g_crawler,
    adapter: Ecto.Adapters.Postgres
end

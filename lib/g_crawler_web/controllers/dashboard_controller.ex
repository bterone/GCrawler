defmodule GCrawlerWeb.DashboardController do
  use GCrawlerWeb, :controller

  def show(conn, _params) do
    render(conn, "index.html")
  end
end

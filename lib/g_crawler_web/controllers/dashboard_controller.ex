defmodule GCrawlerWeb.DashboardController do
  use GCrawlerWeb, :controller

  alias GCrawler.Accounts
  alias GCrawler.Accounts.User

  def create(conn, %{"user" => user_params}) do
    IO.inspect user_params
  end

  def show(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "index.html", changeset: changeset)
  end
end

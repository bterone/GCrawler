defmodule GCrawlerWeb.SessionController do
  use GCrawlerWeb, :controller

  alias GCrawler.Accounts
  alias GCrawler.Accounts.User
  alias GCrawler.Accounts.Password

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => auth_params}) do
    user = Accounts.get_by_username(auth_params["username"])

    case Password.check_password(user, auth_params["password"]) do
      {:ok, user} ->
        conn
        |> put_session(:current_user_id, user.id)
        |> put_flash(:info, "Signed in successfully!")
        |> redirect(to: Routes.dashboard_path(conn, :show))

      {:error, _} ->
        conn
        |> put_flash(:error, "There was a problem with your username or password")
        |> redirect(to: Routes.session_path(conn, :new))
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:current_user_id)
    |> put_flash(:info, "Signed out successfully!")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end

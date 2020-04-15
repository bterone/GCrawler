defmodule GCrawlerWeb.Helpers.Auth do
  def signed_in?(conn) do
    user_id = Plug.Conn.get_session(conn, :current_user_id)
    if user_id, do: !!GCrawler.Repo.get(GCrawler.Accounts.User, user_id)
  end
end

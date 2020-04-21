defmodule GCrawler.SessionHelpers do
  alias Plug.Conn
  import GCrawler.Factory

  def sign_in(%Conn{} = conn, user) do
    Plug.Test.init_test_session(conn, current_user_id: user.id)
  end

  def sign_in(%Conn{} = conn) do
    user = insert(:user)
    Plug.Test.init_test_session(conn, current_user_id: user.id)
  end
end

defmodule GCrawlerWeb.Plugs.SetCurrentUserTest do
  use GCrawlerWeb.ConnCase, async: true
  import GCrawlerWeb.Plugs.SetCurrentUser

  test "set the current user if User ID is valid", %{conn: conn} do
    user = insert(:user, username: "Billy123")
    conn =
      conn
      |> sign_in(user)
      |> call(%{})

    assert conn.assigns.current_user.username == "Billy123"
    assert conn.assigns.user_signed_in? == true
  end

  test "set the current user to nil if the User ID is invalid", %{conn: conn} do
    conn =
      conn
      |> Plug.Test.init_test_session(%{})
      |> call(%{})

    assert conn.assigns.current_user == nil
    assert conn.assigns.user_signed_in? == false
  end
end

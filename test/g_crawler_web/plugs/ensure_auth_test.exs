defmodule GCrawlerWeb.Plugs.EnsureAuthTest do
  use GCrawlerWeb.ConnCase, async: true
  import GCrawlerWeb.Plugs.EnsureAuth

  test "user passes when signed in", %{conn: conn} do
    conn =
      conn
      |> sign_in
      |> assign(:user_signed_in?, true)
      |> call(%{})

    refute conn.halted
    assert conn.status != 302
  end

  test "user is redirected when user has not signed in", %{conn: conn} do
    conn =
      conn
      |> Plug.Test.init_test_session(%{})
      |> fetch_flash
      |> assign(:user_signed_in?, false)
      |> call(%{})

    assert conn.halted
    assert redirected_to(conn) == Routes.session_path(conn, :new)
    assert get_flash(conn, :error) == "You need to sign in or sign up before continuing."
  end
end

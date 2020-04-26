defmodule GCrawlerWeb.SessionControllerTest do
  use GCrawlerWeb.ConnCase, async: true

  describe "new session" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.session_path(conn, :new))
      assert html_response(conn, 200) =~ "Sign in"
    end
  end

  describe "create session" do
    test "redirects to user dashboard when data is valid", %{conn: conn} do
      user = insert(:user)
      conn = post(conn, Routes.session_path(conn, :create), user: %{username: user.username, password: user.password})

      assert %{"current_user_id" => id} = get_session(conn)
      assert redirected_to(conn) == Routes.dashboard_path(conn, :show)
      assert get_flash(conn, :info) == "Signed in successfully!"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      user_attributes = params_for(:user, password: nil)
      conn = post(conn, Routes.session_path(conn, :create), user: user_attributes)

      assert get_flash(conn, :error) =~ "There was a problem with your username or password"
    end
  end

  describe "delete session" do
    test "redirects to home page when session is deleted", %{conn: conn} do
      conn =
        conn
        |> sign_in
        |> delete(Routes.session_path(conn, :delete))

      assert get_flash(conn, :info) =~ "Signed out successfully!"
      assert redirected_to(conn) == Routes.page_path(conn, :index)
    end
  end
end

defmodule GCrawlerWeb.UserControllerTest do
  use GCrawlerWeb.ConnCase, async: true

  describe "new user" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :new))
      assert html_response(conn, 200) =~ "Sign up"
    end
  end

  describe "create user" do
    test "redirects to show when data is valid", %{conn: conn} do
      user_attributes = params_for(:user, username: "Billy123", password: "Password123", password_confirmation: "Password123")
      conn = post(conn, Routes.user_path(conn, :create), user: user_attributes)

      assert redirected_to(conn) == Routes.page_path(conn, :index)
      assert get_flash(conn, :info) == "User created successfully."
    end

    # TODO: Assert by checking the element from DOM instead of literal string
    test "renders errors when data is invalid", %{conn: conn} do
      user_attributes = params_for(:user, password: nil, password_confirmation: nil)
      conn = post(conn, Routes.user_path(conn, :create), user: user_attributes)

      assert html_response(conn, 200) =~ "can&#39;t be blank"
    end
  end
end

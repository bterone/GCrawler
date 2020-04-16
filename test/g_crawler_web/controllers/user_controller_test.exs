defmodule GCrawlerWeb.UserControllerTest do
  use GCrawlerWeb.ConnCase

  @create_attrs %{username: "Billy123", password: "Password123", password_confirmation: "Password123"}
  @invalid_attrs %{encrypted_password: nil, username: nil}

  describe "new user" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :new))
      assert html_response(conn, 200) =~ "Sign up"
    end
  end

  describe "create user" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)

      assert %{"current_user_id" => id} = get_session(conn)
      assert redirected_to(conn) == Routes.page_path(conn, :index)

      conn = get(conn, Routes.page_path(conn, :index))
      assert html_response(conn, 200) =~ "User created successfully"
    end

    # TODO: Assert by checking the element from DOM instead of literal string
    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert html_response(conn, 200) =~ "can&#39;t be blank"
    end
  end
end

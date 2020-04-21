defmodule GCrawlerWeb.Helpers.AuthTest do
  use GCrawlerWeb.ConnCase, async: true

  alias GCrawlerWeb.Helpers.Auth

  describe "signed_in?/1" do
    test "returns true when user is signed in", %{conn: conn} do
      conn = conn |> sign_in

      assert Auth.signed_in?(conn)
    end

    test "returns false when user is not signed in", %{conn: conn} do
      conn = Plug.Test.init_test_session(conn, %{})

      refute Auth.signed_in?(conn)
    end
  end
end

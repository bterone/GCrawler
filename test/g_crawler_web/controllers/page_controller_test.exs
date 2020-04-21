defmodule GCrawlerWeb.PageControllerTest do
  use GCrawlerWeb.ConnCase, async: true

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to the Google Crawler"
  end
end

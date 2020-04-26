defmodule GCrawlerWeb.Plugs.EnsureAuth do
  @moduledoc """
  Plug containing authentication checks to the user to guard access to routes
  """

  import Plug.Conn
  import Phoenix.Controller
  import GCrawlerWeb.Gettext

  alias GCrawlerWeb.Router.Helpers, as: Routes

  def init(_options), do: nil

  def call(conn, _options) do
    if conn.assigns.user_signed_in? do
      conn
    else
      conn
      |> put_flash(:error, gettext "You need to sign in or sign up before continuing.")
      |> redirect(to: Routes.session_path(conn, :new))
      |> halt()
    end
  end
end

defmodule GCrawlerWeb.Plugs.SetCurrentUser do
  @moduledoc """
  Plug which sets the user to the connection if the user is authenticated
  """

  import Plug.Conn

  alias GCrawler.Accounts

  def init(_options), do: nil

  def call(conn, _options) do
    user_id = Plug.Conn.get_session(conn, :current_user_id)

    cond do
      current_user = user_id && Accounts.get_by_user_id(user_id) ->
        conn
        |> assign(:current_user, current_user)
        |> assign(:user_signed_in?, true)
      true ->
        conn
        |> assign(:current_user, nil)
        |> assign(:user_signed_in?, false)
    end
  end
end
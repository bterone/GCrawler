defmodule GCrawlerWeb.QueryResultController do
  use GCrawlerWeb, :controller

  alias GCrawler.Search
  alias GCrawler.Search.QueryResult

  def index(conn, _params) do
    query_results = Search.list_query_results()
    render(conn, "index.html", query_results: query_results)
  end

  def new(conn, _params) do
    changeset = Search.change_query_result(%QueryResult{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"query_result" => query_result_params}) do
    case Search.create_query_result(query_result_params) do
      {:ok, query_result} ->
        conn
        |> put_flash(:info, "Query result created successfully.")
        |> redirect(to: Routes.query_result_path(conn, :show, query_result))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    query_result = Search.get_query_result!(id)
    render(conn, "show.html", query_result: query_result)
  end

  def edit(conn, %{"id" => id}) do
    query_result = Search.get_query_result!(id)
    changeset = Search.change_query_result(query_result)
    render(conn, "edit.html", query_result: query_result, changeset: changeset)
  end

  def update(conn, %{"id" => id, "query_result" => query_result_params}) do
    query_result = Search.get_query_result!(id)

    case Search.update_query_result(query_result, query_result_params) do
      {:ok, query_result} ->
        conn
        |> put_flash(:info, "Query result updated successfully.")
        |> redirect(to: Routes.query_result_path(conn, :show, query_result))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", query_result: query_result, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    query_result = Search.get_query_result!(id)
    {:ok, _query_result} = Search.delete_query_result(query_result)

    conn
    |> put_flash(:info, "Query result deleted successfully.")
    |> redirect(to: Routes.query_result_path(conn, :index))
  end
end

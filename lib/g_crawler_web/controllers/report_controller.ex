defmodule GCrawlerWeb.ReportController do
  use GCrawlerWeb, :controller

  alias GCrawler.Search
  alias GCrawler.Search.Report

  def index(conn, _params) do
    reports = Search.list_reports()
    render(conn, "index.html", reports: reports)
  end

  def new(conn, _params) do
    changeset = Search.change_report(%Report{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"report" => report_params}) do
    # STEPS
    # Update the SearchQuery data

    # Completed, update the report record

    # Create an async background job that takes this list and performs the queries (Synchronously)
    ### Check if query already exists and if its outdated
    ### Each new search query will be saved for future reference

    case Search.create_report(report_params) do
      {:ok, report} ->
        conn
        |> put_flash(:info, "Report created successfully.")
        |> redirect(to: Routes.report_path(conn, :show, report))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    report = Search.get_report!(id)
    render(conn, "show.html", report: report)
  end

  def edit(conn, %{"id" => id}) do
    report = Search.get_report!(id)
    changeset = Search.change_report(report)
    render(conn, "edit.html", report: report, changeset: changeset)
  end

  def update(conn, %{"id" => id, "report" => report_params}) do
    report = Search.get_report!(id)

    case Search.update_report(report, report_params) do
      {:ok, report} ->
        conn
        |> put_flash(:info, "Report updated successfully.")
        |> redirect(to: Routes.report_path(conn, :show, report))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", report: report, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    report = Search.get_report!(id)
    {:ok, _report} = Search.delete_report(report)

    conn
    |> put_flash(:info, "Report deleted successfully.")
    |> redirect(to: Routes.report_path(conn, :index))
  end
end

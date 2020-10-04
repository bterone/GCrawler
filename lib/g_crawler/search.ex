defmodule GCrawler.Search do
  @moduledoc """
  The Search context.
  """

  import Ecto.Query, warn: false
  alias GCrawler.Repo

  alias GCrawler.Search.{Report, QueryResult}
  alias GCrawler.QueryManager.SearchQueue

  alias GCrawler.QueryManager.Search, as: QueryManagerSearch

  def list_reports do
    Repo.all(Report)
  end

  def get_report!(id), do: Repo.get!(Report, id)

  @doc """
  Creates a report.

  ## Examples

      iex> create_report(%{field: value})
      {:ok, %Report{}}

      iex> create_report(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  # Create a report record
  # Insert into SearchQuery table all the data
  # Insert into ReportSearchQuery table
  # Queue a search for the records
  def create_report(attrs \\ %{}) do
    attrs = put_csv_path(attrs)

    report =
      %Report{}
      |> Report.changeset(attrs)
      |> Repo.insert()

    if {:ok, report_data} = report do
      QueryManagerSearch.queue_search(report_data.csv_path, report_data.id)
    end

    report
  end

  defp put_csv_path(attrs) do
    Map.put(attrs, "csv_path", attrs["csv"].path)
  end

  def update_report(%Report{} = report, attrs) do
    report
    |> Report.changeset(attrs)
    |> Repo.update()
  end

  def delete_report(%Report{} = report) do
    from(search_queue in SearchQueue, where: search_queue.report_id == ^"#{report.id}")
    |> Repo.delete_all()

    Repo.delete(report)
  end

  def change_report(%Report{} = report) do
    Report.changeset(report, %{})
  end

  def list_query_results do
    Repo.all(QueryResult)
  end

  def get_query_result!(id), do: Repo.get!(QueryResult, id)

  def create_query_result(attrs \\ %{}) do
    %QueryResult{}
    |> QueryResult.changeset(attrs)
    |> Repo.insert()
  end

  def update_query_result(%QueryResult{} = query_result, attrs) do
    query_result
    |> QueryResult.changeset(attrs)
    |> Repo.update()
  end

  def delete_query_result(%QueryResult{} = query_result) do
    Repo.delete(query_result)
  end

  def change_query_result(%QueryResult{} = query_result) do
    QueryResult.changeset(query_result, %{})
  end

  def create_search_queue(attrs \\ %{}) do
    %SearchQueue{}
    |> SearchQueue.changeset(attrs)
    |> Repo.insert()
  end

  def change_query_result(%SearchQueue{} = query_result) do
    SearchQueue.changeset(query_result, %{})
  end
end

defmodule GCrawler.Search do
  @moduledoc """
  The Search context.
  """

  import Ecto.Query, warn: false
  alias GCrawler.Repo

  alias GCrawler.Search.Report
  alias GCrawler.Search.SearchQueue
  alias GCrawler.Search.QueryResult

  @doc """
  Returns the list of reports.

  ## Examples

      iex> list_reports()
      [%Report{}, ...]

  """
  def list_reports do
    Repo.all(Report)
  end

  @doc """
  Gets a single report.

  Raises `Ecto.NoResultsError` if the Report does not exist.

  ## Examples

      iex> get_report!(123)
      %Report{}

      iex> get_report!(456)
      ** (Ecto.NoResultsError)

  """
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
      SearchQueue.queue_search(report_data.csv_path, report_data.id)
    end

    report
  end

  defp put_csv_path(attrs) do
    Map.put(attrs, "csv_path", attrs["csv"].path)
  end

  @doc """
  Updates a report.

  ## Examples

      iex> update_report(report, %{field: new_value})
      {:ok, %Report{}}

      iex> update_report(report, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_report(%Report{} = report, attrs) do
    report
    |> Report.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a report.

  ## Examples

      iex> delete_report(report)
      {:ok, %Report{}}

      iex> delete_report(report)
      {:error, %Ecto.Changeset{}}

  """
  def delete_report(%Report{} = report) do
    Repo.delete(report)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking report changes.

  ## Examples

      iex> change_report(report)
      %Ecto.Changeset{source: %Report{}}

  """
  def change_report(%Report{} = report) do
    Report.changeset(report, %{})
  end



  @doc """
  Returns the list of query_results.

  ## Examples

      iex> list_query_results()
      [%QueryResult{}, ...]

  """
  def list_query_results do
    Repo.all(QueryResult)
  end

  @doc """
  Gets a single query_result.

  Raises `Ecto.NoResultsError` if the Query result does not exist.

  ## Examples

      iex> get_query_result!(123)
      %QueryResult{}

      iex> get_query_result!(456)
      ** (Ecto.NoResultsError)

  """
  def get_query_result!(id), do: Repo.get!(QueryResult, id)

  @doc """
  Creates a query_result.

  ## Examples

      iex> create_query_result(%{field: value})
      {:ok, %QueryResult{}}

      iex> create_query_result(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_query_result(attrs \\ %{}) do
    %QueryResult{}
    |> QueryResult.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a query_result.

  ## Examples

      iex> update_query_result(query_result, %{field: new_value})
      {:ok, %QueryResult{}}

      iex> update_query_result(query_result, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_query_result(%QueryResult{} = query_result, attrs) do
    query_result
    |> QueryResult.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a query_result.

  ## Examples

      iex> delete_query_result(query_result)
      {:ok, %QueryResult{}}

      iex> delete_query_result(query_result)
      {:error, %Ecto.Changeset{}}

  """
  def delete_query_result(%QueryResult{} = query_result) do
    Repo.delete(query_result)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking query_result changes.

  ## Examples

      iex> change_query_result(query_result)
      %Ecto.Changeset{source: %QueryResult{}}

  """
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

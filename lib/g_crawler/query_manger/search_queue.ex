defmodule GCrawler.QueryManager.SearchQueue do
  use Ecto.Schema
  import Ecto.Changeset

  alias GCrawler.QueryManager.Search

  schema "query_results_reports" do
    belongs_to :report, GCrawler.Search.Report
    belongs_to :query_result, GCrawler.Search.QueryResult

    timestamps()
  end

  @doc false
  def changeset(query_result_report, attrs) do
    query_result_report
    |> cast(attrs, [:report_id, :query_result_id])
    |> validate_required([:report_id, :query_result_id])
  end
end

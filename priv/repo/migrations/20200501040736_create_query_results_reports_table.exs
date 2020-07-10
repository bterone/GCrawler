defmodule GCrawler.Repo.Migrations.CreateQueryResultsReportsTable do
  use Ecto.Migration

  def change do
    create table(:query_results_reports) do
      add :query_result_id, references(:query_results)
      add :report_id, references(:reports)

      timestamps()
    end
  end
end

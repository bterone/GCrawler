defmodule GCrawler.Repo.Migrations.CreateQueryResults do
  use Ecto.Migration

  def change do
    create table(:query_results) do
      add :search_term, :string
      add :number_of_top_advertisers, :integer
      add :total_number_of_advertisers, :integer
      add :top_advertiser_urls, {:array, :string}
      add :number_of_results_on_page, :integer
      add :url_results_on_page, {:array, :string}
      add :number_of_urls, :integer
      add :html_cache, :string
      add :total_number_of_results, :integer

      timestamps()
    end
  end
end

defmodule GCrawler.Search.QueryResult do
  use Ecto.Schema
  import Ecto.Changeset

  schema "query_results" do
    field :search_term, :string
    field :html_cache, :string
    field :number_of_results_on_page, :integer
    field :number_of_top_advertisers, :integer
    field :number_of_urls, :integer
    field :top_advertiser_urls, {:array, :string}
    field :total_number_of_advertisers, :integer
    field :total_number_of_results, :integer
    field :url_results_on_page, {:array, :string}

    many_to_many :reports, GCrawler.QueryManager.SearchQueue, join_through: "query_results"

    timestamps()
  end

  @doc false
  def changeset(query_result, attrs) do
    query_result
    |> cast(attrs, [
      :search_term,
      :number_of_top_advertisers,
      :total_number_of_advertisers,
      :top_advertiser_urls,
      :number_of_results_on_page,
      :url_results_on_page,
      :number_of_urls,
      :html_cache,
      :total_number_of_results
    ])
    |> validate_required([:search_term])
  end
end

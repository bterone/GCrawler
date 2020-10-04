defmodule GCrawler.Search.Report do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reports" do
    field :title, :string

    field :csv_path, :string, virtual: true

    many_to_many :query_results, GCrawler.QueryManager.SearchQueue, join_through: "query_results"

    timestamps()
  end

  @doc false
  # Validate a csv has come through
  # Cast the changeset to put_csv_path
  def changeset(report, attrs) do
    report
    |> cast(attrs, [:title, :csv_path])
    |> validate_required([:title, :csv_path])
    |> unique_constraint(:title)
  end

  # Expect Plug Upload file
  # Inside, should add csv_path to changeset
  defp put_csv_path(%Ecto.Changeset{changes: %{csv: %Plug.Upload{path: file_path}}} = changeset) do
    put_change(changeset, :csv_path, file_path)
  end

  defp put_csv_path(changeset), do: changeset
end

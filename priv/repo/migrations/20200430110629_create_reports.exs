defmodule GCrawler.Repo.Migrations.CreateReports do
  use Ecto.Migration

  def change do
    create table(:reports) do
      add :title, :string, null: false

      add :user_id, references(:users)

      timestamps()
    end

    create unique_index(:reports, [:title])
  end
end

defmodule GCrawler.Factory do
  use ExMachina.Ecto, repo: GCrawler.Repo

  use GCrawler.UserFactory
end

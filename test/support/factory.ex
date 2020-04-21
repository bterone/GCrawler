defmodule GCrawler.Factory do
  @moduledoc """
  Contains factories for generating mock data
  """

  use ExMachina.Ecto, repo: GCrawler.Repo

  use GCrawler.UserFactory
end

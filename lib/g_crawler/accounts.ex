defmodule GCrawler.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias GCrawler.Repo

  alias GCrawler.Accounts.User

  @doc """
  Creates a user.

  ## Examples

    iex> user = %{"username" => "Billy", "password" => "SecretPassword@123", "password_confirmation" => "SecretPassword@123"}
    iex> with {:ok, %GCrawler.Accounts.User{}} <- create_user(user), do: :passed
    :passed

    iex>  user = %{"username" => "Billy", "password" => "SecretPassword@123", "password_confirmation" => "NotMatching@123"}
    iex> with {:error, %Ecto.Changeset{valid?: false}} <- create_user(user), do: :passed
    :passed

    iex> user = %{"username" => nil, "password" => nil}
    iex> with {:error, %Ecto.Changeset{valid?: false}} <- create_user(user), do: :passed
    :passed

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

    iex> user = %GCrawler.Accounts.User{username: "Tom", password: "SecretPassword@123", password_confirmation: "SecretPassword@123"}
    iex> _result = change_user(user)
    iex> with _result <- %Ecto.Changeset{data: %GCrawler.Accounts.User{username: "Tom", password: "SecretPassword@123", password_confirmation: "SecretPassword@123"}, valid?: true}, do: :passed
    :passed

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end
end

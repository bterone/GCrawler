defmodule GCrawler.Accounts.User do
  @moduledoc """
  Contains the schema and changeset for the User
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias GCrawler.Accounts.Password

  schema "users" do
    field :username, :string
    field :encrypted_password, :string

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password, :password_confirmation])
    |> validate_required([:username, :password, :password_confirmation])
    |> unique_constraint(:username)
    |> validate_length(:password, min: 6)
    |> validate_confirmation(:password)
    |> encrypt_password
  end

  defp encrypt_password(%Ecto.Changeset{changes: %{ password: password }, valid?: true} = changeset) do
    put_change(changeset, :encrypted_password, Password.hash_password(password))
  end

  defp encrypt_password(changeset), do: changeset
end

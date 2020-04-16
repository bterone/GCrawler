defmodule GCrawler.AccountsTest do
  use GCrawler.DataCase
  doctest GCrawler.Accounts, import: true

  alias GCrawler.Accounts

  describe "users" do
    alias GCrawler.Accounts.User

    @valid_attrs %{username: "Billy123", password: "Password123", password_confirmation: "Password123"}
    @invalid_attrs %{username: nil, password: nil, password_confirmation: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.username == "Billy123"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end

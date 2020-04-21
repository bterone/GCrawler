defmodule GCrawler.AccountsTest do
  use GCrawler.DataCase, async: true
  doctest GCrawler.Accounts, import: true

  alias GCrawler.Accounts
  alias GCrawler.Accounts.User

  describe "create_user/1" do
    test "with valid data creates a user" do
      user_attributes = params_for(:user, username: "Billy123")

      assert {:ok, %User{} = user} = Accounts.create_user(user_attributes)
      assert Repo.exists?(User)
      assert user.username == "Billy123"
    end

    test "encrypts the password" do
      user_attributes = params_for(:user, password: "Password123")
      {:ok, %User{} = user} = Accounts.create_user(user_attributes)

      assert Repo.exists?(User)
      assert user.encrypted_password != "Password123"
    end

    test "with invalid data returns error changeset" do
      user_attributes = params_for(:user, username: nil)

      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(user_attributes)
    end
  end

  describe "change_user/1" do
    test "returns a user changeset" do
      user_attributes = build(:user)

      assert %Ecto.Changeset{} = Accounts.change_user(user_attributes)
    end
  end

  describe "get_by_username/1" do
    test "get_by_username/1 with nil returns nil" do
      assert Accounts.get_by_username(nil) == nil
    end

    test "get_by_username with valid data returns a user" do
      insert(:user, username: "Thomas123")

      assert %User{username: "Thomas123"} = Accounts.get_by_username("Thomas123")
    end
  end
end

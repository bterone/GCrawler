defmodule GCrawler.AccountsTest do
  use GCrawler.DataCase
  doctest GCrawler.Accounts, import: true

  alias GCrawler.Accounts

  describe "users" do
    alias GCrawler.Accounts.User

    test "create_user/1 with valid data creates a user" do
      user_attributes = params_for(:user, username: "Billy123")

      assert {:ok, %User{} = user} = Accounts.create_user(user_attributes)
      assert user.username == "Billy123"
    end

    test "create_user/1 encrypts the password" do
      user_attributes = params_for(:user, password: "Password123")

      {:ok, %User{} = user} = Accounts.create_user(user_attributes)
      assert user.encrypted_password != "Password123"
    end

    test "create_user/1 with invalid data returns error changeset" do
      user_attributes = params_for(:user, username: nil)

      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(user_attributes)
    end

    test "change_user/1 returns a user changeset" do
      user_attributes = build(:user)

      assert %Ecto.Changeset{} = Accounts.change_user(user_attributes)
    end
  end
end

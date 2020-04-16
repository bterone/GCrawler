defmodule GCrawler.Accounts.UserTest do
  use GCrawler.DataCase

  alias GCrawler.Repo
  alias GCrawler.Accounts.User

  @valid_attributes %{
    username: "Billy123",
    password: "Password123",
    password_confirmation: "Password123"
  }

  describe "Validations" do
    test "username is unique" do
      %User{}
      |> User.changeset(@valid_attributes)
      |> Repo.insert()

      duplicated_user = User.changeset(%User{}, @valid_attributes)

      assert {:error, changeset} = Repo.insert(duplicated_user)

      refute changeset.valid?
      assert %{username: ["has already been taken"]} = errors_on(changeset)
    end

    test "requires username, password and password confirmation" do
      changeset = User.changeset(%User{}, %{})

      refute changeset.valid?
      assert %{username: ["can't be blank"]} = errors_on(changeset)
      assert %{password: ["can't be blank"]} = errors_on(changeset)
      assert %{password_confirmation: ["can't be blank"]} = errors_on(changeset)
    end

    test "password has at least 6 characters" do
      attributes = %{ @valid_attributes | password: "A", password_confirmation: "A" }
      changeset = User.changeset(%User{}, attributes)

      refute changeset.valid?
      assert %{password: ["should be at least 6 character(s)"]} = errors_on(changeset)
    end

    test "password is encrypted" do
      attributes = %{ @valid_attributes | password: "StrongPassword123", password_confirmation: "StrongPassword123" }
      changeset = User.changeset(%User{}, attributes)

      assert changeset.valid?
      assert get_change(changeset, :encrypted_password) != "StrongPassword123"
      assert get_change(changeset, :encrypted_password) != nil
    end
  end
end

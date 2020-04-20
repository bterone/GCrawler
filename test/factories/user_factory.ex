defmodule GCrawler.UserFactory do

  alias GCrawler.Accounts.User

  defmacro __using__(_opts) do
    quote do
      alias GCrawler.Accounts.Password

      def user_factory(attrs) do
        password = attrs[:password] || Faker.Util.format("%6b%3d")

        user = %User{
          username: Faker.Name.name(),
          password: password,
          password_confirmation: password,
          encrypted_password: Password.hash_password(password)
        }

        merge_attributes(user, attrs)
      end
    end
  end
end

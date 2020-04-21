defmodule GCrawler.Accounts.Password do
  @moduledoc """
  Contains functions used to encrypt and authenticate passwords
  """

  def hash_password(password), do: Bcrypt.hash_pwd_salt(password)

  def check_password(user, password), do: Bcrypt.check_pass(user, password)
end

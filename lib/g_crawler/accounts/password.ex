defmodule GCrawler.Accounts.Password do
  def hash_password(password), do: Bcrypt.hash_pwd_salt(password)
end

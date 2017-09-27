defmodule LeanCoffee.Guardian do
  use Guardian, otp_app: :lean_coffee

  def subject_for_token(user = %LeanCoffee.Accounts.User{}) do
    {:ok, to_string(user.id)}
  end

  def subject_for_token(_) do
    {:error, "Unknow resource type"}
  end

  def resource_from_claims(claims) do
    {:ok, LeanCoffee.Accounts.get_user!(claims["id"])}
  end

  def resource_from_claims(_claims) do
    {:error, "Unknow resource type"}
  end
end
defmodule LeanCoffee.Guardian.AuthPipeline do
  @claims %{type: "access"}

  use Guardian.Plug.Pipeline, otp_app: :lean_coffee,
                              module: LeanCoffee.Guardian,
                              error_handler: LeanCoffee.Guardian.AuthErrorHandler
  plug Guardian.Plug.VerifySession, claims: @claims
  plug Guardian.Plug.VerifyHeader, claims: @claims, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, ensure: true
end
defmodule LeanCoffeeWeb.UserController do
  use LeanCoffeeWeb, :controller

  alias LeanCoffee.Accounts
  alias LeanCoffee.Accounts.User

  action_fallback LeanCoffeeWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      new_conn = Guardian.Plug.api_sign_in(conn, user, :access)
      jwt = Guardian.Plug.current_token(new_conn)

      new_conn
      |> put_status(:created)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render(SessionView, "show.json", user: user, jwt: jwt)
    end

    with {:error, _} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:unprocessable_entity)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end

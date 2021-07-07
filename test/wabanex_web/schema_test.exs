defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "users queries" do
    test "when a valid id is given, returns the user",
         %{conn: conn} do
      params = %{email: "luis.lenzi@nexenergy.com.br", name: "Luís Lenzi", password: "123456"}

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
          {
            getUser(id: "#{user_id}") {
              id
              name
              email
            }
          }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "getUser" => %{
            "email" => "luis.lenzi@nexenergy.com.br",
            "id" => "#{user_id}",
            "name" => "Luís Lenzi"
          }
        }
      }

      assert response === expected_response
    end

    test "when a invalid id is given, returns the error",
         %{conn: conn} do
      params = %{email: "luis.lenzi@nexenergy.com.br", name: "Luís Lenzi", password: "123456"}

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
          {
            getUser(id: "#{user_id}a") {
              id
              name
              email
            }
          }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected_response = %{
        "errors" => [
          %{
            "locations" => [%{"column" => 15, "line" => 2}],
            "message" => "Argument \"id\" has invalid value \"#{user_id}a\"."
          }
        ]
      }

      assert response === expected_response
    end
  end

  describe "users mutations" do
    test "when all params are valid, creates the user",
         %{conn: conn} do
      mutation = """
          mutation {
            createUser(input: {
              email: "luis.lenzi@nexenergy.com.br",
              name: "Luís Lenzi",
              password: "123456"
            }) {
              id
              name
              email
            }
          }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "createUser" => %{
            "email" => "luis.lenzi@nexenergy.com.br",
            "id" => "#{response["data"]["createUser"]["id"]}",
            "name" => "Luís Lenzi"
          }
        }
      }

      assert response === expected_response
    end
  end
end

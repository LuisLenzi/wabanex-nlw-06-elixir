defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true

  alias Wabanex.User

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = %{
        name: "Luís Lenzi",
        email: "luis.lenzi@nexenergy.com.br",
        password: "123456"
      }

      response = User.changeset(params)

      assert %Ecto.Changeset{
               valid?: true,
               changes: %{
                 name: "Luís Lenzi",
                 email: "luis.lenzi@nexenergy.com.br",
                 password: "123456"
               },
               errors: []
             } = response
    end

    test "when all params are invalid, returns a invalid changeset" do
      params = %{
        name: "L",
        email: "luis.lenzi@nexenergy.com.br",
        password: "1234"
      }

      response = User.changeset(params)

      expected_error = %{
        name: ["should be at least 2 character(s)"],
        password: ["should be at least 6 character(s)"]
      }

      assert errors_on(response) === expected_error
    end
  end
end

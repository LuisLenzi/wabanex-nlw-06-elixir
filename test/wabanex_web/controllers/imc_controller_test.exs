defmodule WabanexWeb.IMCControlleTest do
  use WabanexWeb.ConnCase, async: true

  describe "index/2" do
    test "when all params is valid, returns the imc info",
         %{conn: conn} do
      params = %{"filename" => "students.csv"}

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:ok)

      expected_response = %{
        "result" => %{
          "Dani" => 23.691406249999996,
          "Diego" => 23.043176366620376,
          "Gabu" => 23.020408163265305,
          "Rafael" => 24.913019885728875,
          "Rodrigo" => 26.327160493827158
        }
      }

      assert response === expected_response
    end

    test "when all params is invvalid, returns an error",
         %{conn: conn} do
      params = %{"filename" => "banana.csv"}

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:bad_request)

      expected_response = %{"result" => "Error while opening the file"}

      assert response === expected_response
    end
  end
end

defmodule Wabanex.IMCTest do
  use ExUnit.Case, async: true

  alias Wabanex.IMC

  describe "calculate/1" do
    test "when the file exists, returns the data" do
      params = %{"filename" => "students.csv"}

      response = IMC.calculate(params)

      expected_response = {:ok,
      %{
        "Dani" => 23.691406249999996,
        "Diego" => 23.043176366620376,
        "Gabu" => 23.020408163265305,
        "Rafael" => 24.913019885728875,
        "Rodrigo" => 26.327160493827158
      }}

      assert response === expected_response
    end
  end

    test "when the wrong name of file is given, returns an error" do
      params = %{"filename" => "banana.csv"}

      response = IMC.calculate(params)

      expected_response = {:error, "Error while opening the file"}

      assert response === expected_response
    end
end

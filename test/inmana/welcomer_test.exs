defmodule Inmana.WelcomerTest do
  use ExUnit.Case

  alias Faker.{Person, Random}
  alias Inmana.Welcomer

  describe "welcome/1" do
    test "when the user is special, returns a special message" do
      params = %{"name" => "banana", "age" => "42"}
      expected_result = {:ok, "You are very special banana"}

      result = Welcomer.welcome(params)

      assert result === expected_result
    end

    test "when the user is not special, returns a message" do
      name = Person.first_name()
      params = %{"name" => name, "age" => Integer.to_string(Random.Elixir.random_between(18, 99))}
      expected_result = {:ok, "Welcome #{String.downcase(name)}"}

      result = Welcomer.welcome(params)

      assert result === expected_result
    end

    test "when the user is under age, returns an error" do
      name = Person.first_name()

      params = %{
        "name" => name,
        "age" => Integer.to_string(Random.Elixir.random_between(1, 17))
      }

      expected_result = {:error, "You shall not pass #{String.downcase(name)}"}

      result = Welcomer.welcome(params)

      assert result === expected_result
    end
  end
end

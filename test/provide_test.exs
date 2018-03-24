defmodule ProvideTest do
  use ExUnit.Case
  doctest Provide

  test "greets the world" do
    assert Provide.hello() == :world
  end
end

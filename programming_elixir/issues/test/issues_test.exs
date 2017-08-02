defmodule ProgrammingElixirTest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [ 
    parse_args: 1,
    sort_into_ascending_order: 1,
    convert_to_list_of_maps: 1
  ]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h",     "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "three values returned if three given" do
    assert parse_args(["user", "project", "99"]) == { "user", "project", 99 }
  end

  test "count if defaulted if two values given" do
    assert parse_args(["user", "project"]) == { "user", "project", 4 }
  end

  test "sort ascending orders the correct way" do
    result = sort_into_ascending_order(convert_to_list_of_maps([
      [{"created_at", "c"}, {"other_data", "xxx"}],
      [{"created_at", "a"}, {"other_data", "xxx"}],
      [{"created_at", "b"}, {"other_data", "xxx"}]
    ]))

    issues = for issue <- result, do: issue["created_at"]
    assert issues == ["a", "b", "c"]
  end
end

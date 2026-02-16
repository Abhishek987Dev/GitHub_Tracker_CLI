defmodule GithubTrackerTest do
  use ExUnit.Case
  doctest GithubTracker

  test "greets the world" do
    assert GithubTracker.hello() == :world
  end
end

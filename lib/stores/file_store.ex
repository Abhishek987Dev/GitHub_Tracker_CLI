defmodule Stores.FileStore do
  @filePath "github-activity.json"
  def saveToLocal(path \\ @filePath) do
    Stores.MemoryStore.all() |>
    Enum.map(&Models.EventModel.to_map/1) |>
    Jason.encode!(pretty: true) |>
    then(&File.write!(path, &1))
  end

  def load_from_file(path \\ @filePath) do
    if File.exists?(path) do
      path |> File.read!()|> Jason.decode!() |> Enum.map(&Models.EventModel.from_map/1)
    end
  end
end

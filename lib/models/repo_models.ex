defmodule Models.RepoModels do
  defstruct [
    :id,
    :name,
    :url
  ]
  def to_map(%__MODULE__{} = repo) do
    Map.from_struct(repo)
  end

  def from_map(%{"id" => id, "name" => name, "url" => url}) do
    %__MODULE__{id: id, name: name, url: url}
  end
end

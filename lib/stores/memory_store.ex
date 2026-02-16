defmodule Stores.MemoryStore do
  use Agent
  
  def start_link(inital_state \\ []) do
    Agent.start_link(fn -> inital_state end, name: __MODULE__)
  end

  def add(model) do
    Agent.update(
      __MODULE__,
      fn models -> [model | models] end
    )
  end

  def delete(id) do
    Agent.update(
      __MODULE__,
      fn models ->
        Enum.reject(models, fn model ->
          model.id == id
        end)
      end
    )
  end

  def get_and_update(func) do
    Agent.get_and_update(__MODULE__, func)
  end

  def all do
    Agent.get(
      __MODULE__,
      & &1
    )
  end
end

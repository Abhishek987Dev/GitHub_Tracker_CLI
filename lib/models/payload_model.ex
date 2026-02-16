defmodule Models.PayloadModel do
  defstruct [
    :repository_id,
    :push_id,
    :ref,
    :head,
    :before,
    :action
  ]
  def to_map(%__MODULE__{} = payload) do
    Map.from_struct(payload)
  end

  def from_map(%{
    "repository_id" => repository_id,
    "push_id" => push_id,
    "ref" => ref,
    "head" => head,
    "before" => before
  } = map) do
    %__MODULE__{
      repository_id: repository_id,
      push_id: push_id,
      ref: ref,
      head: head,
      before: before,
      action: map["action"]
    }
  end
end

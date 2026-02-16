defmodule Models.EventModel do
  defstruct [
    :id,
    :eventType,
    :public,
    :createdAt,
    :summary,
    actor: %Models.ActorModel{},
    payload: %Models.PayloadModel{},
    repo: %Models.RepoModels{}
  ]

  def to_map(%__MODULE__{} = event) do
    Map.from_struct(event)
  end

  def from_map(%{
    "id" => id,
    "type" => type,
    "public" => public,
    "created_at" => created_at,
    "actor" => actor,
    "payload" => payload,
    "repo" => repo
  } = event) do
    %__MODULE__{
      id: id,
      eventType: type,
      public: public,
      createdAt: created_at,
      summary: describe_event(event),
      actor: Models.ActorModel.from_map(actor),
      payload: Models.PayloadModel.from_map(payload),
      repo: Models.RepoModels.from_map(repo)
    }
  end

  defp describe_event(%{"type" => "PushEvent"} = event) do
    branch = event["payload"]["ref"] |> String.replace("refs/heads/", "")
    "Pushed to #{event["repo"]["name"]} on branch #{branch}"
  end

  defp describe_event(%{"type" => "PullRequestEvent"} = event) do
    "#{String.capitalize(event["payload"]["action"])} a pull request in #{event["repo"]["name"]}"
  end

  defp describe_event(%{"type" => "IssuesEvent"} = event) do
    "#{String.capitalize(event["payload"]["action"])} an issue in #{event["repo"]["name"]}"
  end

  defp describe_event(%{"type" => "WatchEvent"} = event), do: "Starred #{event["repo"]["name"]}"
  defp describe_event(%{"type" => "ForkEvent"} = event), do: "Forked #{event["repo"]["name"]}"
  defp describe_event(event), do: "#{event["type"]} on #{event["repo"]["name"]}"
end

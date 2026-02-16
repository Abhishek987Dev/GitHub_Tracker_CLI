defmodule WebserviceHandler.ApiDtoHandler do
  def parseResponse([]) do
    {:error, []}
  end

  def parseResponse(data) do
    {:ok,
     Enum.map(data, fn event ->
       actor =
         struct(
           Models.ActorModel,
           %{
             id: event["actor"]["id"],
             login_user: event["actor"]["login"],
             display_login: event["actor"]["display_login"],
             gravatar_id: event["actor"]["url"],
             url: event["actor"]["url"],
             avatar_url: event["actor"]["avatar_url"]
           }
         )

       payload =
         struct(
           Models.PayloadModel,
           %{
             repository_id: event["payload"]["repository_id"],
             push_id: event["payload"]["push_id"],
             ref: event["payload"]["ref"],
             head: event["payload"]["head"],
             before: event["payload"]["before"],
             action: event["payload"]["action"]
           }
         )

       repo =
         struct(
           Models.RepoModels,
           %{
             id: event["repo"]["id"],
             name: event["repo"]["name"],
             url: event["repo"]["url"]
           }
         )

       event_model =
         struct(Models.EventModel, %{
           id: event["id"],
           eventType: event["type"],
           public: event["public"],
           createdAt: event["created_at"],
           summary: describe_event(event),
           actor: actor,
           payload: payload,
           repo: repo
         })
        Stores.MemoryStore.add(event_model)
        event_model
     end)}
  end

  defp describe_event(%{"type" => "PushEvent"} = event) do
    branch = event["payload"]["ref"] |> String.replace("refs/heads/", "")
    "Pushed to #{event["repo"]["name"]} on branch #{branch}"
  end

  defp describe_event(%{"type" => "PullRequestEvent"} = event) do
    action = event["payload"]["action"]
    "#{String.capitalize(action)} a pull request in #{event["repo"]["name"]}"
  end

  defp describe_event(%{"type" => "IssuesEvent"} = event) do
    action = event["payload"]["action"]
    "#{String.capitalize(action)} an issue in #{event["repo"]["name"]}"
  end

  defp describe_event(%{"type" => "WatchEvent"} = event) do
    "Starred #{event["repo"]["name"]}"
  end

  defp describe_event(%{"type" => "ForkEvent"} = event) do
    "Forked #{event["repo"]["name"]}"
  end

  defp describe_event(event) do
    "#{event["type"]} on #{event["repo"]["name"]}"
  end
end

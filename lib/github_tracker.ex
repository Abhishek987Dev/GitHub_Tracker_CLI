defmodule GithubTracker do

  def load_from_file_to_mem() do
    inital_activity = Stores.FileStore.load_from_file()
    if Process.whereis(Stores.MemoryStore) == nil do
      Stores.MemoryStore.start_link(inital_activity)
    end
  end


  defp getData(username) do
    case WebserviceHandler.ApiHandler.fetchData(username) do
      {:ok, data} ->
        case WebserviceHandler.ApiDtoHandler.parseResponse(data) do
          {:ok, dataModel} ->
            case Ui.CliUi.display(dataModel) do
              {:ok, rendered} ->
                IO.puts(rendered)
              {:error, err} ->
                IO.puts("error: #{err}")
            end
        end
      {:error, reason} ->
        IO.puts("error: #{reason}")
        []
    end
  end

  defp print_help_command do
    IO.puts("""
    GitHub Activity Tracker CLI

    Commands:
      github_tracker get-activity <github_username>
      github_tracker help
    """)
  end

  def main(args \\ System.argv()) do
    Application.ensure_all_started(:req)
    load_from_file_to_mem()
    case args do
      ["get-activity", username] ->
        getData(username)
      ["help"] ->
        print_help_command()
      _ ->
        IO.puts("invalid arguments, please put the valid one")
    end
  end
end

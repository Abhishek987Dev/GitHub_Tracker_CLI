

defmodule WebserviceHandler.ApiHandler do
  alias Req
  alias Jason

  def fetchData("") do
    {:error, "username cannot be empty"}
  end


  def fetchData(username) do
    base_url = "https://api.github.com/users/#{username}/events"
    with {:ok, response} <- Req.get(base_url) do
      if response.status == 200 do
        {:ok, response.body}
      else
        {:error, "API request failed with status: #{response.status}"}
      end
    end
  end
end

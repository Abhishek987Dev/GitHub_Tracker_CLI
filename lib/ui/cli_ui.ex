defmodule Ui.CliUi do
  alias TableRex.Table

  def display({}) do
    {:error, "Internal Error Happned"}
  end


  def display(models) do
    {:ok, Enum.map(models, fn event ->
      [
        event.id,
        event.actor.login_user,
        event.eventType,
        event.summary
      ]
    end) |> Table.new(["Id", "Name", "Event", "Mesasge"])|> Table.render!()}
  end
end

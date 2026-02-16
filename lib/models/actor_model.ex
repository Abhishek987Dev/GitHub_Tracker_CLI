defmodule Models.ActorModel do
  defstruct [
    :id,
    :login_user,
    :display_login,
    :gravatar_id,
    :url,
    :avatar_url
  ]

  def to_map(%__MODULE__{} = actor) do
    Map.from_struct(actor)
  end

  def from_map(%{
    "id" => id,
    "login" => login,
    "display_login" => display_login,
    "gravatar_id" => gravatar_id,
    "url" => url,
    "avatar_url" => avatar_url
  }) do
    %__MODULE__{
      id: id,
      login_user: login,
      display_login: display_login,
      gravatar_id: gravatar_id,
      url: url,
      avatar_url: avatar_url
    }
  end
end

defmodule Peeping.Guardian do
  use Guardian, otp_app: :peeping

  alias Peeping.{Repo, User}

  def subject_for_token(resource, _claims) do
    sub = to_string(resource.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["bearer"]
    resource = Repo.get_by(User, id: id)
    {:ok, resource}    
  end

end
defmodule PeepingWeb.ChangesetView do
  use PeepingWeb, :view

  def render("error.json", %{changeset: changeset}) do
    JaSerializer.EctoErrorSerializer.format(changeset)    
  end
end
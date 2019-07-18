defmodule Source do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:site, :string)
    field(:name, :string)
  end

  @required_fields ~w(site name)a

  def source_changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end
end

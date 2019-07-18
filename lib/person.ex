defmodule Person do
  use Ecto.Schema
  import Ecto.Changeset
  import Source

  @type t :: %__MODULE__{
          birthday: String.t(),
          name: String.t()
        }

  @primary_key false
  embedded_schema do
    field(:birthday, :date)
    field(:name, :string)

    embeds_many(:sources, Source)

    # alternatively we can embedd like this
    embeds_many :identifiers, Identifier do
      field(:value, :string)
    end
  end

  # @spec call(String.t()) :: {:ok, struct} | {:error, struct}
  def json_conversion(json_string) when is_binary(json_string) do
    with {:ok, jsonMap} <- Poison.decode(json_string),
         {:ok, struct} <- changeset(jsonMap) |> apply_action(:insert) do
      {:ok, struct}
    end
  end

  defp changeset(params) do
    %__MODULE__{}
    |> cast(params, [:birthday, :name])
    |> cast_embed(:identifiers, required: true, with: &identifier_changeset/2)
    |> cast_embed(:sources, required: true, with: &source_changeset/2)
    |> validate_required([:birthday, :name, :sources])
    |> validate_length(:sources, min: 1)
  end

  def identifier_changeset(model, params \\ %{}) do
    model
    |> cast(params, [:value])
    |> validate_required([:value])
  end
end

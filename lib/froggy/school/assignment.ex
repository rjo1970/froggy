defmodule Froggy.School.Assignment do
  use Ecto.Schema
  import Ecto.Changeset


  schema "assignments" do
    field :description, :string
    field :due_date, :date
    field :student, :string
    field :subject, :string
    field :done, :boolean

    timestamps()
  end

  @doc false
  def changeset(assignment, attrs) do
    assignment
    |> cast(attrs, [:student, :subject, :description, :due_date, :done])
    |> validate_required([:student, :subject, :description, :due_date])
  end
end

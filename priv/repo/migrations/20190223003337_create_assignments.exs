defmodule Froggy.Repo.Migrations.CreateAssignments do
  use Ecto.Migration

  def change do
    create table(:assignments) do
      add :student, :string, null: false
      add :subject, :string, null: false
      add :description, :text, null: false
      add :due_date, :date, null: false
      add :done, :boolean, null: false, default: false
      
      timestamps()
    end

    create index(:assignments, [:student, :due_date, :done])

  end
end

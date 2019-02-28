defmodule Froggy.School do
  @moduledoc """
  The School context.
  """

  import Ecto.Query, warn: false
  alias Froggy.Repo

  alias Froggy.School.Assignment

  @doc """
  Returns the list of assignments.

  ## Examples

  iex> list_assignments()
  [%Froggy.School.Assignment{}, ...]

  """
  def list_assignments do
    Repo.all(Assignment)
  end

  @doc """
  Gets a single assignment.

  Raises `Ecto.NoResultsError` if the Assignment does not exist.

  ## Examples

      iex> get_assignment!(123)
      %Froggy.School.Assignment{}

      iex> get_assignment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_assignment!(id), do: Repo.get!(Assignment, id)

  @doc """
  Creates a assignment.

  ## Examples

      iex> create_assignment(%{field: value})
      {:ok, %Froggy.School.Assignment{}}

      iex> create_assignment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_assignment(attrs \\ %{}) do
    %Assignment{}
    |> Assignment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a assignment.

  ## Examples

      iex> update_assignment(assignment, %{field: new_value})
      {:ok, %Froggy.School.Assignment{}}

      iex> update_assignment(assignment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_assignment(%Assignment{} = assignment, attrs) do
    assignment
    |> Assignment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Assignment.

  ## Examples

      iex> delete_assignment(assignment)
      {:ok, %Froggy.School.Assignment{}}

      iex> delete_assignment(assignment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_assignment(%Assignment{} = assignment) do
    Repo.delete(assignment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking assignment changes.

  ## Examples

      iex> change_assignment(assignment)
      %Ecto.Changeset{data: %Froggy.School.Assignment{}}

  """
  def change_assignment(%Assignment{} = assignment) do
    Assignment.changeset(assignment, %{})
  end

  @doc """
    All current assignments, most dire first
  """

  def dire_assignments() do
    from(a in Assignment, where: a.done == ^false, order_by: [a.due_date, a.student])
    |> Repo.all()
  end

  @doc """
    Given an assignment, return number of days until due.
  """

  def days_due(%Froggy.School.Assignment{} = assignment) do
    now = Timex.now("EST5EDT")
    due = assignment.due_date |> Timex.to_datetime("EST5EDT")
    (DateTime.diff(due, now) / 86400) |> trunc() |> max(0)
  end

  def completion_window(%Froggy.School.Assignment{} = assignment) do
    now = Timex.now("EST5EDT")

    knew_at =
      assignment.inserted_at
      |> Timex.to_datetime("UTC")

    due =
      assignment.due_date
      |> Timex.to_datetime("EST5EDT")

    whole_time = DateTime.diff(knew_at, due)
    remain_time = DateTime.diff(now, due)

    (remain_time / whole_time * 100)
    |> trunc()
    |> max(0)
  end

  def weekday_due(assignment) do
    dow =
      ~w(Sunday Monday Tuesday Wednesday Thursday Friday Saturday)
      |> Enum.with_index()
      |> Enum.map(fn {a, b} -> {b, a} end)
      |> Map.new()

    {day, _} = Date.day_of_era(assignment.due_date)

    day_index = rem(day, 7)

    dow[day_index]
  end

  def complete(assignment_id) do
    get_assignment!(assignment_id)
    |> update_assignment(%{done: true})
  end
end

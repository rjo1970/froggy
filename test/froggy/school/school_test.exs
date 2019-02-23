defmodule Froggy.SchoolTest do
  use Froggy.DataCase

  alias Froggy.School

  describe "assignments" do
    alias Froggy.School.Assignment

    @valid_attrs %{
      description: "some description",
      due_date: ~D[2010-04-17],
      student: "some student",
      subject: "some subject",
      done: false
    }
    @update_attrs %{
      description: "some updated description",
      due_date: ~D[2011-05-18],
      student: "some updated student",
      subject: "some updated subject",
      done: true
    }
    @invalid_attrs %{description: nil, due_date: nil, student: nil, subject: nil, done: "bozo"}

    def assignment_fixture(attrs \\ %{}) do
      {:ok, assignment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> School.create_assignment()

      assignment
    end

    test "list_assignments/0 returns all assignments" do
      assignment = assignment_fixture()
      assert School.list_assignments() == [assignment]
    end

    test "get_assignment!/1 returns the assignment with given id" do
      assignment = assignment_fixture()
      assert School.get_assignment!(assignment.id) == assignment
    end

    test "create_assignment/1 with valid data creates a assignment" do
      assert {:ok, %Assignment{} = assignment} = School.create_assignment(@valid_attrs)
      assert assignment.description == "some description"
      assert assignment.due_date == ~D[2010-04-17]
      assert assignment.student == "some student"
      assert assignment.subject == "some subject"
    end

    test "create_assignment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = School.create_assignment(@invalid_attrs)
    end

    test "update_assignment/2 with valid data updates the assignment" do
      assignment = assignment_fixture()

      assert {:ok, %Assignment{} = assignment} =
               School.update_assignment(assignment, @update_attrs)

      assert assignment.description == "some updated description"
      assert assignment.due_date == ~D[2011-05-18]
      assert assignment.student == "some updated student"
      assert assignment.subject == "some updated subject"
    end

    test "update_assignment/2 with invalid data returns error changeset" do
      assignment = assignment_fixture()
      assert {:error, %Ecto.Changeset{}} = School.update_assignment(assignment, @invalid_attrs)
      assert assignment == School.get_assignment!(assignment.id)
    end

    test "delete_assignment/1 deletes the assignment" do
      assignment = assignment_fixture()
      assert {:ok, %Assignment{}} = School.delete_assignment(assignment)
      assert_raise Ecto.NoResultsError, fn -> School.get_assignment!(assignment.id) end
    end

    test "change_assignment/1 returns a assignment changeset" do
      assignment = assignment_fixture()
      assert %Ecto.Changeset{} = School.change_assignment(assignment)
    end
  end
end

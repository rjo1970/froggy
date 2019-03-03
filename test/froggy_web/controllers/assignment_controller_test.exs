defmodule FroggyWeb.AssignmentControllerTest do
  use FroggyWeb.ConnCase

  alias Froggy.School

  @create_attrs %{
    description: "some description",
    due_date: ~D[2010-04-17],
    student: "some student",
    subject: "some subject"
  }
  @update_attrs %{
    description: "some updated description",
    due_date: ~D[2011-05-18],
    student: "some updated student",
    subject: "some updated subject"
  }
  @invalid_attrs %{description: nil, due_date: nil, student: nil, subject: nil}

  def fixture(:assignment) do
    {:ok, assignment} = School.create_assignment(@create_attrs)
    assignment
  end

  describe "index" do
    test "lists all assignments", %{conn: conn} do
      conn = get(conn, Routes.assignment_path(conn, :index))
      assert html_response(conn, 200) =~ "All Assignments"
    end
  end

  describe "new assignment" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.assignment_path(conn, :new))
      assert html_response(conn, 200) =~ "New Assignment"
    end
  end

  describe "create assignment" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.assignment_path(conn, :create), assignment: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.assignment_path(conn, :show, id)

      conn = get(conn, Routes.assignment_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Assignment"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.assignment_path(conn, :create), assignment: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Assignment"
    end
  end

  describe "edit assignment" do
    setup [:create_assignment]

    test "renders form for editing chosen assignment", %{conn: conn, assignment: assignment} do
      conn = get(conn, Routes.assignment_path(conn, :edit, assignment))
      assert html_response(conn, 200) =~ "Edit Assignment"
    end
  end

  describe "update assignment" do
    setup [:create_assignment]

    test "redirects when data is valid", %{conn: conn, assignment: assignment} do
      conn =
        put(conn, Routes.assignment_path(conn, :update, assignment), assignment: @update_attrs)

      assert redirected_to(conn) == Routes.assignment_path(conn, :show, assignment)

      conn = get(conn, Routes.assignment_path(conn, :show, assignment))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, assignment: assignment} do
      conn =
        put(conn, Routes.assignment_path(conn, :update, assignment), assignment: @invalid_attrs)

      assert html_response(conn, 200) =~ "Edit Assignment"
    end
  end

  describe "delete assignment" do
    setup [:create_assignment]

    test "deletes chosen assignment", %{conn: conn, assignment: assignment} do
      conn = delete(conn, Routes.assignment_path(conn, :delete, assignment))
      assert redirected_to(conn) == Routes.assignment_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.assignment_path(conn, :show, assignment))
      end
    end
  end

  defp create_assignment(_) do
    assignment = fixture(:assignment)
    {:ok, assignment: assignment}
  end
end

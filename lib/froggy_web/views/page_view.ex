defmodule FroggyWeb.PageView do
  use FroggyWeb, :view

  def days(days) do
    cond do
      days > 1 -> "days"
      days == 1 -> "day"
      days < 1 -> "days"
    end
  end
end

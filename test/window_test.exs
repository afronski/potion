defmodule WindowTest do
  use ExUnit.Case
  alias Potion.UI.Controls.Window

  test "window should contain a centered title" do
    title = "TEST"
    title_length = String.length(title)
    width = 40

    result = Window.new(width, 1) |> Window.title(title)
    title_line = List.first(Window.lines(result))

    assert String.length(title_line) - title_length == width - title_length

    String.split(title_line, title) |> Enum.each(fn part ->
      assert String.strip(part) == ""
      assert String.length(part) == (width - title_length) / 2
    end)
  end

  test "window should have proper height and width" do
    width = 20
    height = 5

    result = Window.new(width, height)
    lines = Window.lines(result)

    assert Enum.count(lines) == height

    lines |> Enum.each(fn part ->
      assert String.length(part) == width
    end)
  end
end

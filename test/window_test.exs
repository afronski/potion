defmodule WindowTest do
  use ExUnit.Case
  alias Potion.UI.Controls.Window

  test "empty window should have proper height and width" do
    width = 20
    height = 5

    result = Window.new(width, height)
    lines = Window.lines(result)

    assert Enum.count(lines) == height

    lines |> Enum.each(fn part ->
      assert String.length(part) == Window.get_width(result)
    end)
  end

  test "window should contain a centered title" do
    title = "TEST"
    title_length = String.length(title)

    width = 40
    height = 5

    result = Window.new(width, height) |> Window.title(title)
    title_line = List.first(Window.lines(result))

    actual_width = Window.get_width(result)
    assert String.length(title_line) - title_length == actual_width - title_length

    String.split(title_line, title) |> Enum.each(fn part ->
      assert String.strip(part) == ""
      assert String.length(part) == (actual_width - title_length) / 2
    end)
  end

  test "window should have two separators" do
    width = 20
    height = 5

    result = Window.new(width, height)

    separator1 = Enum.at(Window.lines(result), 1)
    separator2 = Enum.at(Window.lines(result), -3)

    assert separator1 == String.duplicate("-", Window.get_width(result))
    assert separator2 == String.duplicate("-", Window.get_width(result))
  end

  test "window should have footer with help and exit" do
    width = 20
    height = 5

    result = Window.new(width, height)
    [ help, exit ] = Enum.slice(Window.lines(result), -2, 2)

    assert String.strip(help) == "HELP"
    assert String.strip(exit) == "EXIT"
  end

  test "window with content should have proper width" do
    width = 20
    height = 8

    result = Window.new(width, height)
    lines = Window.lines(%Window{result | content: ["AAA", "BBB", "CCC"]})

    lines |> Enum.each(fn part ->
      assert String.length(part) == Window.get_width(result)
    end)
  end
end

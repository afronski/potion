defmodule Potion.UI.Controls.Window do
  alias Potion.UI.Colors
  alias Potion.UI.Controls.Window

  defstruct width: 40, height: 10, colors: %Colors{}, title: "", content: []

  def new(width, height) do
    %Window{width: width, height: height}
  end

  def title(window, title) do
    %Window{window | title: title}
  end

  def lines(window) do
    List.flatten([
      prepare_title(window),
      prepare_content(window.height - 1, window.width, window.content)
    ])
  end

  def draw(window) do
    Window.lines(window) |> Enum.each(fn line ->
      IO.puts format(window.colors) <> line
    end)
  end

  defp prepare_title(%Window{colors: colors, width: width, title: title}) do
    fill = round((width - String.length(title)) / 2)
    String.duplicate(" ", fill) <> title <> String.duplicate(" ", fill)
  end

  defp prepare_content(amount, width, content) do
    List.duplicate(String.duplicate(" ", width), amount) |> Enum.with_index |> Enum.map(fn {default, index} ->
      Enum.at(content, index, default)
    end)
  end

  defp format(colors) do
    background = apply(IO.ANSI, String.to_atom(colors.background <> "_background"), [])
    foreground = apply(IO.ANSI, String.to_atom(colors.foreground), [])

    background <> foreground
  end
end

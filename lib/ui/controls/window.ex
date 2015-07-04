defmodule Potion.UI.Controls.Window do
  alias Potion.UI.Colors
  alias Potion.UI.Controls.Window

  defstruct width: 40, height: 5, colors: %Colors{}, title: "", content: [], margin: 2, padding: 2

  def new(width, height) when height >= 5 do
    %Window{width: width, height: height}
  end

  def new(width) do
    %Window{width: width}
  end

  def title(window, title) do
    %Window{window | title: title}
  end

  def add_content(window, line) do
    %Window{window | content: window.content ++ [ line ], height: window.height + 1}
  end

  def lines(window) do
    width = get_width(window)

    List.flatten([
      prepare_title(window.title, width),
      prepare_separator(width),
      prepare_content(window.height - 5, width, window.content),
      prepare_separator(width),
      prepare_footer(width)
    ])
  end

  def get_width(%Window{width: width, padding: size}) do
    width - 2 * size
  end

  def draw(window) do
    IO.ANSI.clear()

    empty_line
    empty_line(window)

    Window.lines(window) |> Enum.each(fn line ->
      line_with_content(window, line)
    end)

    empty_line(window)
  end

  defp prepare_title(title, width) do
    calculated = width - String.length(title)

    {left_fill, right_fill} = case rem(calculated, 2) do
                                0 ->
                                  value = round(calculated / 2)
                                  {value, value}

                                _ ->
                                  value = Float.floor(calculated / 2)
                                  {round(value), round(value) + 1}
                              end

    String.duplicate(" ", left_fill) <> title <> String.duplicate(" ", right_fill)
  end

  defp prepare_separator(width) do
    String.duplicate("-", width)
  end

  defp prepare_footer(width) do
    [
        "HELP" <> String.duplicate(" ", width - 4),
        "EXIT" <> String.duplicate(" ", width - 4)
    ]
  end

  defp prepare_content(amount, width, content) do
    List.duplicate(String.duplicate(" ", width), amount) |> Enum.with_index |> Enum.map(fn {default, index} ->
      value = Enum.at(content, index, default)
      length = String.length(value)

      value <> String.duplicate(" ", width - length)
    end)
  end

  defp margin(size) do
    String.duplicate(" ", size)
  end

  defp padding(size) do
    String.duplicate(" ", size)
  end

  defp padded(content, size) do
    padding(size) <> content <> padding(size)
  end

  defp empty_line, do: IO.puts("")
  defp empty_line(%Window{colors: colors, margin: size, padding: padding} = window) do
    IO.puts margin(size) <> format(colors) <> padded(String.duplicate(" ", get_width(window)), padding) <> unformat
  end

  defp line_with_content(%Window{colors: colors, margin: size, padding: padding}, content) do
    IO.puts margin(size) <> format(colors) <> padded(content, padding) <> unformat
  end

  defp format(colors) do
    background = apply(IO.ANSI, String.to_atom(colors.background <> "_background"), [])
    foreground = apply(IO.ANSI, String.to_atom(colors.foreground), [])

    background <> foreground
  end

  defp unformat do
    IO.ANSI.default_background() <> IO.ANSI.default_color()
  end
end

defmodule Potion.CLI do
  alias Potion.UI.Controls.Window

  def run(name, args) do
    args
    |> parse_args
    |> decide(name)
  end

  defp parse_args(args) do
    options = OptionParser.parse(args)

    case options do
      _ -> :help
    end
  end

  defp decide(:help, name) do
    Window.new(80, 20)
    |> Window.title(name)
    |> Window.draw

    System.halt(0)
  end
end

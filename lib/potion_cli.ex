defmodule Potion.CLI do
  def run(name, args) do
    args
    |> parse_args
    |> decide(name)
  end

  defp parse_args(args) do
    options = OptionParser.parse(args)

    IO.inspect(options)

    case options do
      _ -> :help
    end
  end

  defp decide(:help, name) do
    IO.puts "HALP FROM #{name}!"

    System.halt(0)
  end
end
defmodule Identicon.CLI do
  @moduledoc """
  Handle the command line parsing and dispatch to a function that will generate an identicon
  """

  def main(argv) do
    argv
    |> parse_args
    |> process
  end


  @doc """
    Parse command line arguments.
    Returns :help if user runs the program with --help flag, or if user provides no arguments, or if user provides more then 1 argument.
    Otherwise returns the provided argument as string.
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean])

    case parse do
      { [help: true], _, _} -> :help
      {_, [name], _} -> name
      _ -> :help
    end
  end


  @doc """
    Output instructions to the terminal
  """
  def process(:help) do
    IO.puts "Usage: identicon <name>"
    System.halt(0)
  end


  @doc """
    Call Identicon.create/1 passing name as an argument
  """
  def process(name) do
    Identicon.Create.main(name)
  end
end
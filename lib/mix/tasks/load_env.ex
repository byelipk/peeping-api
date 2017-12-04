defmodule Mix.Tasks.LoadEnv do
  use Mix.Task

  @shortdoc "Loads environment variables"
  def run(_) do
    IO.puts "Loading .env"
    System.cmd("source", [".env"])
  end
end


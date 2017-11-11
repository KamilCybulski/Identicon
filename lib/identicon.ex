defmodule Identicon do
  @moduledoc """
  Provides funtion `main/1` to create identicons
  """

  @doc """
  Creates an identicon based on the provided string

  ## Parameters
    
    - input: String that is used to generate identicon
  """
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> create_image
  end

  defp hash_input(input) do
    input
  end

  defp pick_color(data) do
    data
  end

  defp build_grid(data) do
    data
  end

  defp create_image(data) do
    data
  end
end

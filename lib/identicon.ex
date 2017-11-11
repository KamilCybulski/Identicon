defmodule Identicon do
  @moduledoc """
  Provides funtion `main/1` to create identicons
  """

  @doc """
  Creates an identicon based on the provided string

  ## Parameters
    
    - input: string
  """
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> create_image
  end

  # String -> Struct(Image)
  defp hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{ hex: hex }
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

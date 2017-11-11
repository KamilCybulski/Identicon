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
  end


  # String -> Struct(Image)
  # Create an Image struct with hashed string as 'hex' property
  defp hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end


  # Struct(Image) -> Struct(Image)
  # Create an Image struct with a tri-element tuple as 'color' property
  defp pick_color(%Identicon.Image{hex: [r, g, b | _]} = data) do
    %Identicon.Image{data | color: {r, g, b}}
  end


  # Struct(Image) -> Struct(Image)
  # Create an Image struct with a 25 element list that represents identicon
  # image grid
  defp build_grid(%Identicon.Image{hex: hex} = data) do
    grid = 
      hex
      |> Stream.chunk_every(3, 3, :discard)
      |> Stream.flat_map(&mirror_row/1)
      |> Stream.with_index
      |> Stream.filter(fn {num, _} -> rem(num, 2) == 0 end)
      |> Enum.to_list

    %Identicon.Image{ data | grid: grid }
  end


  # List -> List
  # Note: Provided list should have only 3 elements
  # Create a 5 element list that represents one row in identicon's image grid
  defp mirror_row([first, second | _] = row) do
    row ++ [second, first]
  end

  defp create_image(data) do
    data
  end
end

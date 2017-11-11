defmodule Identicon.Create do
  @moduledoc """
  Provides funtion `create/1` to create identicons
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
    |> build_pixel_map
    |> draw_image
    |> save_image(input)
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

    %Identicon.Image{data | grid: grid}
  end


  # List -> List
  # Note: Provided list should have only 3 elements
  # Create a 5 element list that represents one row in identicon's image grid
  defp mirror_row([first, second | _] = row) do
    row ++ [second, first]
  end


  # Struct(Image) -> Struct(Image)
  # Create an Image struct with a pixel_map property that represents
  # the coordinates of each 50x50 px square in the identicon image
  defp build_pixel_map(%Identicon.Image{grid: grid} = data) do
    pixel_map = Enum.map grid, fn {_, index} ->
      horizontal = rem(index, 5) * 50
      vertical = div(index, 5) * 50
      top_left = {horizontal, vertical}
      bottom_rigth = {horizontal + 50, vertical + 50}

      {top_left, bottom_rigth}
    end

    %Identicon.Image{data | pixel_map: pixel_map}
  end


  # Struct(Image) -> image(png)
  # Draw the image based on the pixel_map
  defp draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    color = :egd.color(color)

    Enum.each pixel_map, fn ({top_left, bot_right}) ->
      :egd.filledRectangle(image, top_left, bot_right, color)
    end

    :egd.render(image)
  end


  #image(png), string -> ???
  # Save given image to the disk
  defp save_image(img, input) do
    File.write("#{input}.png", img)
  end
end

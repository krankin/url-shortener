defmodule Helpers.SlugGenerator do

  def generate(length) do    
    :crypto.strong_rand_bytes(length) |> Base.url_encode64 |> binary_part(0, length)
  end  
end
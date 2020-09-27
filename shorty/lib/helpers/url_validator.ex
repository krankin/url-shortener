defmodule Helpers.UrlValidator do

  def is_valid?(url) do    
    uri = URI.parse(url)
    uri.scheme != nil && uri.host != nil
  end  
end
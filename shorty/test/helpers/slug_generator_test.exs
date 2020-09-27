defmodule Helpers.SlugGeneratorTest do
   use ExUnit.Case, async: true
   alias Helpers.SlugGenerator

   test "Generates a slug of defined length" do 
     slug = SlugGenerator.generate(8)
     assert 8 = String.length(slug) 

     slug2 = SlugGenerator.generate(5)
     assert 5 = String.length(slug2) 
   end

   test "Slug is URL safe" do
     slug = SlugGenerator.generate(8)
     assert true = validate_url(slug)
   end

   defp validate_url(<<head,rest::binary>>) do
    if URI.char_reserved?(head) || !URI.char_unescaped?(head) do
      false
    else
      validate_url(rest)
    end 
   end
   
   defp validate_url(<<>>)
   do
    true
   end
  
end
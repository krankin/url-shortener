defmodule Helpers.UrlValidatorTest do
   use ExUnit.Case, async: true
   alias Helpers.UrlValidator

   test "returns true for a valid url" do
     assert UrlValidator.is_valid?("http://google.com")
   end

   test "returns false when missing a scheme" do
     refute UrlValidator.is_valid?("google.com")
   end
end
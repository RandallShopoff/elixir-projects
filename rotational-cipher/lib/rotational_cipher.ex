defmodule RotationalCipher do
  @moduledoc """
    Author: Randall Shopoff
    Date:   March 15, 2020
  """
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    String.to_charlist(text)
    |> List.foldl("", fn char, acc ->
      acc <> encode(char, shift)
    end)
  end

  # encode takes the real character and encodes with
  # the shift.
  defp encode(char, shift) do
    cond do
      # Encode uppercase letters
      char in ?A..?Z ->
        List.to_string([rem(char - ?A + shift, 26) + ?A])

      # Encode lowercase letters
      char in ?a..?z ->
        List.to_string([rem(char - ?a + shift, 26) + ?a])

      # Preserve numbers
      char in ?0..?9 ->
        List.to_string([char])

      # Preserve punctuation and spaces
      char == 32 ->
        " "

      char == 33 ->
        "!"

      char == 39 ->
        "'"

      char == 44 ->
        ","

      char == 46 ->
        "."
    end
  end
end

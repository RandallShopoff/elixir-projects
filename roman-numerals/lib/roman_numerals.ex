defmodule RomanNumerals do
  @moduledoc """

    Author: Randall Shopoff
    Date: March 17, 2020

  """
  @doc """
  Convert the number to a roman number.
  """
  # @exponents holds the Roman symbol compliment
  # of our arabic equivalent.
  @magnitudes %{
    1000 => {900, "M"},
    900 => {500, "CM"},
    500 => {400, "D"},
    400 => {100, "CD"},
    100 => {90, "C"},
    90 => {50, "XC"},
    50 => {40, "L"},
    40 => {10, "XL"},
    10 => {9, "X"},
    9 => {5, "IX"},
    5 => {4, "V"},
    4 => {1, "IV"},
    1 => {0, "I"}
  }

  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    to_roman(number, "", 1000)
  end

  # Skip magnitudes where the factor is 0; e.g.,
  # where 20 = 2(factor) x 10(magnitude), there
  # is no need for processing magnitude = 1.
  # Magnitude of 0 is stopping criteria.
  defp skip_mags(_number, 0), do: [0, 0, ""]

  # If magnitude > 0...
  defp skip_mags(number, magnitude) do
    # using integer division find out wht the factor is..
    factor = Kernel.div(number, magnitude)

    # retrieve the next roman-based magnitude and corresonding
    # symbol.
    {next_mag, symbol} = @magnitudes[magnitude]

    # If factor != 0, do work; otherwise, factor is 0. Continue
    # to search number where other non-zero factors exist.
    if factor != 0, do: [factor, magnitude, symbol], else: skip_mags(number, next_mag)
  end

  # At this point, magnitude = 0 so return the converted number
  defp to_roman(_number, roman, 0), do: roman

  # If magnitude != 0...
  defp to_roman(number, roman, magnitude) do
    # skip to magnitudes where factor != 0...
    [factor, magnitude, symbol] = skip_mags(number, magnitude)

    # convert from arabic to roman numerals
    [number, roman, magnitude] = convert_to_roman(number, roman, symbol, factor, magnitude)

    # repeat and rinse
    to_roman(number, roman, magnitude)
  end

  # If magnitude = 0, just pass the roman numeral back to caller..
  defp convert_to_roman(_number, roman, _symbol, _factor, 0), do: [0, roman, 0]

  defp convert_to_roman(number, roman, symbol, factor, magnitude) do
    # remainder will be the next number for the recursion
    next_number = Kernel.rem(number, magnitude)

    # Update the conversion string.
    update_roman = roman <> String.duplicate(symbol, factor)

    # retrieve next arabic magnitude.
    {next_mag, _symbol} = @magnitudes[magnitude]

    # Recurse back using the updated conversion string.
    [next_number, update_roman, next_mag]
  end
end

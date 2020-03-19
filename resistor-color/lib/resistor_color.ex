defmodule ResistorColor do
  @moduledoc """

    Author: Randall Shopoff
    Date: March 18, 2020

  """

  @colors [
    "black",
    "brown",
    "red",
    "orange",
    "yellow",
    "green",
    "blue",
    "violet",
    "grey",
    "white"
  ]

  @spec colors() :: list(String.t())
  def colors do
    @colors
  end

  @spec code(String.t()) :: integer()
  def code("black"), do: Enum.find_index(@colors, &(&1 == "black"))
  def code("brown"), do: Enum.find_index(@colors, &(&1 == "brown"))
  def code("red"), do: Enum.find_index(@colors, &(&1 == "red"))
  def code("orange"), do: Enum.find_index(@colors, &(&1 == "orange"))
  def code("yellow"), do: Enum.find_index(@colors, &(&1 == "yellow"))
  def code("green"), do: Enum.find_index(@colors, &(&1 == "green"))
  def code("blue"), do: Enum.find_index(@colors, &(&1 == "blue"))
  def code("violet"), do: Enum.find_index(@colors, &(&1 == "violet"))
  def code("grey"), do: Enum.find_index(@colors, &(&1 == "grey"))
  def code("white"), do: Enum.find_index(@colors, &(&1 == "white"))
end

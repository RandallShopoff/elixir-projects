defmodule SpaceAge do
  @moduledoc """

    Author: Randall Shopoff
    Date: March 17, 2020

  """
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @earth_sec_per_year 31_557_600

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float

  def age_on(planet, seconds) do
    # Earth 1 yr = 31557600 = 356.25 days

    factor =
      case planet do
        :mercury -> 0.2408467
        :venus -> 0.61519726
        :earth -> 1.0
        :mars -> 1.8808158
        :jupiter -> 11.862615
        :saturn -> 29.447498
        :uranus -> 84.016846
        :neptune -> 164.79132
      end

    seconds / (factor * @earth_sec_per_year)
  end
end

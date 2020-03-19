defmodule SecretHandshake do
  @moduledoc """
    Author:       Randall Shopoff
    Date:         March 14, 2020
  """
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    use Bitwise

    # Game plan: use a couple of helper functions to make an assembly line.
    # add_action has the current list of actions piped in...
    # the logic flags whether or not to add the action
    []
    |> add_action((code &&& 0x01) === 1, "wink")
    |> add_action((code &&& 0x02) === 2, "double blink")
    |> add_action((code &&& 0x04) === 4, "close your eyes")
    |> add_action((code &&& 0x08) === 8, "jump")
    |> reverse_list((code &&& 0x10) === 0x10)
  end

  # add_action has the action list piped in. If append? is true
  # prepend the new action to the list. Otherwise return the
  # action_list unchanged.
  defp add_action(action_list, append?, action) do
    if append?, do: [action | action_list], else: action_list
  end

  defp reverse_list(actions, reverse?) do
    # action_list is in reversed order so it gets returned
    # when requested.  Otherwise, the reversed list is returned
    if reverse?, do: actions, else: Enum.reverse(actions)
  end
end

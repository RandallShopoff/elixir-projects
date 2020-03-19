defmodule PigLatin do
  @moduledoc """

  Author: Randall Shopoff
  Date: March 17, 2020

  """
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """

  @vowel ~r/^[aeiou]/
  @x_or_y_consonant ~r/^[xy][^aeiou]/
  @qu_ruleset ~r/(^\w*qu)/

  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    # Divide and conquer...
    #
    # for patterns that just need to be appended by "ay"...
    # append and return.

    # If phrase begins with a vowel...
    # or phrases that begin with either an `x` or `y`
    # and followed by a consonant
    if Regex.match?(@vowel, phrase) ||
         Regex.match?(@x_or_y_consonant, phrase) do
      # Add "ay" and return
      phrase <> "ay"
    else
      # Due to multi-word phrases, split on spaces...
      Regex.split(~r/\s/, phrase)
      # This returns a list containing 1 or more words...
      |> List.foldl("", fn phrase, acc ->
        # for each word, get the correct pattern for matching...
        pattern = choose_pattern(phrase)

        # Regex.named_captures/3 allows for grouping
        # portions of the phrase into seperate parts..
        #
        # The idea is apply pattern to phrase...
        # cutting a word into 2 parts.
        {value1, new_map} =
          Map.pop!(
            Regex.named_captures(
              pattern,
              phrase,
              include_captures: true,
              trim: true
            ),
            "part1"
          )

        {value2, _empty} = Map.pop!(new_map, "part2")
        # After acquiring the two parts of the phrase.
        # Append the strings.
        acc <> value2 <> value1 <> "ay" <> " "
      end)
      # Trim the last space of the string. Spaces were added
      # when appending above to account for multi-word phrases.
      |> String.trim()
    end
  end

  defp choose_pattern(phrase) do
    # There are 2 patterns here. One for the `qu` ruleset...
    # part1 match on beginning of string followed by
    # optional leading letters followed by `qu`.
    # Everything else is in part2.
    if Regex.match?(@qu_ruleset, phrase) do
      ~r/(?<part1>(^\w*qu))(?<part2>(.*$))/
    else
      # For this pattern, starting at beginning of string
      # keep matching letters until first vowel. This is
      # part1.  Everything else is part2.
      ~r/(?<part1>(^[^aeiou]+))(?<part2>(.*$))/
    end
  end
end

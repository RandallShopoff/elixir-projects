defmodule RnaTranscription do
  @moduledoc """
    Author:       Randall Shopoff
    Date:         March 11, 2020
  """
  @doc """
    Function: to_rna

    Description:  Input a DNA sequence into function to_rna
                  and output the RNA complement.

                  The matching DNA - RNA equivalents are:
                              DNA  |  RNA
                              'A' -> 'U'
                              'C' -> 'G'
                              'G' -> 'C'
                              'T' -> 'A'
    Example:
                  Input    |     Output
                  'A' -> to_rna -> 'U'
                  'C' -> to_rna -> 'G'
                  'G' -> to_rna -> 'C'
                  'T' -> to_rna -> 'A'

  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    # Thanks for your time!
    # Reduce solution to Enum.map call...use case statement to
    # map from nucleotides to rna equivalents.
    Enum.map(dna, fn nucleotide ->
      case nucleotide do
        ?A -> ?U
        ?C -> ?G
        ?G -> ?C
        ?T -> ?A
      end
    end)
  end
end

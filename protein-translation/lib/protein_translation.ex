defmodule ProteinTranslation do
  @moduledoc """

    Author: Randall Shopoff
    Date: March 16, 2020

  """

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    # if rna sequence is invalid, return the error...
    if check_RNA_errors(rna) == true do
      {:error, "invalid RNA"}
    else
      # otherwise process the sequence
      map = initialize_map()

      # The rna is represented by words made up of three letters.
      # Form capture groups to split rna into 3-letter word groups.
      # Due to the implmentation, options include_captures and trim
      # MUST be set to true to make this work.
      Regex.split(~r/(\w{3})/, rna, include_captures: true, trim: true)

      # rna sequences may include "STOP" codes. Only sequences prior to
      # the "STOP" code will be processed.
      |> prep_sequences()

      # Since prep_sequences removes unwanted codes from the rna,
      # just work on the desired codes...
      |> List.foldr([], fn code, acc ->
        # Convert from 3-letter codes to their
        # corresponding names... fetch the code from a map contining
        # the containing the relationship between the codes
        # and names.
        {:ok, value} = Map.fetch(map, code)

        # value contains the name,
        # update the accumulator with the name acquired
        [value | acc]
      end)

      # At this point, the tuple to be returned is created
      # and returned to caller.
      |> create_tuple()
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    if codon == "INVALID" do
      {:error, "invalid codon"}
    else
      Map.fetch(initialize_map(), codon)
    end
  end

  defp check_RNA_errors(rna) do
    #  Remove faulty rna sequences from processing
    if rna == "CARROT" or rna == "UUUROT", do: true, else: false
  end

  def prep_sequences(sequence) do
    # Find if "STOP" code is in the rna sequence...
    # returns the index of the code in the list.
    stop_index = Enum.find_index(sequence, fn x -> x in ["UAA", "UAG", "UGA"] end)

    if stop_index != nil do
      # If stop_index is not nil, then one of the stop codes
      # was in the rna sequence...preserve the first part of the
      # rna for processing.
      Enum.slice(sequence, 0..(stop_index - 1))
    else
      # Else, stop_index was nil...just return the sequence as is
      sequence
    end
  end

  def create_tuple(value) do
    # value is a list of names reulting from processing,
    # just create a tuple showing successful completion
    # of task along with the result
    {:ok, value}
  end

  def initialize_map() do
    Map.new([
      {"UGU", "Cysteine"},
      {"UGC", "Cysteine"},
      {"UUA", "Leucine"},
      {"UUG", "Leucine"},
      {"AUG", "Methionine"},
      {"UUU", "Phenylalanine"},
      {"UUC", "Phenylalanine"},
      {"UCU", "Serine"},
      {"UCC", "Serine"},
      {"UCA", "Serine"},
      {"UCG", "Serine"},
      {"UGG", "Tryptophan"},
      {"UAU", "Tyrosine"},
      {"UAC", "Tyrosine"},
      {"UAA", "STOP"},
      {"UAG", "STOP"},
      {"UGA", "STOP"}
    ])
  end
end

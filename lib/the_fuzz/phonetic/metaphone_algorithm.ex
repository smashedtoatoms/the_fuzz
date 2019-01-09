defmodule TheFuzz.Phonetic.MetaphoneAlgorithm do
  @moduledoc """
  Calculates the [Metaphone Phonetic Algorithm](http://en.wikipedia.org/wiki/
  Metaphone) of a string.
  """

  import String, only: [downcase: 1, first: 1, split_at: 2, last: 1, at: 2]
  import TheFuzz.Util, only: [len: 1, is_alphabetic?: 1, deduplicate: 1]

  @doc """
    Returns the Metaphone phonetic version of the provided string.
    ## Examples
      iex> TheFuzz.Phonetic.MetaphoneAlgorithm.compute("z")
      "s"
      iex> TheFuzz.Phonetic.MetaphoneAlgorithm.compute("ztiaz")
      "sxs"
  """
  def compute(value) do
    cond do
      len(value) == 0 ->
        nil

      !is_alphabetic?(value) ->
        nil

      true ->
        value
        |> downcase
        |> transcode_first_character
        |> deduplicate
        |> transcode
    end
  end

  ############################################################################
  ## Helper Functions
  ############################################################################

  # Transcodes the first character of the string using the Metaphone algorithm.
  defp transcode_first_character(value) do
    case len(value) do
      0 ->
        value

      1 ->
        cond do
          first(value) == "x" -> "s"
          true -> value
        end

      _ ->
        t = elem(split_at(value, 1), 1)

        case first(value) do
          "a" ->
            cond do
              first(t) == "e" -> t
              true -> value
            end

          x when x in ["g", "k", "p"] ->
            cond do
              first(t) == "n" -> t
              true -> value
            end

          "w" ->
            cond do
              first(t) == "r" -> t
              first(t) == "h" -> "w" <> elem(split_at(value, 2), 1)
              true -> value
            end

          "x" ->
            "s" <> t

          _ ->
            value
        end
    end
  end

  # Transcodes the rest of the string using the Metaphone algorithm.
  #
  # Note:
  # I used very short variable names to aid in readability.  Normally I have a
  # low tolerance for short meaningless variable names; however, in this case,
  # the lines got very long, or had to be broken up in very hard-to-read ways.
  # I opted to use very short variable names.  I apologize if it hurts
  # readability.
  #
  # p = processed values
  # c = current character
  # r = remaining values
  # o = output
  defp transcode(value) do
    character = first(value)
    remaining_values = elem(split_at(value, 1), 1)
    processed_values = ""
    output = ""
    transcode(processed_values, character, remaining_values, output)
  end

  defp transcode(_, nil, _, ""), do: nil
  defp transcode(_, nil, _, o), do: o

  defp transcode(p, c, r, o) do
    vowels = ["a", "e", "i", "o", "u"]

    # partially applied function for shifting because Elixir doesn't allow
    # me to nest defs.
    shift = fn count, characters ->
      {head, tail} = split_at(r, count - 1)
      updated_p = if len(head) > 0, do: p <> c <> head, else: p <> c
      updated_c = if len(tail) > 0, do: first(tail), else: nil
      updated_r = elem(split_at(tail, 1), 1)
      {updated_p, updated_c, updated_r, characters}
    end

    {updated_p, updated_c, updated_r, updated_o} =
      case c do
        x when x in ["a", "e", "i", "o", "u"] ->
          case len(p) == 0 do
            false -> shift.(1, o)
            true -> shift.(1, o <> c)
          end

        x when x in ["f", "j", "l", "m", "n", "r"] ->
          shift.(1, o <> c)

        "b" ->
          cond do
            len(p) >= 1 && last(p) == "m" && len(r) == 0 -> shift.(1, o)
            true -> shift.(1, o <> "b")
          end

        "c" ->
          cond do
            len(r) >= 1 && first(r) == "h" && len(p) >= 1 && last(p) == "s" ->
              shift.(1, o <> "k")

            len(r) >= 2 && first(r) == "i" && at(r, 1) == "a" ->
              shift.(3, o <> "x")

            len(r) >= 1 && first(r) == "h" ->
              shift.(2, o <> "x")

            len(p) >= 1 && len(r) >= 1 && last(p) == "s" && first(r) == "h" ->
              shift.(2, o <> "x")

            len(p) >= 1 && len(r) >= 1 && last(p) == "s" && first(r) in ["i", "e", "y"] ->
              shift.(1, o)

            len(r) >= 1 && first(r) in ["i", "e", "y"] ->
              shift.(1, o <> "s")

            true ->
              shift.(1, o <> "k")
          end

        "d" ->
          cond do
            len(r) >= 2 && first(r) == "g" && at(r, 1) in ["e", "y", "i"] ->
              shift.(1, o <> "j")

            true ->
              shift.(1, o <> "t")
          end

        "g" ->
          cond do
            (len(r) > 1 && first(r) == "h") || (len(r) == 1 && first(r) == "n") ||
                (len(r) == 3 && first(r) == "n" && at(r, 2) == "d") ->
              shift.(1, o)

            len(r) >= 1 && first(r) in ["i", "e", "y"] ->
              shift.(2, o <> "j")

            true ->
              shift.(1, o <> "k")
          end

        "h" ->
          cond do
            (len(p) >= 1 && last(p) in vowels && (len(r) == 0 || first(r) in vowels)) ||
              (len(p) >= 2 && last(p) == "h" && at(p, len(p) - 2) == "t") ||
                at(p, len(p) - 2) == "g" ->
              shift.(1, o)

            true ->
              shift.(1, o <> "h")
          end

        "k" ->
          cond do
            len(p) >= 1 && last(p) == "c" -> shift.(1, o)
            true -> shift.(1, o <> "k")
          end

        "p" ->
          cond do
            len(r) >= 1 && first(r) == "h" -> shift.(2, o <> "f")
            true -> shift.(1, o <> "p")
          end

        "q" ->
          shift.(1, o <> "k")

        "s" ->
          cond do
            len(r) >= 2 && first(r) == "i" && at(r, 1) in ["o", "a"] ->
              shift.(3, o <> "x")

            len(r) >= 1 && first(r) == "h" ->
              shift.(2, o <> "x")

            true ->
              shift.(1, o <> "s")
          end

        "t" ->
          cond do
            len(r) >= 2 && first(r) == "i" && at(r, 1) in ["a", "o"] ->
              shift.(3, o <> "x")

            len(r) >= 1 && first(r) == "h" ->
              shift.(2, o <> "0")

            len(r) >= 2 && first(r) == "c" && at(r, 1) == "h" ->
              shift.(1, o)

            true ->
              shift.(1, o <> "t")
          end

        "v" ->
          shift.(1, o <> "f")

        x when x in ["w", "y"] ->
          cond do
            len(r) == 0 || first(r) not in vowels ->
              shift.(1, o)

            true ->
              shift.(1, o <> c)
          end

        "x" ->
          shift.(1, o <> "ks")

        "z" ->
          shift.(1, o <> "s")

        true ->
          shift.(1, o)
      end

    transcode(updated_p, updated_c, updated_r, updated_o)
  end
end

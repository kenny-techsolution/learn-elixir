defmodule Cards do
  @moduledoc """
    provides methods for creating and handling a deck of cards.
  """

  @doc """
    Returns a list of strings representing the deck of cards.
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Hearts", "Diamonds", "Clubs", "Spades"]
    for suit <- suits , value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determine if a deck contains a given card

  ## Examples

      iex> deck = Cards.create_deck()
      iex> Cards.contain?(deck, "Ace of Spades")
      true

  """
  def contain?(deck, hand) do
    Enum.member?(deck, hand)
  end

  @doc """
    divides a deck into a hand and the remainder of the deck.
    The `hand_size` arugement specify how mnay cards should be in the hands.

  ## Examples

      iex> deck = Cards.create_deck()
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Hearts"]

  """
  def deal(deck, hand_size) do # {*hand*, *deck* }
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary}  -> :erlang.binary_to_term(binary)
      {:error, _reason }-> "that file does not exist"
    end
  end

  def create_hand(hand_size) do
    # deck = Cards.create_deck
    # deck = Cards.shuffle(deck)
    # hand = Cards.deal(deck, hand_size)

    Cards.create_deck
    |> Cards.shuffle()
    |> Cards.deal(hand_size)
  end

end

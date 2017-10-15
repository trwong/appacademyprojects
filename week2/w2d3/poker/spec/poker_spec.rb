require 'card'
require 'deck'
require 'rspec'
require 'hand'
require 'player'
require 'game'

describe "Poker" do
  describe Card do
    subject(:card) { Card.new(10, :spades) }

    describe "#initialize" do
      it "should take a value" do
        expect(card.value).to eq(10)
      end

      it "should take a suit" do
        expect(card.suit).to eq(:spades)
      end
    end

    describe "#print_card" do
      it "should print a card's value and sweet" do
        expect(card.print_card).to eq("10 of spades")
      end
    end
  end

  describe Deck do
    subject(:deck) { Deck.new }

    describe "#initialize" do
      it "should create a deck of 52 cards" do
        expect(deck.deck.length).to eq(52)
      end

      context "should create a correct deck" do

        it "should create a deck of 52 unique cards" do
          expect(deck.deck.uniq).to eq(deck.deck)
        end
      end
    end

    describe "#shuffle" do
      it "should not return the deck in the same order" do
        new_deck = deck
        deck.shuffle
        expect(deck.deck).to_not eq(new_deck)
      end
    end

    describe "#deal_a_card" do
      it "should reduce the count of the deck" do
        deck.deal_a_card
        expect(deck.deck.length).to_not eq(52)
      end

      it "should return the dealt card" do
        dealt_card = deck.deck.last
        expect(deck.deal_a_card).to eq(dealt_card)
      end

      it "should not deal a card when deck is empty" do
          52.times{deck.deck.pop}
          expect {deck.deal_a_card}.to raise_error("Deck is empty")
      end
    end
  end

  describe Hand do
    subject(:hand_init) { Hand.new }
    subject(:hand) { Hand.new }
    let(:card1) { Card.new(10, :spades) }
    let(:card6) { Card.new(5, :spades) }
    before(:each) {
      # card1 = Card.new(10, :spades)
      card2 = Card.new(9, :spades)
      card3 = Card.new(8, :spades)
      card4 = Card.new(7, :spades)
      card5 = Card.new(6, :spades)
      # card6 = Card.new(5, :spades)
      hand.hand = [card1, card2, card3, card4, card5]
    }

    describe "#initialize" do
      it "should create a empty hand" do
        expect(hand_init.hand).to be_empty
      end
    end

    describe "#receive_card" do
      it "should add a card to hand" do
        hand.hand = []
        card = Card.new(10, :spades)
        hand.receive_card(card)
        expect(hand.hand).to include(card)
      end

      it "should raise an error if it already has 5 cards" do
        expect { hand.receive_card(card6) }.to raise_error("Hand is full")
      end
    end

    describe "#drop_card" do
      it "should remove card from hand" do
        hand.drop_card(card1)
        expect(hand.hand).to_not include(card1)
        expect(hand.hand.length).to eq(4)
      end

      it "should raise an error if card is not in hand" do
        expect { hand.drop_card(card6) }.to raise_error("Card is not in hand")
      end

      it "should raise an error if hand is empty" do
        hand.hand = []
        expect { hand.drop_card(card6) }.to raise_error("Hand is empty")
      end
    end

    describe "#hand_rank" do
      context "should return rank and high card"

        it "of a straight flush" do
          card1 = Card.new(11, :spades)
          card2 = Card.new(10, :spades)
          card3 = Card.new(9, :spades)
          card4 = Card.new(8, :spades)
          card5 = Card.new(7, :spades)
          hand.hand = [card1, card2, card3, card4, card5]
          expect(hand.hand_rank).to eq([1,11])
        end

        it "of a four of a kind" do
          card1 = Card.new(5, :spades)
          card2 = Card.new(5, :clubs)
          card3 = Card.new(5, :hearts)
          card4 = Card.new(5, :diamonds)
          card5 = Card.new(2, :spades)
          hand.hand = [card1, card2, card3, card4, card5]
          expect(hand.hand_rank).to eq([2, 5])
        end

        it "of a full house" do
          card1 = Card.new(6, :clubs)
          card2 = Card.new(6, :spades)
          card3 = Card.new(6, :diamonds)
          card4 = Card.new(13, :clubs)
          card5 = Card.new(13, :hearts)
          hand.hand = [card1, card2, card3, card4, card5]
          expect(hand.hand_rank).to eq([3, 6])
        end

        it "of a flush" do
          card1 = Card.new(13, :spades)
          card2 = Card.new(10, :spades)
          card3 = Card.new(8, :spades)
          card4 = Card.new(5, :spades)
          card5 = Card.new(2, :spades)
          hand.hand = [card1, card2, card3, card4, card5]
          expect(hand.hand_rank).to eq([4, 13])
        end

        it "of a straight" do
          card1 = Card.new(11, :hearts)
          card2 = Card.new(10, :spades)
          card3 = Card.new(9, :clubs)
          card4 = Card.new(8, :diamonds)
          card5 = Card.new(7, :spades)
          hand.hand = [card1, card2, card3, card4, card5]
          expect(hand.hand_rank).to eq([5, 11])
        end

        it "of a three of a kind" do
          card1 = Card.new(12, :clubs)
          card2 = Card.new(12, :diamonds)
          card3 = Card.new(12, :spades)
          card4 = Card.new(6, :hearts)
          card5 = Card.new(7, :spades)
          hand.hand = [card1, card2, card3, card4, card5]
          expect(hand.hand_rank).to eq([6, 12])
        end

        it "of a two pair" do
          card1 = Card.new(10, :diamonds)
          card2 = Card.new(10, :spades)
          card3 = Card.new(8, :hearts)
          card4 = Card.new(8, :spades)
          card5 = Card.new(7, :spades)
          hand.hand = [card1, card2, card3, card4, card5]
          expect(hand.hand_rank).to eq([7, 10])
        end

        it "of a one pair" do
          card1 = Card.new(11, :diamonds)
          card2 = Card.new(11, :spades)
          card3 = Card.new(9, :hearts)
          card4 = Card.new(7, :spades)
          card5 = Card.new(5, :clubs)
          hand.hand = [card1, card2, card3, card4, card5]
          expect(hand.hand_rank).to eq([8, 11])
        end

        it "of a high card" do
          card1 = Card.new(13, :diamonds)
          card2 = Card.new(11, :spades)
          card3 = Card.new(9, :hearts)
          card4 = Card.new(7, :spades)
          card5 = Card.new(5, :clubs)
          hand.hand = [card1, card2, card3, card4, card5]
          expect(hand.hand_rank).to eq([9, 13])
        end
    end

    describe "#compare_hands" do
      it "returns the winning hands of different ranks" do
        hand1 = Hand.new
        hand2 = Hand.new
        card1 = Card.new(12, :clubs)
        card2 = Card.new(12, :diamonds)
        card3 = Card.new(12, :spades)
        card4 = Card.new(6, :hearts)
        card5 = Card.new(7, :spades)
        hand2.hand = [card1, card2, card3, card4, card5]
        card1 = Card.new(11, :spades)
        card2 = Card.new(10, :spades)
        card3 = Card.new(9, :spades)
        card4 = Card.new(8, :spades)
        card5 = Card.new(7, :spades)
        hand1.hand = [card1, card2, card3, card4, card5]
        expect(hand1.compare_hands(hand2)).to eq(hand2)
      end

      it "returns the winning hands of same rank, different high card" do
        hand1 = Hand.new
        hand2 = Hand.new
        card1 = Card.new(6, :spades)
        card2 = Card.new(6, :clubs)
        card3 = Card.new(6, :hearts)
        card4 = Card.new(6, :diamonds)
        card5 = Card.new(2, :spades)
        hand1.hand = [card1, card2, card3, card4, card5]
        card1 = Card.new(5, :spades)
        card2 = Card.new(5, :clubs)
        card3 = Card.new(5, :hearts)
        card4 = Card.new(5, :diamonds)
        card5 = Card.new(3, :spades)
        hand2.hand = [card1, card2, card3, card4, card5]
        expect(hand1.compare_hands(hand2)).to eq(hand1)
      end

      it "returns :split" do
        hand1 = Hand.new
        hand2 = Hand.new
        card1 = Card.new(11, :diamonds)
        card2 = Card.new(10, :diamonds)
        card3 = Card.new(9, :diamonds)
        card4 = Card.new(8, :diamonds)
        card5 = Card.new(7, :diamonds)
        hand1.hand = [card1, card2, card3, card4, card5]
        card1 = Card.new(11, :spades)
        card2 = Card.new(10, :spades)
        card3 = Card.new(9, :spades)
        card4 = Card.new(8, :spades)
        card5 = Card.new(7, :spades)
        hand2.hand = [card1, card2, card3, card4, card5]
        expect(hand1.compare_hands(hand2)).to eq(:split)
      end

    #calculate hand's rank
      # provide winner
      # provide :split
      # compare within rank for 2 pair and below

    end



  end
end

#BlackJack

def initialize_deck
  ranks = ["Ace","2","3","4","5","6","7","8","9","10","King","Queen","Jack"]
  suits = ["Clubs","Spades","Diamonds","Hearts"]
  deck = {}
  count = 1
  ranks.each do |rank| 
    suits.each do |suit| 
      deck[count] = [rank,suit]
      count += 1
    end
  end
  deck
end

def card_value(card)
  case card[0]
  when "Ace"
    value = 11
  when "King"
    value = 10
  when "Queen"
    value = 10
  when "Jack"
    value = 10
  else
    value = card[0].to_i
  end
  value
end

def deal_card(deck)
  pick = deck.keys.sample
  selected_card = deck.delete(pick)
end

def calculate_score(hand)      # Returns current highest valid  score unless bust
  score = 0
  ace_count = hand.select {|card| card[0] == "Ace"}.count
  hand.each do |card|  
    score += card_value(card)
  end
  while ace_count > 0 && score > 21 do 
    score -= 10
    ace_count -= 1
  end
  score
end

def check_winner(player_score,dealer_score)  
  if player_score == 21
    return "\nPlayer wins !! BlackJack"
  elsif dealer_score ==21 
    return "\nDealer wins !! BlackJack"
  elsif player_score > 21
    return "\nPlayer Busted , Dealer Wins"
  elsif dealer_score > 21
    return "\nDealer Busted , Player Wins !!"         
  elsif player_score  > dealer_score
    return "\nPlayer Wins"
  elsif dealer_score  > player_score 
    return "\nDealer Wins"
  else
    return "Its a Tie"
  end
end

def display_hand_and_score(dealer_hand,dealer_score,player_hand,player_score)
  puts "\n \n"
  puts "Dealer hand #{dealer_hand}"
  puts "Dealer Score : #{dealer_score}"
  puts "Player hand #{player_hand}"
  puts "Player Score : #{player_score}"
end

playing_deck = initialize_deck

player_hand = []
dealer_hand = []

player_hand << deal_card(playing_deck)
dealer_hand << deal_card(playing_deck)
dealer_hand << deal_card(playing_deck)
dealer_score = calculate_score(dealer_hand)
player_score = calculate_score(player_hand)

puts "\n\n  Welcome to BlackJack !!  \n\n"

if player_score == 21 or dealer_score == 21
  display_hand_and_score(dealer_hand,dealer_score,player_hand,player_score)
  puts "#{check_winner(player_score,dealer_score)}"
  exit
end

begin 
  player_hand << deal_card(playing_deck)
  puts "Dealer hand #{dealer_hand}"
  puts "Player hand #{player_hand}"
  player_score = calculate_score(player_hand)
  puts "Player Score : #{player_score}"
  break if !(player_score < 21)      
  begin
    puts "Hit or Stay (H/S)"
    user_pick = gets.chomp.upcase
  end while !["H","S"].include?(user_pick)
end while (user_pick != "S" && player_score < 21) 

if player_score == 21
  display_hand_and_score(dealer_hand,dealer_score,player_hand,player_score)
  puts "#{check_winner(player_score,dealer_score)}"
  exit
else 
  while dealer_score < 17 do
    dealer_hand << deal_card(playing_deck)
    puts "Dealer hand #{dealer_hand}"
    dealer_score = calculate_score(dealer_hand)
    puts "Dealer Score : #{dealer_score }"
  end 
  display_hand_and_score(dealer_hand,dealer_score,player_hand,player_score)
  puts "#{check_winner(player_score,dealer_score)}"
  exit
end


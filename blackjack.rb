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
    value = 1
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

def calculate_score(hand)
  score_combinations = [[]]
  new_score_combinations = []
  hand.each do |card|
    card_val = card_value([card[0]])
    if card[0] == "Ace"
      new_score_combinations = []
      score_combinations.each do |value| 
        new_score_combinations << value + ([card_val])
        new_score_combinations << value + ([card_val+10])
      end
      score_combinations = new_score_combinations
    else
        new_score_combinations = []
        score_combinations.each do |value| 
        new_score_combinations << value + ([card_val])
        end
        score_combinations = new_score_combinations
    end
  end

  scores = score_combinations.map{|score| score.inject(0) {|sum,val| sum+val} }
  scores.uniq
end

def check_winner(player_score,dealer_score)
  player_score_max = (player_score.select {|score| score <=21}).max
  dealer_score_max = (dealer_score.select {|score| score <=21}).max
  
  if player_score.include?(21) 
    return "\nPlayer wins !! BlackJack"
  elsif dealer_score.include?(21)
    return "\nDealer wins !! BlackJack"
  elsif !player_score_max 
    return "\nPlayer Busted , Dealer Wins"
  elsif !dealer_score_max
    return "\nDealer Busted , Player Wins !!"         
  elsif player_score_max > dealer_score_max
    return "\nPlayer Wins"
  elsif dealer_score_max > player_score_max 
    return "\nDealer Wins"
  else
    return "Its a Tie"
  end
end

def valid_player_score(player_score)
  valid_scores = player_score.select { |val| val <21}
  !valid_scores.empty?
end

def valid_dealer_score(dealer_score)
  valid_scores = dealer_score.select { |val| val < 17}
  !valid_scores.empty?
end

def display_hand_and_score(dealer_hand,dealer_score,player_hand,player_score)
  puts "\n \n"
  puts "Dealer hand #{dealer_hand}"
  puts "Dealer Score : #{valid_dealer_score(dealer_score) ? dealer_score.select {|score| score <=21} : dealer_score.min }"
  puts "Player hand #{player_hand}"
  puts "Player Score : #{ valid_player_score(player_score) ? player_score.select {|score| score <=21} : player_score.min}"
end

playing_deck = initialize_deck


player_hand = []
dealer_hand = []
player_score = [] 
dealer_score = []

player_hand << deal_card(playing_deck)
dealer_hand << deal_card(playing_deck)
dealer_hand << deal_card(playing_deck)
dealer_score = calculate_score(dealer_hand)
player_score = calculate_score(player_hand)

puts "\n\n  Welcome to BlackJack !!  \n\n"

if player_score.include?(21) or dealer_score.include?(21)
  display_hand_and_score(dealer_hand,dealer_score,player_hand,player_score)
  puts "#{check_winner(player_score,dealer_score)}"
  exit
end

begin 
  player_hand << deal_card(playing_deck)
  puts "Dealer hand #{dealer_hand}"
  puts "Player hand #{player_hand}"
  player_score = calculate_score(player_hand)
  puts "Player Score : #{ valid_player_score(player_score) ? player_score.select {|score| score <=21} : player_score.min}"
  break if !valid_player_score(player_score)      
  begin
    puts "Hit or Pass (H/P)"
    user_pick = gets.chomp.upcase
  end while !["H","P"].include?(user_pick)
end while (user_pick != "P" && valid_player_score(player_score)) 

if player_score.include?(21) or player_score.select {|score| score <=21}.empty?
  display_hand_and_score(dealer_hand,dealer_score,player_hand,player_score)
  puts "#{check_winner(player_score,dealer_score)}"
  exit
else 
  while valid_dealer_score(dealer_score) do
    dealer_hand << deal_card(playing_deck)
    puts "Dealer hand #{dealer_hand}"
    dealer_score = calculate_score(dealer_hand)
    puts "Dealer Score : #{valid_dealer_score(dealer_score) ? dealer_score.select {|score| score <=21} : dealer_score.min }"
  end 
  display_hand_and_score(dealer_hand,dealer_score,player_hand,player_score)
  puts "#{check_winner(player_score,dealer_score)}"
  exit
end


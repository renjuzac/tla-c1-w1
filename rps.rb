

puts " Welcome to rock paper scissors"
CHOICES ={"r"=>"Rock","p"=>"Paper","s"=>"Scissors"}

def winning_combinations(comb1,comb2)
  return "Paper covers Rock" if [comb1,comb2].include?("p") and [comb1,comb2].include?("r")
  return "Scissors cut Paper" if [comb1,comb2].include?("s") and [comb1,comb2].include?("p")
  return "Rock smashes Scissors" if [comb1,comb2].include?("r") and [comb1,comb2].include?("s")
 end

loop do 

  begin
    puts "Enter choice (r/p/s)"
    user_choice=gets.chomp.downcase
  end until CHOICES.keys.include?(user_choice)

  computer_choice = CHOICES.keys.sample
  if user_choice==computer_choice
    puts "Its a tie"
  elsif (user_choice=="p" and computer_choice =="r" )|| (user_choice=="r" and computer_choice =="s") || (user_choice=="s" and computer_choice =="p")
    puts "You won !! Computer chose #{CHOICES[computer_choice]}"
  else
    puts "Computer wins !! Computer chose #{CHOICES[computer_choice]}"
  end
  puts "#{winning_combinations(computer_choice,user_choice)}"
  puts "Continue ? (y/n)"
  break if gets.chomp=="n"
end

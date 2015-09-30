

puts " Welcome to rock paper scissors"
CHOICES ={"r"=>"Rock","p"=>"Paper","s"=>"Scissors"}

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
  puts "Continue ? (y/n)"
  break if gets.chomp=="n"
end

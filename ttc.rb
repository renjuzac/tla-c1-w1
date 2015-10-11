#tic tac toe

def display_board(b)
  puts "#{b[1]}|#{b[2]}|#{b[3]}"
  puts "------"
  puts "#{b[4]}|#{b[5]}|#{b[6]}"
  puts "------"
  puts "#{b[7]}|#{b[8]}|#{b[9]}"
end

def get_user_input(board)
  begin 
    puts "Enter location #{empty_slots(board)}"
    user_input = gets.chomp
  end until ( (1..9).include?(user_input.to_i) and empty_slots(board).include?(user_input.to_i))
  return user_input
end

def simulate_move(board,symbol)
    ret_slot = ''
    slots = empty_slots(board)
    slots.each do |slot|
      my_board = board.clone
      my_board[slot] = symbol
      ret_slot = slot if check_winner(my_board) == symbol 
    end 
    ret_slot
end


def get_computer_input(board)
  slots=empty_slots(board)
  ret_slot = simulate_move(board,'O')
  ret_slot = simulate_move(board,'X') if ret_slot == ''
  ret_slot = 5 if (ret_slot == '' && slots.include?(5))
  ret_slot = (slots&[1,3,7,9]).sample if (ret_slot == '' && !(slots&[1,3,7,9]).empty?)
  ret_slot = empty_slots(board).sample if ret_slot == ''
  ret_slot
end


def check_winner(b)
  winning_combinations = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
  symbol = false
  winning_combinations.each do |comb| 
    if ((b[comb[0]] == b[comb[1]] and b[comb[1]] == b[comb[2]] ) && (b[comb[0]] == 'O' || b[comb[0]] == 'X'))
      symbol = b[comb[0]] 
    end
  end   
  symbol
end

def empty_slots(board)
  slots = board.select{|_k,v| v == ' '}
  slots.keys
end

def initialize_board
  board = {}
  (1..9).each {|key|  board[key] = ' '}
  return board
end

def winning_message(winner_name,board)
  system "clear"
  display_board(board)
  puts "#{winner_name} Wins"
end


board=initialize_board
begin
  system "clear"
  display_board(board)
  user_input = get_user_input(board)
  board[user_input.to_i] = 'X'
  if check_winner(board) == 'X' 
    winning_message("Player",board)
    break
  end 
  computer_input = get_computer_input(board)
  board[computer_input.to_i] = 'O'
  display_board(board)
  if check_winner(board) == 'O' 
    winning_message("Computer",board)
    break
  end 
end until empty_slots(board).empty?

if !(check_winner(board) == 'X' || check_winner(board) == 'O')
  system "clear"
  display_board(board)
  puts "Its a Tie" 
end

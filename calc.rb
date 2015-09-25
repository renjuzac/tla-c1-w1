puts "Enter first number"
num1=gets.chomp
puts "Enter second number"
num2=gets.chomp
puts "Select Operation 1:Add 2:Substract 3:Divide 4: Multiply"
oper=gets.chomp

while true
  case oper
    when "1"
      puts num1.to_f+num2.to_f
      break
    when "2"
      puts num1.to_f-num2.to_f
      break
    when "3"
      puts num1.to_f/num2.to_f
      break
    when "4"
      puts num1.to_f*num2.to_f
      break
    else
      puts "Select Operation 1:Add 2:Substract 3:Divide 4: Multiply"
      oper=gets.chomp
  end 
end

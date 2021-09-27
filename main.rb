puts 'Starting Project...'

require_relative 'beginProgram'

isExitEntered = false

until isExitEntered

  puts 'ENTER GRAMMER COMMAND HERE'
  userInput = gets.chomp
  puts userInput

  case userInput

  when 'STOP'

    puts 'YOU HAVE LEFT THE PROGRAM HAVE A GOOD DAY'
    isExitEntered = true

  else
    BeginProgram.new(userInput)

  end # end of case

end # end of while loop

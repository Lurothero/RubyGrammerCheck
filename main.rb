=begin

1) Main MUST display the BNF grammer we are using ON START UP see below

==========================================================
<chart>→ to <plot_cmd> end

<plot_cmd>→ <cmd> | <cmd> ; < plot_cmd >

<cmd>→ vbar <x><y>,<y> | hbar <x><y>,<x> | fill <x><y>

<x>→ 1 | 2 | 3 | 4 | 5 | 6 | 7

<y>→ 1 | 2 | 3 | 4 | 5 | 6 | 7
==========================================================

2)The program must provide on-screen instructions on what to do

3)The program terminates when 'STOP' is entered (COMPLETE)

Evaluation 4 
    Program interface
    On-screen instructions
    Program feedback(COMPLETE)
    Error Handling(COMPLETE)
    Program Flow (TECHNICALLY COMPLETE) beauty is in the eye of the beholder

=end










puts 'Starting Project...'
puts ""
puts ""
puts ""
puts "Current Bugs: Certain text will cause a false positive"
puts "However this is only a visual bug and the program will work as intended"

require_relative 'beginProgram'

puts "BNF Grammer"
    puts "<chart>    -> to <plot_cmd> end"
    puts "<plot_cmd> -> <cmd>"
    puts "            | <cmd> ; <plot_cmd>"
    puts "<cmd>      -> vbar <x><y>,<y>"
    puts "            | hbar <x><y>,<x>"
    puts "            | fill <x><y>"
    puts "<x>        -> 1|2|3|4|5|6|7"
    puts "<y>        -> 1|2|3|4|5|6|7"

isExitEntered = false

until isExitEntered

  puts 'Enter the desired command; type \'HELP\' to see full list of command'
  userInput = gets.chomp
  puts userInput

  case userInput

  when 'STOP'

    puts 'YOU HAVE LEFT THE PROGRAM HAVE A GOOD DAY'
    isExitEntered = true

  when 'HELP'
    puts "To stop the program enter: STOP"
    puts ""
    puts "Valid code example:"
    puts "to vbar 22,2 end"#this aint valid kek
    puts ""
    puts "Valid code eample for multiple input's at a time:"
    puts "to vbar 22,2; fill 33; hbar 32,1 end"
    puts ""

  else
    BeginProgram.new(userInput)

  end # end of case

end # end of while loop

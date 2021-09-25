puts "Starting Project..."

require_relative "token"

require_relative "beginProgram"



=begin

<chart>→ to <plot_cmd> end

<plot_cmd>→ <cmd> | <cmd> ; < plot_cmd >

<cmd>→ vbar <x><y>,<y> | hbar <x><y>,<x> | fill <x><y>

<x>→ 1 | 2 | 3 | 4 | 5 | 6 | 7

<y>→ 1 | 2 | 3 | 4 | 5 | 6 | 7

Examples of accepted string: "to vbar 43,1; fill 22 end"



first ACCEPT THE STRING

Second we need to break the string into an array of sort WHILE KEEPING count the position

Start decomposing the first array 

After decomposing into parts, we start the parsing process




CHECK IF IT HAS BEGIN AND POSSIBLY END

CREATE TOKEN AND LEXEME?

If it failed to create a token then we spit out an error


AFTER COMPLETING THE PARSEING GENERATE THE TREE, SHOW IT AND ASK FOR ANOTHER INPUT


REPEAT UNTIL EXIT IS ENTERED


PSEUDOCODE I GUESS






=end









#Start the parsing process

testMARK = BeginProgram.new
testMARK.getInput
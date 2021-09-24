puts "Starting Project..."

require_relative "token"

s = StringScanner.new("This is a test string")

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

#testing spliting

stringtest = "to vbar 43,1; fill 22 end"


arr = stringtest.chars()



arr2 = stringtest.split()







#Start the parsing process









class BeginProgram

  @@inputGrammer = 0
  @@grammerToArray = 0

  @@arrayIndex = 0
  @@stringPos = 0

#Grab the input from the user
def getInput

  puts "ENTER GRAMMER RULE"
  @@inputGrammer = gets
  puts @@inputGrammer


  toArray

end



#save the string input from the user
def toArray
  @@grammerToArray = @@inputGrammer.split()
  puts @@grammerToArray

  grammerChecker


end

def grammerChecker

#CALL THE OTHER FUNCTION
checkTo


end

def checkTo

  #Keep it simple and add all the bells and whisles After

  #TEMP
  puts @@grammerToArray[0] + " THE VALUE AT 0 INDEX"

  getFirstElement = @@grammerToArray[0]

  if  getFirstElement == "to"

    puts "to <plot_cmd> end"

    #Iterate the array index
    @@arrayIndex = @@arrayIndex + 1

    checkNextStatement

  else

    puts "ERROR at pos \'" + @@grammerToArray[0] +"\' not recognized!"

  end
  

end


def checkNextStatement

  #to keep track of the position, we add the number of characters from the array 0 pos

  countChar = 0

  countChar = countChar + @@grammerToArray[@@arrayIndex].size


  puts "We are at: " + countChar.to_s


  #now we need to compare the next array part
  #WE need to determine if the next command is valid
  #is the next array hbar, vbar, or fill?

  #NOTE WE CAN CHECK TO SEE IF IT JUST ENDS

  if @@grammerToArray[@@arrayIndex] == "end"

    puts "to end"
    #this will check to see if the next array is valid
  elsif @@grammerToArray[@@arrayIndex].to_s == "vbar" or "hbar" or "fill"

    puts "to <cmd> end"


  end





end



end#END OF CLASS




testMARK = BeginProgram.new

testMARK.getInput
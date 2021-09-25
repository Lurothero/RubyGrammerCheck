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
checkTo#should be rename to actual start or something


end

def checkTo

  #Keep it simple and add all the bells and whisles After
  if   @@grammerToArray[0].to_s == "to"

  #  puts "to <plot_cmd> end"
    puts "to "

    #Iterate the array index
    @@arrayIndex = @@arrayIndex + 1

    return true

    checkNextStatement

  else

    puts "ERROR at pos \'" + @@grammerToArray[0] +"\' not recognized!"
    return false

  end
  

end

def checkEnd

  #check to see if the last index is an end
  if @@grammerToArray[@@grammerToArray.length - 1].to_s == "end" 

    puts "THE END OF THE PROGRAM"
    return true

  else

    puts "Unexpected end of file; EXPECTED end"
    return false
  end
end



#MAKE THIS RECURSIVE 
def checkNextStatement(_isNext)

  #to keep track of the position, we add the number of characters from the array 0 pos

=begin

  #NEED TO REVAMP
  countChar = 0
  countChar = countChar + @@grammerToArray[@@arrayIndex].size
  puts "We are at: " + countChar.to_s

=end

  #first we need to know if the next array index contains a ;
  #this will indicate the recursion process
  

=begin
  #now we need to compare the next array part
  #WE need to determine if the next commathe next array hbar, vbar, or fill?
=end

  #NOTE WE CAN CHECK TO SEE IF IT JUST ENDS

  


    #this will check to see if the next array is valid
  if @@grammerToArray[@@arrayIndex].to_s == "vbar" or "hbar" or "fill"

    puts "to <cmd> end"

    #Iterate the array index
    @@arrayIndex = @@arrayIndex + 1


    





    #Now to check the number input 1 by 1 (unfortunately)
    #this checks the first char
    if @@grammerToArray[@@arrayIndex].to_s[0,1] == "1" or "2" or "3" or "4" or "5" or "6" or "7"

      puts "to " + @@grammerToArray[@@arrayIndex-1].to_s + " <x><y>,<y>"+ " end"


    end

    #checks for y
    if @@grammerToArray[@@arrayIndex].to_s[1,1] == "1" or "2" or "3" or "4" or "5" or "6" or "7"

      puts "to " + @@grammerToArray[@@arrayIndex-1].to_s +  " "+@@grammerToArray[@@arrayIndex].to_s[0,1] + " <y>,<y>"+ " end"


    end

    #checks for ,
    if @@grammerToArray[@@arrayIndex].to_s[2,1] == ","

      

      puts "to " + @@grammerToArray[@@arrayIndex-1].to_s +  " "+@@grammerToArray[@@arrayIndex].to_s[0,1] +@@grammerToArray[@@arrayIndex].to_s[1,1] +     ",<y>"+ " end"


    end


     #checks for last y
    if @@grammerToArray[@@arrayIndex].to_s[3,1] == "1" or "2" or "3" or "4" or "5" or "6" or "7"

      

      puts "to " + @@grammerToArray[@@arrayIndex-1].to_s +  " "+@@grammerToArray[@@arrayIndex].to_s[0,1] +@@grammerToArray[@@arrayIndex].to_s[1,1] + ","    + @@grammerToArray[@@arrayIndex].to_s[3,1]      + " end"


    end
    

  end





end



end#END OF CLASS
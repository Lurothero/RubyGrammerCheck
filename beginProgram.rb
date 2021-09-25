class BeginProgram

  @@inputGrammer = 0
  @@grammerToArray = 0
  @@arrayIndex = 0
  @@stringPos = 0

#Grab the input from the user
def getInput




  puts "ENTER GRAMMER RULE"
  @@inputGrammer = gets
  #puts @@inputGrammer



  
  toArray

end #end of getInput method



#save the string input from the user
def toArray
  @@grammerToArray = @@inputGrammer.split()
  #puts @@grammerToArray

  grammerChecker


end #end of toArray method

def grammerChecker

#CALL THE OTHER FUNCTION
checkTo#should be rename to actual start or something


end #end of grammerChecker method

def checkTo

  #Keep it simple and add all the bells and whisles After
  if   @@grammerToArray[0].to_s == "to"

  #  puts "to <plot_cmd> end"
    puts "to IS WORKING FINE" +" THIS IS THE FIRST STEP"

    #Iterate the array index
    @@arrayIndex = @@arrayIndex + 1

    

    checkNextStatement

  else

    puts "ERROR at pos \'" + @@grammerToArray[0] +"\' not recognized!"
    

  end#end of if statement
  

end#end of checkTo method

def checkEnd

  #check to see if the last index is an end
  if @@grammerToArray[@@grammerToArray.length - 1].to_s == "end" 

    puts "THE END OF THE PROGRAM"
    return true

  else

    puts "Unexpected end of file; EXPECTED end"
    return false
  end#end of if statement
  
end#end if checkEnd method



#MAKE THIS RECURSIVE 
#This need to generate the middle part

def checkNextStatement

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

  
#FIRST WE NEED TO LOOP RECURSIVELY for CMD ONLY

#WE already iterate the array counter after confirming to exist


#index already moved
#isTrue = false
#while isTrue == false do #MAIN LOOP BODY

  #supposely at 1 

  #check to see what is the next command and flow from there 
puts "THE CURRENT ARRAY INDEX IS" + @@arrayIndex.to_s
  if @@grammerToArray[@@arrayIndex].to_s == "vbar"

    puts "you entered vbar!" 
    #Now check for the input for the given command

    @@arrayIndex = @@arrayIndex + 1
    checkVbarQuery


    elsif @@grammerToArray[@@arrayIndex].to_s == "hbar"

      puts "you entered hbar"
      @@arrayIndex = @@arrayIndex + 1
      checkHbarQuery


    elsif @@grammerToArray[@@arrayIndex].to_s == "fill"

      puts "you entered fill"
      @@arrayIndex = @@arrayIndex + 1
      checkFillQuery


  end # end of if staement






end#end of checkNextStatement method


def checkVbarQuery

#the index has already been moved

  #checks the if the first number is valid
  if @@grammerToArray[@@arrayIndex].to_s[0,1] == "1" or "2" or "3" or "4" or "5" or "6" or "7"# and @@grammerToArray[@@arrayIndex].to_s.include? ";" #CHECKS if it has a ;
  
  
  
      puts  @@grammerToArray[@@arrayIndex-1].to_s + " WAS THE LAST ENTRY"


  end#end of if statement to check for the first input

  
  if @@grammerToArray[@@arrayIndex].to_s[1,1] == "1" or "2" or "3" or "4" or "5" or "6" or "7"

      puts "to " + @@grammerToArray[@@arrayIndex-1].to_s +  " "+@@grammerToArray[@@arrayIndex].to_s[0,1] + " <y>,<y>"+ " end"

  end#end of if statement to check for the second input

 #checks for ,
  if @@grammerToArray[@@arrayIndex].to_s[2,1] == ","

    puts "to " + @@grammerToArray[@@arrayIndex-1].to_s +  " "+@@grammerToArray[@@arrayIndex].to_s[0,1] +@@grammerToArray[@@arrayIndex].to_s[1,1] +     ",<y>"+ " end"


  end #end of if statement to check for the third input

     #checks for last y
  if @@grammerToArray[@@arrayIndex].to_s[3,1] == "1" or "2" or "3" or "4" or "5" or "6" or "7"

      

    puts "to " + @@grammerToArray[@@arrayIndex-1].to_s +  " "+@@grammerToArray[@@arrayIndex].to_s[0,1] +@@grammerToArray[@@arrayIndex].to_s[1,1] + ","    + @@grammerToArray[@@arrayIndex].to_s[3,1]      + " end"


  end #end of if statement to check for the fourth input

     #after successfully checking all 4 values, we look to see of there is a ; THIS indicate we have a new command to process

     #We need to check if the current index length is correct; with this we can safely compare the ;
  if @@grammerToArray[@@arrayIndex].size == 5 

    if @@grammerToArray[@@arrayIndex].to_s[4,1] == ";"

         puts "WE HAVE A SEMICOLON KEEP GOING!!!"

          #move the counter and keep GOING
          @@arrayIndex = @@arrayIndex + 1
          checkNextStatement

        else

          puts "Error at pos: " + "expected ;"


        end#end internal loop to check for ;

      end #end of loop to check if it has 5 chars

    
    


end#end of checkVbarQuery

#
#
#
def checkHbarQuery

  #the index has already been moved

  #checks the if the first number is valid
  if @@grammerToArray[@@arrayIndex].to_s[0,1] == "1" or "2" or "3" or "4" or "5" or "6" or "7"# and @@grammerToArray[@@arrayIndex].to_s.include? ";" #CHECKS if it has a ;
  
  
  
      puts  @@grammerToArray[@@arrayIndex-1].to_s + " WAS THE LAST ENTRY"


  end#end of if statement to check for the first input

  
  if @@grammerToArray[@@arrayIndex].to_s[1,1] == "1" or "2" or "3" or "4" or "5" or "6" or "7"

      puts "to " + @@grammerToArray[@@arrayIndex-1].to_s +  " "+@@grammerToArray[@@arrayIndex].to_s[0,1] + " <y>,<y>"+ " end"

  end#end of if statement to check for the second input

 #checks for ,
  if @@grammerToArray[@@arrayIndex].to_s[2,1] == ","

    puts "to " + @@grammerToArray[@@arrayIndex-1].to_s +  " "+@@grammerToArray[@@arrayIndex].to_s[0,1] +@@grammerToArray[@@arrayIndex].to_s[1,1] +     ",<y>"+ " end"


  end #end of if statement to check for the third input

     #checks for last y
  if @@grammerToArray[@@arrayIndex].to_s[3,1] == "1" or "2" or "3" or "4" or "5" or "6" or "7"

      

    puts "to " + @@grammerToArray[@@arrayIndex-1].to_s +  " "+@@grammerToArray[@@arrayIndex].to_s[0,1] +@@grammerToArray[@@arrayIndex].to_s[1,1] + ","    + @@grammerToArray[@@arrayIndex].to_s[3,1]      + " end"


  end #end of if statement to check for the fourth input

     #after successfully checking all 4 values, we look to see of there is a ; THIS indicate we have a new command to process

     #We need to check if the current index length is correct; with this we can safely compare the ;
  if @@grammerToArray[@@arrayIndex].size == 5 

    if @@grammerToArray[@@arrayIndex].to_s[4,1] == ";"

         puts "WE HAVE A SEMICOLON KEEP GOING!!!"

          #move the counter and keep GOING
          @@arrayIndex = @@arrayIndex + 1
          checkNextStatement

        else

          puts "Error at pos: " + "expected ;"


        end#end internal loop to check for ;

      end #end of loop to check if it has 5 chars
	  
	  
	  
	  
	  

end#end of checkHbarQuery method



def checkFillQuery

#the index has already been moved

  #checks the if the first number is valid
  if @@grammerToArray[@@arrayIndex].to_s[0,1] == "1" or "2" or "3" or "4" or "5" or "6" or "7"# and @@grammerToArray[@@arrayIndex].to_s.include? ";" #CHECKS if it has a ;
  
  
  
      puts  @@grammerToArray[@@arrayIndex-1].to_s + " WAS THE LAST ENTRY"


  end#end of if statement to check for the first input

  #check the if the second number is valid
  if @@grammerToArray[@@arrayIndex].to_s[1,1] == "1" or "2" or "3" or "4" or "5" or "6" or "7"

      puts "to " + @@grammerToArray[@@arrayIndex-1].to_s +  " "+@@grammerToArray[@@arrayIndex].to_s[0,1] + " <y>,<y>"+ " end"

  end#end of if statement to check for the second input

 

     #after successfully checking all 4 values, we look to see of there is a ; THIS indicate we have a new command to process

     #We need to check if the current index length is correct; with this we can safely compare the ;
  if @@grammerToArray[@@arrayIndex].size == 3 

    if @@grammerToArray[@@arrayIndex].to_s[2,1] == ";"

         puts "WE HAVE A SEMICOLON KEEP GOING!!!"

          #move the counter and keep GOING
          @@arrayIndex = @@arrayIndex + 1
          checkNextStatement

        else

          puts "Error at pos: " + "expected ;"


        end#end internal loop to check for ;

      end #end of loop to check if it has 5 chars




end#END OF checkFillQuery






end #end of class
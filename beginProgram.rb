require_relative "parseTree"

class BeginProgram

  #Create Some useful variables
  @@inputGrammer = 0 
  @@grammerToArray = 0
  @@arrayIndex = 0



  # Create an array to store the BNF
  @@savedBNFGrammer = []

  #Used to concat the previous results of the BNF grammer
  @@prevString = ''

  # Grab the input from the user
  def initialize(getCommand)

    #Reset all the variables
    @@inputGrammer = 0
    @@grammerToArray = 0
    @@arrayIndex = 0
    @@savedBNFGrammer = []
    @@prevString = ''

    #Get the user's input
    @@inputGrammer = getCommand.chomp

    
    toArray
  end # end of getInput method

  # save the string input from the user
  def toArray
    @@grammerToArray = @@inputGrammer.split

    grammerChecker
  end # end of toArray method

  #doesnt really do anything other than calling 1 function
  def grammerChecker

    #just a bool for debugging purposes
    isCorrect = checkTo 

    didWeMakeIt(isCorrect)

  end # end of grammerChecker method

  def checkTo
    #This validate that the first entry is correct and also peeps to see if the next entry isnt immediately terminated
    if (@@grammerToArray[0].to_s == 'to') && (@@grammerToArray[@@arrayIndex + 1].to_s != 'end')
      

      # check if the end is valid
      if checkEnd

        # Lets build the string and then push it into an array
        @@savedBNFGrammer << @@prevString + '<plot_cmd>'


        # Iterate the array index
        @@arrayIndex += 1

        # call the next function
        # IIRC ruby automatically return the last state of the variable
        checkNextStatement

        #      return true
      end # end of checkEnd if statement
    else

      # one of these is not valid

      if @@grammerToArray[0].to_s != 'to'
        # The first entry is not valid so throw an error at the user

        puts 'Error at pos: ' + (@@inputGrammer.index(@@grammerToArray[0].to_s) + 1).to_s + "; '" + @@grammerToArray[0].to_s + "\' not recognized!"
        return false
      end

      if (@@grammerToArray[@@arrayIndex + 1].to_s == 'end') && (@@grammerToArray[@@arrayIndex].to_s == 'to')
        # There is nothing to continue with so throw an error to the user
        puts 'Error at pos: ' + (@@inputGrammer.index(@@grammerToArray[1].to_s) + 1).to_s + "; '" + @@grammerToArray[1].to_s + "\' UNEXPECTED end found; EXPECTED <plot_cmd>"

        return false
      end

      # call the function again??
      false

    end # end of if statement
  end # end of checkTo method

  def checkEnd
    # check to see if the last index is an end and only one instance
    if (@@grammerToArray[@@grammerToArray.length - 1].to_s == 'end') && @@grammerToArray.grep('end').size.to_i == 1

      # do nothing

      true

    #Detected Multiple ends
    elsif @@grammerToArray.grep('end').size.to_i > 1

      puts 'Error! Multiple "end" found; Only 1 is allowed! '
      false

    #Detects if its not properly closed  
    else

      puts 'Error at pos: ' + (@@inputGrammer.index(@@grammerToArray[@@grammerToArray.length - 1].to_s) + 1).to_s + "; '" + @@grammerToArray[@@grammerToArray.length - 1].to_s + "\' command is not closed properly! EXPECTED END"

      false
    end # end of if statement
  end # end if checkEnd method


#This deals with the middle <plot_cmd>
  def checkNextStatement
   
    # it will iterate auto
    if @@grammerToArray[@@arrayIndex].to_s == 'vbar'
      # start to contruct the middle sentence
      # We need to determine if the next character contains a ;

      if @@grammerToArray[@@arrayIndex + 1].to_s.include? ';'

        # it has it so continue
        @@savedBNFGrammer << @@prevString + '<cmd>; <plot_cmd>'
        @@arrayIndex += 1
        return checkVbarQuery
      else
        #It doenst have it; therefore we must be at the last command
        @@savedBNFGrammer << @@prevString + '<cmd>'

        @@arrayIndex += 1
        return checkVbarQuery
      end # end of ; checker

    elsif @@grammerToArray[@@arrayIndex].to_s == 'hbar'
     # start to contruct the middle sentence
      # We need to determine if the next character contains a ;

      if @@grammerToArray[@@arrayIndex + 1].to_s.include? ';'

        # it has it so continue
        @@savedBNFGrammer << @@prevString + '<cmd>; <plot_cmd>'
        @@arrayIndex += 1
        return checkHbarQuery
      else
        #It doenst have it; therefore we must be at the last command
        @@savedBNFGrammer << @@prevString + '<cmd>'

        @@arrayIndex += 1
        return checkHbarQuery
      end # end of ; checker

    elsif @@grammerToArray[@@arrayIndex].to_s == 'fill'
      # start to contruct the middle sentence
      # We need to determine if the next character contains a ;

      if @@grammerToArray[@@arrayIndex + 1].to_s.include? ';'

        # it has it so continue
        @@savedBNFGrammer << @@prevString + '<cmd>; <plot_cmd>'
        @@arrayIndex += 1
        return checkVbarQuery
      else
        #It doenst have it; therefore we must be at the last command
        @@savedBNFGrammer << @@prevString + '<cmd>'

        @@arrayIndex += 1
        return checkVbarQuery
      end # end of ; checker

    elsif @@grammerToArray[@@arrayIndex].to_s == 'hbar'
     # start to contruct the middle sentence
      # We need to determine if the next character contains a ;

      if @@grammerToArray[@@arrayIndex + 1].to_s.include? ';'

        # it has it so continue
        @@savedBNFGrammer << @@prevString + '<cmd>; <plot_cmd>'
        @@arrayIndex += 1
        return checkHbarQuery
      else
        #It doenst have it; therefore we must be at the last command
        @@savedBNFGrammer << @@prevString + '<cmd>'

        @@arrayIndex += 1
        return checkFillQuery
      end # end of ; checker
     
      #since nothing else has been flag, we have safely reached the end of <plot_cmd>
    elsif @@grammerToArray[@@arrayIndex].to_s == 'end'
      puts 'This is the OFFICIAL END OF THE CODE'

      printBNF#print the resulting grammer 
      #CODE BY MICHAEL
      #drawing the parse tree
      tree = ParseTree.new(@@inputGrammer) 
      tree.draw
      return true
    else

      # the current entry is not a valid entry
      puts 'Error at pos: ' + (@@inputGrammer.index(@@grammerToArray[@@arrayIndex].to_s) + 1).to_s + "; '" + @@grammerToArray[@@arrayIndex].to_s + "' Do you mean? vbar | hbar | fill  "

      return false
    end # end of if statement

    true
  end # end of checkNextStatement method

  def checkVbarQuery
    # the index has already been moved
    # check to see if the size is correct

    #Used to add the end of the cmd
    stringADD = ''

    #check to see if the current array size is 5 
    if @@grammerToArray[@@arrayIndex].size == 5

      #checks to see if ; is in the correct position
      if @@grammerToArray[@@arrayIndex].to_s[4, 1] == ';'

        # we can continue
        stringADD = '; <plot_cmd>'
      end
    else
      stringADD = ''
    end

    #push to the array
    @@savedBNFGrammer << @@prevString + 'vbar <x><y>,<y>' + stringADD

    # checks the if the first number is valid
    if ('1234567').include?(@@grammerToArray[@@arrayIndex].to_s[0, 1])

      #push to the array
      @@savedBNFGrammer << @@prevString + 'vbar ' + @@grammerToArray[@@arrayIndex].to_s[0, 1] + ' <y>,<y>' + stringADD

    else
      #Show an error as the character isnt in the list of 1-7
      puts 'Error at pos: ' + (@@inputGrammer.index(@@grammerToArray[@@arrayIndex].to_s) + 1).to_s + "; '" + @@grammerToArray[@@arrayIndex].to_s + "' Expected format: <x><y>,<y> Where x,y = {1,2,3,4,5,6,7}"

      return false
    end # end of if statement to check for the first input

    if ('1234567').include?(@@grammerToArray[@@arrayIndex].to_s[1, 1])

      @@savedBNFGrammer << @@prevString + 'vbar ' + @@grammerToArray[@@arrayIndex].to_s[0, 1] + @@grammerToArray[@@arrayIndex].to_s[1, 1] + ',<y>' + stringADD
    else
      puts 'Error at pos: ' + (@@inputGrammer.index(@@grammerToArray[@@arrayIndex].to_s) + 2).to_s + "; '" + @@grammerToArray[@@arrayIndex].to_s + "' Expected format: <x><y>,<y> Where x,y = {1,2,3,4,5,6,7}"

      return false
    end # end of if statement to check for the second input

    # checks for ,
    if @@grammerToArray[@@arrayIndex].to_s[2, 1] == ','
      #do nothing

    else
      #Show an error
      puts 'Error! unknown symbol at pos: ' + @@grammerToArray[@@arrayIndex].to_s[2, 1] + ' expected , '

      puts 'Error at pos: ' + (@@inputGrammer.index(@@grammerToArray[@@arrayIndex].to_s) + 3).to_s + "; '" + @@grammerToArray[@@arrayIndex].to_s + "' Expected ,"

      return false
    end # end of if statement to check for the third input

    # checks for FOURTH POS
    if ('1234567').include?(@@grammerToArray[@@arrayIndex].to_s[3, 1])

      @@savedBNFGrammer << @@prevString + 'vbar ' + @@grammerToArray[@@arrayIndex].to_s[0, 1] + @@grammerToArray[@@arrayIndex].to_s[1, 1] + ',' + @@grammerToArray[@@arrayIndex].to_s[3, 1] + stringADD

    else
      puts 'Error at pos: ' + (@@inputGrammer.index(@@grammerToArray[@@arrayIndex].to_s) + 4).to_s + "; '" + @@grammerToArray[@@arrayIndex].to_s + "' Expected format: <x><y>,<y> Where x,y = {1,2,3,4,5,6,7}"
      return false

    end # end of if statement to check for the fourth input

    # after successfully checking all 4 values, we look to see of there is a ; THIS indicate we have a new command to process

    # We need to check if the current index length is correct; with this we can safely compare the ;
    if (@@grammerToArray[@@arrayIndex].size == 5) && (@@grammerToArray[@@arrayIndex + 1].to_s != 'end')

      if @@grammerToArray[@@arrayIndex].to_s[4, 1] == ';'

        # we need to include the prev string as well
        @@prevString = @@prevString + 'vbar ' + @@grammerToArray[@@arrayIndex].to_s[0, 1] + @@grammerToArray[@@arrayIndex].to_s[1, 1] + ',' + @@grammerToArray[@@arrayIndex].to_s[3, 1] + ';' + ' '

        # move the counter and keep GOING
        @@arrayIndex += 1

        #hey look its that statement again from before
        #i wonder whats its doing here...
        checkNextStatement
        return true
      else
        #despite all of that, something still wasnt there as expected
        puts 'Error at pos: ' +  (@@inputGrammer.index(@@grammerToArray[@@arrayIndex].to_s) + 5).to_s +  ' expected ;'
        return false
      end # end internal loop to check for ;
    elsif (@@grammerToArray[@@arrayIndex].size == 4) && (@@grammerToArray[@@arrayIndex + 1].to_s == 'end')

      # It must be 4 chars and it closes with and end
     
      #Increment the index
      @@arrayIndex += 1

      #Yet again...
      checkNextStatement

    else # if its not 4 nor 5 then it must be an error

      puts 'Error at pos: ' + (@@inputGrammer.index(@@grammerToArray[@@arrayIndex].to_s) + 1).to_s + "; '" + @@grammerToArray[@@arrayIndex].to_s + "' Expected closure ';' but command continued"

    end # end of loop to check if it has 5 chars

    true
  end # end of checkVbarQuery

  def checkHbarQuery

     # the index has already been moved
    # check to see if the size is correct

    #Used to add the end of the cmd
    stringADD = ''

    #check to see if the current array size is 5 
    if @@grammerToArray[@@arrayIndex].size == 5

      #checks to see if ; is in the correct position
      if @@grammerToArray[@@arrayIndex].to_s[4, 1] == ';'

        # we can continue
        stringADD = '; <plot_cmd>'
      end
    else
      stringADD = ''
    end

    #push to the array
    @@savedBNFGrammer << @@prevString + 'hbar <x><y>,<x>' + stringADD

    # checks the if the first number is valid
    if ('1234567').include?(@@grammerToArray[@@arrayIndex].to_s[0, 1])

      #push to the array
      @@savedBNFGrammer << @@prevString + 'hbar ' + @@grammerToArray[@@arrayIndex].to_s[0, 1] + ' <y>,<x>' + stringADD

    else
      #Show an error as the character isnt in the list of 1-7
      puts 'Error at pos: ' + (@@inputGrammer.index(@@grammerToArray[@@arrayIndex].to_s) + 1).to_s + "; '" + @@grammerToArray[@@arrayIndex].to_s + "' Expected format: <x><y>,<x> Where x,y = {1,2,3,4,5,6,7}"

      return false
    end # end of if statement to check for the first input

    if ('1234567').include?(@@grammerToArray[@@arrayIndex].to_s[1, 1])

      @@savedBNFGrammer << @@prevString + 'hbar ' + @@grammerToArray[@@arrayIndex].to_s[0, 1] + @@grammerToArray[@@arrayIndex].to_s[1, 1] + ',<y>' + stringADD
    else
      puts 'Error at pos: ' + (@@inputGrammer.index(@@grammerToArray[@@arrayIndex].to_s) + 2).to_s + "; '" + @@grammerToArray[@@arrayIndex].to_s + "' Expected format: <x><y>,<x> Where x,y = {1,2,3,4,5,6,7}"

      return false
    end # end of if statement to check for the second input

    # checks for ,
    if @@grammerToArray[@@arrayIndex].to_s[2, 1] == ','
      #do nothing

    else
      #Show an error
      puts 'Error! unknown symbol at pos: ' + @@grammerToArray[@@arrayIndex].to_s[2, 1] + ' expected , '

      puts 'Error at pos: ' + (@@inputGrammer.index(@@grammerToArray[@@arrayIndex].to_s) + 3).to_s + "; '" + @@grammerToArray[@@arrayIndex].to_s + "' Expected ,"

      return false
    end # end of if statement to check for the third input

    # checks for FOURTH POS
    if ('1234567').include?(@@grammerToArray[@@arrayIndex].to_s[3, 1])

      @@savedBNFGrammer << @@prevString + 'hbar ' + @@grammerToArray[@@arrayIndex].to_s[0, 1] + @@grammerToArray[@@arrayIndex].to_s[1, 1] + ',' + @@grammerToArray[@@arrayIndex].to_s[3, 1] + stringADD

    else
      puts 'Error at pos: ' + (@@inputGrammer.index(@@grammerToArray[@@arrayIndex].to_s) + 4).to_s + "; '" + @@grammerToArray[@@arrayIndex].to_s + "' Expected format: <x><y>,<x> Where x,y = {1,2,3,4,5,6,7}"
      return false

    end # end of if statement to check for the fourth input

    # after successfully checking all 4 values, we look to see of there is a ; THIS indicate we have a new command to process

    # We need to check if the current index length is correct; with this we can safely compare the ;
    if (@@grammerToArray[@@arrayIndex].size == 5) && (@@grammerToArray[@@arrayIndex + 1].to_s != 'end')

      if @@grammerToArray[@@arrayIndex].to_s[4, 1] == ';'

        # we need to include the prev string as well
        @@prevString = @@prevString + 'hbar ' + @@grammerToArray[@@arrayIndex].to_s[0, 1] + @@grammerToArray[@@arrayIndex].to_s[1, 1] + ',' + @@grammerToArray[@@arrayIndex].to_s[3, 1] + ';' + ' '

        # move the counter and keep GOING
        @@arrayIndex += 1

        #hey look its that statement again from before
        #i wonder whats its doing here...
        checkNextStatement
        return true
      else
        #despite all of that, something still wasnt there as expected
        puts 'Error at pos: ' +  (@@inputGrammer.index(@@grammerToArray[@@arrayIndex].to_s) + 5).to_s +  ' expected ;'
        return false
      end # end internal loop to check for ;
    elsif (@@grammerToArray[@@arrayIndex].size == 4) && (@@grammerToArray[@@arrayIndex + 1].to_s == 'end')

      # It must be 4 chars and it closes with and end
     
      #Increment the index
      @@arrayIndex += 1

      #Yet again...
      checkNextStatement

    else # if its not 4 nor 5 then it must be an error

      puts 'Error at pos: ' + (@@inputGrammer.index(@@grammerToArray[@@arrayIndex].to_s) + 1).to_s + "; '" + @@grammerToArray[@@arrayIndex].to_s + "' Expected closure ';' but command continued"

    end # end of loop to check if it has 5 chars

    true

    
    
  end # end of checkHbarQuery method

  def checkFillQuery
   
  end # END OF checkFillQuery




  # TEMP METHOD

  def dUMPArrayThingy
    puts 'DUMPING VALUES: ' + @@savedBNFGrammer.to_s

    # printBNF
  end

  def printBNF
    @@savedBNFGrammer.each { |n| puts '<chart>→ to ' + n + ' end' }
  end
end # end of class

def didWeMakeIt(isTrue)
  if isTrue

    puts 'The command was executed successfully'

  else
    puts 'You might want to try again'

  end
end

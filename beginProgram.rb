require_relative 'parseTree'

class BeginProgram
  # initialize useful variables
  @@inputGrammer = 0
  @@grammerToArray = 0
  @@arrayIndex = 0

  # Create an array to store the BNF
  @@savedBNFGrammer = []

  # Used to concat the previous results of the BNF grammer
  @@prevString = ''

  # Grab the input from the user
  def initialize(getCommand)
    # Reset all the variables
    @@inputGrammer = 0
    @@grammerToArray = 0
    @@arrayIndex = 0
    @@savedBNFGrammer = []
    @@prevString = ''

    # Get the user's input
    @@inputGrammer = getCommand.chomp

    toArray
  end # end of getInput method

  # save the string input from the user
  def toArray
    # Take the string and break it at every white space
    @@grammerToArray = @@inputGrammer.split

    # bool for the following function
    check = false

    # Start to check for any duplicate strings consist of character
    # By Daniel - Really helpful

    # Assign variables into pairs
    @@grammerToArray.each_cons(2) do |pair|
      if ('1234567890').include?(pair.at(0)) == true || ('1234567890').include?(pair.at(1)) == true
      else
        posPush = 0

        if pair.uniq.length == pair.length
        else

          # Hey daniel, is there any variable here that remembers if the duplicate was a to or an end?
          posPush = if pair.at(0).to_s == 'to'
                      4
                    else
                      5
                    end
          # Error checking for duplicates
          puts 'Error at pos: ' + (@@inputGrammer.index(pair.at(0)) + posPush).to_s + " Duplicate entry \'" + pair.at(0).to_s + "\' was found!"
          check = true
        end
      end
    end

    # if we did NOT detect any duplicate entries then proceed
    if !check
      grammerChecker

    else # Detected dupes

      puts 'Duplicate entries next to each other is not allowed!'
      false
    end
  end # end of toArray method

  def grammerChecker
    # a bool flag to see if everything is done currectly
    isCorrect = checkTo
    didWeMakeIt(isCorrect)
  end # end of grammerChecker method

  def checkTo
    # This validate that the first entry is correct and also peeps to see if the next entry isnt immediately terminated
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

      end # end of checkEnd if statement

      true
    else

      # one of these condition is not valid

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

      false

    end # end of if statement
  end # end of checkTo method

  def checkEnd
    # check to see if the last index is an end and only one instance
    if (@@grammerToArray[@@grammerToArray.length - 1].to_s == 'end') && @@grammerToArray.grep('end').size.to_i == 1 && !@@grammerToArray[-1].to_s.include?(";")

       # do nothing

       true

    # Detected Multiple ends

    # #DEFUNCT AS MULTIPLE END CHECKS HAPPENED AT THE START
    elsif @@grammerToArray.grep('end').size.to_i > 1

      puts 'Error! Multiple "end" found; Only 1 is allowed! '

      puts 'Error at pos: ' + (@@inputGrammer.index(@@grammerToArray[@@grammerToArray.length - 1].to_s) + 1).to_s

      false

    # Detects if its not properly closed
    else

      puts 'Error at pos: ' + (@@inputGrammer.index(@@grammerToArray[@@grammerToArray.length - 1].to_s) + 1).to_s + "; '" + @@grammerToArray[@@grammerToArray.length - 1].to_s + "\' command is not closed properly! EXPECTED END"

      false
    end # end of if statement
  end # end if checkEnd method

  # This deals with the middle <plot_cmd>
  def checkNextStatement
    # TESTING

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
        # It doenst have it; therefore we must be at the last command
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
        # It doenst have it; therefore we must be at the last command
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
        return checkFillQuery
      else
        # It doenst have it; therefore we must be at the last command
        @@savedBNFGrammer << @@prevString + '<cmd>'

        @@arrayIndex += 1
        return checkFillQuery
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
        # It doenst have it; therefore we must be at the last command
        @@savedBNFGrammer << @@prevString + '<cmd>'

        @@arrayIndex += 1
        return checkFillQuery
      end # end of ; checker

      # since nothing else has been flag, we have /almost/ safely reached the end of <plot_cmd>
    elsif @@grammerToArray[@@arrayIndex].to_s == 'end'
      puts 'This is the OFFICIAL END OF THIS PROCESS'

      printBNF # print the resulting grammer
      # CODE BY MICHAEL
      # drawing the parse tree
      tree = ParseTree.new(@@inputGrammer)
      tree.draw
      # Informs the result to the user
     
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

    # Used to add the end of the cmd
    stringADD = ''

    # check to see if the current array size is 5
    if @@grammerToArray[@@arrayIndex].size == 5

      # checks to see if ; is in the correct position
      if @@grammerToArray[@@arrayIndex].to_s[4, 1] == ';'

        # we can continue
        stringADD = '; <plot_cmd>'
      end
    else
      stringADD = ''
    end

    # push to the array
    @@savedBNFGrammer << @@prevString + 'vbar <x><y>,<y>' + stringADD

    # checks the if the first number is valid
    if ('1234567').include?(@@grammerToArray[@@arrayIndex].to_s[0, 1])

      # push to the array
      @@savedBNFGrammer << @@prevString + 'vbar ' + @@grammerToArray[@@arrayIndex].to_s[0, 1] + ' <y>,<y>' + stringADD

    else
      # Show an error as the character isnt in the list of 1-7
      puts 'Error at pos: ' + (@@inputGrammer.index(@@grammerToArray[@@arrayIndex].to_s) + 1).to_s + "; '" + @@grammerToArray[@@arrayIndex].to_s + "' Expected format: <x><y>,<y> Where x,y = {1,2,3,4,5,6,7}"

      return false
    end # end of if statement to check for the first input

    # checks the if the second number is valid
    if ('1234567').include?(@@grammerToArray[@@arrayIndex].to_s[1, 1])

      # push to the array
      @@savedBNFGrammer << @@prevString + 'vbar ' + @@grammerToArray[@@arrayIndex].to_s[0, 1] + @@grammerToArray[@@arrayIndex].to_s[1, 1] + ',<y>' + stringADD
    else
      # Show an error as the character isnt in the list of 1-7
      puts 'Error at pos: ' + (@@inputGrammer.index(@@grammerToArray[@@arrayIndex].to_s) + 2).to_s + "; '" + @@grammerToArray[@@arrayIndex].to_s + "' Expected format: <x><y>,<y> Where x,y = {1,2,3,4,5,6,7}"

      return false
    end # end of if statement to check for the second input

    # checks for ,
    if @@grammerToArray[@@arrayIndex].to_s[2, 1] == ','
      # do nothing

    else
      # Show an error

      puts 'Error at pos: ' + (@@inputGrammer.index(@@grammerToArray[@@arrayIndex].to_s) + 3).to_s + "; '" + @@grammerToArray[@@arrayIndex].to_s + "' Expected ,"

      return false
    end # end of if statement to check for the third input

    # checks for FOURTH POS
    if ('1234567').include?(@@grammerToArray[@@arrayIndex].to_s[3, 1])

      # push
      @@savedBNFGrammer << @@prevString + 'vbar ' + @@grammerToArray[@@arrayIndex].to_s[0, 1] + @@grammerToArray[@@arrayIndex].to_s[1, 1] + ',' + @@grammerToArray[@@arrayIndex].to_s[3, 1] + stringADD

    else

      # show Error
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

        # hey look its that statement again from before
        # i wonder whats its doing here...
        checkNextStatement
        return true
      else
        # despite all of that, something still wasnt there as expected
        puts 'Error at pos: ' + (@@inputGrammer.index(@@grammerToArray[@@arrayIndex].to_s) + 5).to_s + ' expected ;'
        return false
      end # end internal loop to check for ;
    elsif (@@grammerToArray[@@arrayIndex].size == 4) && (@@grammerToArray[@@arrayIndex + 1].to_s == 'end')

      # It must be 4 chars and it closes with and end

      # Increment the index
      @@arrayIndex += 1

      # Yet again...
      checkNextStatement

    else # if its not 4 nor 5 then it must be an error

      puts 'Error at pos: ' + (@@inputGrammer.index(@@grammerToArray[@@arrayIndex].to_s) + 1).to_s + "; '" + @@grammerToArray[@@arrayIndex].to_s + "' Unexpected closure ';' but command continued"
      return false
    end # end of loop to check if it has 5 chars

    true
  end # end of checkVbarQuery

  def checkHbarQuery
    # the index has already been moved
    # check to see if the size is correct

    # Used to add the end of the cmd
    stringADD = ''

    # check to see if the current array size is 5
    if @@grammerToArray[@@arrayIndex].size == 5

      # checks to see if ; is in the correct position
      if @@grammerToArray[@@arrayIndex].to_s[4, 1] == ';'

        # we can continue
        stringADD = '; <plot_cmd>'
      end
    else
      stringADD = ''
    end

    # push to the array
    @@savedBNFGrammer << @@prevString + 'hbar <x><y>,<x>' + stringADD

    # checks the if the first number is valid
    if ('1234567').include?(@@grammerToArray[@@arrayIndex].to_s[0, 1])

      # push to the array
      @@savedBNFGrammer << @@prevString + 'hbar ' + @@grammerToArray[@@arrayIndex].to_s[0, 1] + ' <y>,<x>' + stringADD

    else
      # Show an error as the character isnt in the list of 1-7
      puts 'Error at pos: ' + (@@inputGrammer.index(@@grammerToArray[@@arrayIndex].to_s) + 1).to_s + "; '" + @@grammerToArray[@@arrayIndex].to_s + "' Expected format: <x><y>,<x> Where x,y = {1,2,3,4,5,6,7}"

      return false
    end # end of if statement to check for the first input

    if ('1234567').include?(@@grammerToArray[@@arrayIndex].to_s[1, 1])

      # push
      @@savedBNFGrammer << @@prevString + 'hbar ' + @@grammerToArray[@@arrayIndex].to_s[0, 1] + @@grammerToArray[@@arrayIndex].to_s[1, 1] + ',<y>' + stringADD
    else
      # show error
      puts 'Error at pos: ' + (@@inputGrammer.index(@@grammerToArray[@@arrayIndex].to_s) + 2).to_s + "; '" + @@grammerToArray[@@arrayIndex].to_s + "' Expected format: <x><y>,<x> Where x,y = {1,2,3,4,5,6,7}"

      return false
    end # end of if statement to check for the second input

    # checks for ,
    if @@grammerToArray[@@arrayIndex].to_s[2, 1] == ','
      # do nothing

    else
      # Show an error

      puts 'Error at pos: ' + (@@inputGrammer.index(@@grammerToArray[@@arrayIndex].to_s) + 3).to_s + "; '" + @@grammerToArray[@@arrayIndex].to_s + "' Expected ,"

      return false
    end # end of if statement to check for the third input

    # checks for FOURTH POS
    if ('1234567').include?(@@grammerToArray[@@arrayIndex].to_s[3, 1])

      # push
      @@savedBNFGrammer << @@prevString + 'hbar ' + @@grammerToArray[@@arrayIndex].to_s[0, 1] + @@grammerToArray[@@arrayIndex].to_s[1, 1] + ',' + @@grammerToArray[@@arrayIndex].to_s[3, 1] + stringADD

    else
      # show error
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

        # hey look its that statement again from before
        # i wonder whats its doing here...
        checkNextStatement
        return true
      else
        # despite all of that, something still wasnt there as expected
        puts 'Error at pos: ' + (@@inputGrammer.index(@@grammerToArray[@@arrayIndex].to_s) + 5).to_s + ' expected ;'
        return false
      end # end internal loop to check for ;
    elsif (@@grammerToArray[@@arrayIndex].size == 4) && (@@grammerToArray[@@arrayIndex + 1].to_s == 'end')

      # It must be 4 chars and it closes with and end

      # Increment the index
      @@arrayIndex += 1

      # Yet again...
      checkNextStatement

    else # if its not 4 nor 5 then it must be an error

      puts 'Error at pos: ' + (@@inputGrammer.index(@@grammerToArray[@@arrayIndex].to_s) + 1).to_s + "; '" + @@grammerToArray[@@arrayIndex].to_s + "' Unexpected closure ';' but command continued"
      return false
    end # end of loop to check if it has 5 chars

    true
  end # end of checkHbarQuery method

  def checkFillQuery
    puts @@grammerToArray[@@arrayIndex].to_s
    # the index has already been moved
    # check to see if the size is correct

    # Used to add the end of the cmd
    stringADD = ''

    if @@grammerToArray[@@arrayIndex].size == 3

      # checks to see if ; is in the correct position
      if (@@grammerToArray[@@arrayIndex].to_s[2, 1] == ';') && (@@grammerToArray[@@arrayIndex + 1].to_s != 'end')

        # we can continue
        stringADD = '; <plot_cmd>'

      else # it is NOT a ;
        if @@grammerToArray[@@arrayIndex].to_s[2, 1] != ';'

          puts 'Error at pos: ' + (@@inputGrammer.index(@@grammerToArray[@@arrayIndex].to_s) + 3).to_s + '; ' + @@grammerToArray[@@arrayIndex].to_s + ' Expected ;'

        else

          puts 'Error at pos: ' + (@@inputGrammer.index(@@grammerToArray[@@arrayIndex].to_s) + 3).to_s + '; ' + @@grammerToArray[@@arrayIndex].to_s + ' Unexpected end found; Expected <cmd>'

          return false
        end

        return false
      end

    else
      stringADD = ''
    end

    # push to the array
    @@savedBNFGrammer << @@prevString + 'fill <x><y>' + stringADD

    # checks the if the first number is valid
    if ('1234567').include?(@@grammerToArray[@@arrayIndex].to_s[0, 1])

      # push to the array
      @@savedBNFGrammer << @@prevString + 'fill ' + @@grammerToArray[@@arrayIndex].to_s[0, 1] + ' <y>' + stringADD

    else
      # Show an error as the character isnt in the list of 1-7
      puts 'Error at pos: ' + (@@inputGrammer.index(@@grammerToArray[@@arrayIndex].to_s) + 1).to_s + "; '" + @@grammerToArray[@@arrayIndex].to_s + "' Expected format: <x><y> Where x,y = {1,2,3,4,5,6,7}"

      return false
    end # end of if statement to check for the first input

    if ('1234567').include?(@@grammerToArray[@@arrayIndex].to_s[1, 1])

      @@savedBNFGrammer << @@prevString + 'fill ' + @@grammerToArray[@@arrayIndex].to_s[0, 1] + @@grammerToArray[@@arrayIndex].to_s[1, 1] + stringADD
    else
      puts 'Error at pos: ' + (@@inputGrammer.index(@@grammerToArray[@@arrayIndex].to_s) + 2).to_s + "; '" + @@grammerToArray[@@arrayIndex].to_s + "' Expected format: <x><y> Where x,y = {1,2,3,4,5,6,7}"

      return false
    end # end of if statement to check for the second input

    # after successfully checking all 2 values, we look to see of there is a ; THIS indicate we have a new command to process

    # We need to check if the current index length is correct; with this we can safely compare the ;
    if (@@grammerToArray[@@arrayIndex].size == 3) && (@@grammerToArray[@@arrayIndex + 1].to_s != 'end')

      if @@grammerToArray[@@arrayIndex].to_s[2, 1] == ';'

        # we need to include the prev string as well
        @@prevString = @@prevString + 'fill ' + @@grammerToArray[@@arrayIndex].to_s[0, 1] + @@grammerToArray[@@arrayIndex].to_s[1, 1] + ';' + ' '

        # move the counter and keep GOING
        @@arrayIndex += 1

        # hey look its that statement again from before
        # i wonder whats its doing here...
        checkNextStatement
        return true
      else
        # despite all of that, something still wasnt there as expected
        puts 'Error at pos: ' + (@@inputGrammer.index(@@grammerToArray[@@arrayIndex].to_s) + 3).to_s + ' expected ;'
        return false
      end # end internal loop to check for ;

    elsif (@@grammerToArray[@@arrayIndex].size == 2) && (@@grammerToArray[@@arrayIndex + 1].to_s == 'end')

      # It must be 3 chars and it closes with and end

      # Increment the index
      @@arrayIndex += 1

      # Yet again...
      checkNextStatement

    else # if its not 2 nor 3 then it must be an error

      puts 'Error at pos: ' + (@@inputGrammer.index(@@grammerToArray[@@arrayIndex].to_s) + 3).to_s + "; '" + @@grammerToArray[@@arrayIndex].to_s + 'Expected <cmd>'
      return false

      # invalid format; Expected <x>,<y> Where xy = {1,2,3,4,5,6,7}

    end # end of loop to check if it has 5 chars

    true
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

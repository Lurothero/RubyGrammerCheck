class BeginProgram
  @@inputGrammer = 0
  @@grammerToArray = 0
  @@arrayIndex = 0
  @@stringPos = 0

  # use an array maybe 2d array

  # Create an array to store the BNF
  @@savedBNFGrammer = []

  @@prevString = ''

  # Grab the input from the user
  def getInput
    puts 'ENTER GRAMMER RULE'
    @@inputGrammer = gets
    # puts @@inputGrammer

    toArray
  end # end of getInput method

  # save the string input from the user
  def toArray
    @@grammerToArray = @@inputGrammer.split
    # puts @@grammerToArray

    grammerChecker
  end # end of toArray method

  def grammerChecker
    # CALL THE OTHER FUNCTION
    checkTo # should be rename to actual start or something
  end # end of grammerChecker method

  def checkTo
    # Keep it simple and add all the bells and whisles After
    if (@@grammerToArray[0].to_s == 'to') && (@@grammerToArray[@@arrayIndex + 1].to_s != 'end')
      # thx

      # check if the end is valid
      if checkEnd

        # Lets build the string and then push it into an array
        @@savedBNFGrammer << @@prevString + '<plot_cmd>'

        dUMPArrayThingy

        # Bruh just save the token parts of it and make the array iterate it somewhere

        # count the position
        @@stringPos += @@grammerToArray[0].length #We might not need this actually

        # Iterate the array index
        @@arrayIndex += 1

        # call the next function
        checkNextStatement
      end # end of checkEnd if statement
    else

      # one of these is not valid

      if @@grammerToArray[0].to_s != 'to'
        # The first entry is not valid so throw an error at the user
        puts "Error at pos: " +(@@inputGrammer.index(@@grammerToArray[0].to_s)+1).to_s +  "; '"  + @@grammerToArray[0].to_s + "\' not recognized!"
        return false
      end

      if @@grammerToArray[@@arrayIndex + 1].to_s == 'end'
        # There is nothing to continue with so throw an error to the user
        puts "Error at pos: " +(@@inputGrammer.index(@@grammerToArray[1].to_s)+1).to_s +  "; '"  + @@grammerToArray[1].to_s + "\' UNEXPECTED end found; EXPECTED <plot_cmd>"

        return false
      end

      # call the function again??
      return false

    end # end of if statement

    true
  end # end of checkTo method

  def checkEnd
    # check to see if the last index is an end
    if @@grammerToArray[@@grammerToArray.length - 1].to_s == 'end'

      true
    else
      puts 'Unexpected end of file; EXPECTED end'
        #the length of the entire array - 1

      puts "Error at pos: " +(@@inputGrammer.index(@@grammerToArray[@@grammerToArray.length-1].to_s)+1).to_s +  "; '"  + @@grammerToArray[@@grammerToArray.length-1].to_s + "\' command is not closed properly! EXPECTED END"


      false
    end # end of if statement
  end # end if checkEnd method

  # MAKE THIS RECURSIVE
  # This need to generate the middle part

  def checkNextStatement
    # create a temp variable to construct the middle part

    stringFormer = ''

    # it will iterate auto

    if @@grammerToArray[@@arrayIndex].to_s == 'vbar'
      # start to contruct the middle sentence
      # We need to determine if the next character contains a ;

      if @@grammerToArray[@@arrayIndex + 1].to_s.include? ';'

        # it has it so continue

        puts '<cmd>; < plot_cmd >'
        @@savedBNFGrammer << @@prevString + '<cmd>; < plot_cmd >'

        dUMPArrayThingy

        @@arrayIndex += 1
        checkVbarQuery
      else
        puts '<cmd> '
        @@savedBNFGrammer << @@prevString + '<cmd>'

        dUMPArrayThingy

        stringFormer += '<cmd> '
        @@arrayIndex += 1
        checkVbarQuery
      end # end of ; checker
    elsif @@grammerToArray[@@arrayIndex].to_s == 'hbar'
      puts 'you entered hbar'
      @@arrayIndex += 1
      checkHbarQuery
    elsif @@grammerToArray[@@arrayIndex].to_s == 'fill'
      puts 'you entered fill'
      @@arrayIndex += 1
      checkFillQuery
    elsif @@grammerToArray[@@arrayIndex].to_s == 'end'
      puts 'This is the OFFICIAL END OF THE CODE'
      return true
    else
      puts 'Error! Unknown command: ' + @@grammerToArray[@@arrayIndex].to_s + ' At pos: ' + 'SOME POSITION'

      return false
    end # end of if statement

    true
  end # end of checkNextStatement method

  def checkVbarQuery
    # the index has already been moved
    # check to see if the size is correct

    stringADD = ''

    if @@grammerToArray[@@arrayIndex].size == 5
      if @@grammerToArray[@@arrayIndex].to_s[4, 1] == ';'

        # we can continue
        stringADD = ';<plot_cmd>'
      end
    else
      stringADD = ''
    end

    puts 'vbar <x><y>,<y> '

    # potential if statement

    @@savedBNFGrammer << @@prevString + 'vbar <x><y>,<y>' + stringADD

    dUMPArrayThingy

    # checks the if the first number is valid
    if ('1234567').include?(@@grammerToArray[@@arrayIndex].to_s[0, 1])
      puts 'vbar ' + @@grammerToArray[@@arrayIndex].to_s[0, 1] + ' <y>,<y>'

      @@savedBNFGrammer << @@prevString + 'vbar ' + @@grammerToArray[@@arrayIndex].to_s[0, 1] + ' <y>,<y>' + stringADD

      dUMPArrayThingy
    else
      puts 'ERROR UNRECOGNIZED ENTRY AT FIRST POSITION'
      return false
    end # end of if statement to check for the first input

    if ('1234567').include?(@@grammerToArray[@@arrayIndex].to_s[1, 1])
      puts 'vbar ' + @@grammerToArray[@@arrayIndex].to_s[0, 1] + @@grammerToArray[@@arrayIndex].to_s[1, 1] + ',<y>'

      @@savedBNFGrammer << @@prevString + 'vbar ' + @@grammerToArray[@@arrayIndex].to_s[0, 1] + @@grammerToArray[@@arrayIndex].to_s[1, 1] + ',<y>' + stringADD
    else
      puts 'ERROR UNRECOGNIZED ENTRY AT SECOND POSITION'
      return false
    end # end of if statement to check for the second input

    # checks for ,
    if @@grammerToArray[@@arrayIndex].to_s[2, 1] == ','

      # prob not needed

      # puts "vbar " +  @@grammerToArray[@@arrayIndex].to_s[0,1] +  @@grammerToArray[@@arrayIndex].to_s[1,1]  + ","  + "<y>"

    else
      puts "Error! unknown symbol at pos: " +  @@grammerToArray[@@arrayIndex].to_s[2, 1]  +" expected , " 
      return false
    end # end of if statement to check for the third input

    # checks for FOURTH POS
    if ('1234567').include?(@@grammerToArray[@@arrayIndex].to_s[3, 1])
      puts 'vbar ' + @@grammerToArray[@@arrayIndex].to_s[0, 1] + @@grammerToArray[@@arrayIndex].to_s[1, 1] + ',' + @@grammerToArray[@@arrayIndex].to_s[3, 1]

      @@savedBNFGrammer << @@prevString + 'vbar ' + @@grammerToArray[@@arrayIndex].to_s[0, 1] + @@grammerToArray[@@arrayIndex].to_s[1, 1] + ',' + @@grammerToArray[@@arrayIndex].to_s[3, 1] + stringADD

      dUMPArrayThingy
    else
      puts 'ERROR UNRECOGNIZED ENTRY AT FOURTH POSITION'
      return false
    end # end of if statement to check for the fourth input

    # after successfully checking all 4 values, we look to see of there is a ; THIS indicate we have a new command to process

    ####################################
    # MIGHT NEED TO MOVE THIS SOMEWHERE
    # VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVv
    # #########################3

    # We need to check if the current index length is correct; with this we can safely compare the ;
    if @@grammerToArray[@@arrayIndex].size == 5  and @@grammerToArray[@@arrayIndex+1].to_s != "end"

    
      if @@grammerToArray[@@arrayIndex].to_s[4, 1] == ';'

        #
        #       puts "vbar " +  @@grammerToArray[@@arrayIndex].to_s[0,1] +  @@grammerToArray[@@arrayIndex].to_s[1,1]  + ","  + @@grammerToArray[@@arrayIndex].to_s[3,1] + ";"
        #

        # we need to include the prev string as well
        @@prevString = @@prevString + 'vbar ' + @@grammerToArray[@@arrayIndex].to_s[0, 1] + @@grammerToArray[@@arrayIndex].to_s[1, 1] + ',' + @@grammerToArray[@@arrayIndex].to_s[3, 1] + ';' + ' '


        # move the counter and keep GOING
        @@arrayIndex += 1

        puts @@prevString

        checkNextStatement
        return true
      else
        puts 'Error at pos: ' + 'expected ;'
        return false
      end # end internal loop to check for ;
    elsif  @@grammerToArray[@@arrayIndex].size == 4 and @@grammerToArray[@@arrayIndex+1].to_s == "end"
      
      # It must be 4 chars and it closes with and end

      #cant safely assume it is only 4 char long
    
      @@arrayIndex += 1
      checkNextStatement

    else#if its not 4 nor 5 then it must be an error
      puts "Error at pos: " +"SOME POS " + "Invalid Format: " + @@grammerToArray[@@arrayIndex].to_s



    end # end of loop to check if it has 5 chars

    true
  end # end of checkVbarQuery

  def checkHbarQuery
    # the index has already been moved

    # checks the if the first number is valid
    if ('1234567').include?(@@grammerToArray[@@arrayIndex].to_s[0, 1]) # and @@grammerToArray[@@arrayIndex].to_s.include? ";" #CHECKS if it has a ;
      puts @@grammerToArray[@@arrayIndex - 1].to_s + ' WAS THE LAST ENTRY'
    end # end of if statement to check for the first input

    if ('1234567').include?(@@grammerToArray[@@arrayIndex].to_s[1, 1])
      puts 'to ' + @@grammerToArray[@@arrayIndex - 1].to_s + ' ' + @@grammerToArray[@@arrayIndex].to_s[0, 1] + ' <y>,<y>' + ' end'
    end # end of if statement to check for the second input

    # checks for ,
    if @@grammerToArray[@@arrayIndex].to_s[2, 1] == ','
      puts 'to ' + @@grammerToArray[@@arrayIndex - 1].to_s + ' ' + @@grammerToArray[@@arrayIndex].to_s[0, 1] + @@grammerToArray[@@arrayIndex].to_s[1, 1] + ',<y>' + ' end'
    end # end of if statement to check for the third input

    # checks for last y
    if ('1234567').include?(@@grammerToArray[@@arrayIndex].to_s[3, 1])
      puts 'to ' + @@grammerToArray[@@arrayIndex - 1].to_s + ' ' + @@grammerToArray[@@arrayIndex].to_s[0, 1] + @@grammerToArray[@@arrayIndex].to_s[1, 1] + ',' + @@grammerToArray[@@arrayIndex].to_s[3, 1] + ' end'
    end # end of if statement to check for the fourth input

    # after successfully checking all 4 values, we look to see of there is a ; THIS indicate we have a new command to process

    # We need to check if the current index length is correct; with this we can safely compare the ;
    if @@grammerToArray[@@arrayIndex].size == 5
      if @@grammerToArray[@@arrayIndex].to_s[4, 1] == ';'
        puts 'WE HAVE A SEMICOLON KEEP GOING!!!'

        # move the counter and keep GOING
        @@arrayIndex += 1
        checkNextStatement
      else
        puts 'Error at pos: ' + 'expected ;'
      end # end internal loop to check for ;
    end # end of loop to check if it has 5 chars
  end # end of checkHbarQuery method

  def checkFillQuery
    # the index has already been moved

    # checks the if the first number is valid
    if ('1234567').include?(@@grammerToArray[@@arrayIndex].to_s[0, 1]) # and @@grammerToArray[@@arrayIndex].to_s.include? ";" #CHECKS if it has a ;
      puts @@grammerToArray[@@arrayIndex - 1].to_s + ' WAS THE LAST ENTRY'
    end # end of if statement to check for the first input

    # check the if the second number is valid
    if ('1234567').include?(@@grammerToArray[@@arrayIndex].to_s[1, 1])
      puts 'to ' + @@grammerToArray[@@arrayIndex - 1].to_s + ' ' + @@grammerToArray[@@arrayIndex].to_s[0, 1] + ' <y>,<y>' + ' end'
    end # end of if statement to check for the second input

    # after successfully checking all 4 values, we look to see of there is a ; THIS indicate we have a new command to process

    # We need to check if the current index length is correct; with this we can safely compare the ;
    if @@grammerToArray[@@arrayIndex].size == 3
      if @@grammerToArray[@@arrayIndex].to_s[2, 1] == ';'
        puts 'WE HAVE A SEMICOLON KEEP GOING!!!'

        # move the counter and keep GOING
        @@arrayIndex += 1
        checkNextStatement
      else
        puts 'Error at pos: ' + 'expected ;'
      end # end internal loop to check for ;
    end # end of loop to check if it has 5 chars
  end # END OF checkFillQuery

  # TEMP METHOD

  def dUMPArrayThingy
    puts 'DUMPING VALUES: ' + @@savedBNFGrammer.to_s
  end
end # end of class

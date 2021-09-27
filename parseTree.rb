=begin

READ ME!
the class ParseTree is the main class
the class Parse_Line_Prefix is helper/child class of ParseTree
therefore you'll only be creating a ParseTree object

remember ParseTree just receivees a raw input string 
example: "to vbar 43,1; fill 22 end"

my program doesn't do any error checking at all so make the input string
checks out before inputting into my program

on another note besides creating the object the only function you should call is
.draw

that function will draw the actual parse tree

-michael
=end

#sub-class for ParseLine
class Parse_Line_Prefix
  @@layer_count = 0       #amount of layers from the left edge of the console output
  @@layer = "      "         #representation of distance from edge of screen
  @@layer_branch = "     |"  #represenation of a branch for the tree
  @@prefix = Array.new    #the actual prefix that will go infront of the parse line object

  def initialize
  end

  #returns the amount layers that are being used
  def getLayerCount
    return @@layer_count
  end

  #this function adds a layer to the prefix array
  def addLevel
    @@prefix << @@layer
    @@layer_count+= 1
  end

  #this function adds a branch to the prefix array
  def addLevelBranch
    @@prefix << @@layer_branch
    @@layer_count+= 1
  end

  #this function removes a branch array based on the int from the argument
  def changeBranch(arg)
    @@prefix[arg] = "x"
  end

  def removeLevel
    @@prefix.pop #removing the last layer
  end

  #resets the prefix array
  def reset
    @@prefix = Array.new
    @@layer_count = 0
  end

  #this returns a string to the caller
  def getPrefix
    @rv = @@prefix.join("") + "`-- "
    return @rv
  end
end

class ParseTree
  @@input = ""
  @@semicolons = 0
  @@pre = Parse_Line_Prefix.new
  @@lexemes = Array["to","end", ";", ",", "vbar", "hbar", "fill", "1", "2", "3", "4", "5", "6", "7"]

  @@printing_list = []

  #initializing the @@input variable
  def initialize(arg)
    @@input = arg

    #finding out how many semicolons are in the <plot_cmd>
    @@semicolons = @@input.count(";")
    @processing_arr = @@input.split
    @@printing_list = filter(@processing_arr)

  end

  #this function draws the parse tree
  def draw
    #starting and calling the first recursive function
    masterPrint(@@printing_list)
  end

  #helper functions
  def masterPrint(arg)
    #grabbing the first element of the printing_list
    @holder = arg[0]
    
    case @holder
    when "to" #literally always the first case
      printChart(@holder)
    when "<plot_cmd>" #this case will handle if they're multiple <cmd>
      printPlot_Cmd(@holder)
    when "<cmd>*" #just printing the <cmd> but making sure to factor in the next <plot_cmd>
      printCmdPlus
    when ";"
      printSemiColon(@holder)
    when "<cmd>" #just printting the <cmd>
      printCmd(@holder)
    when "end"
      printEnd(@holder)
    else
      removeFirst
      masterPrint(@@printing_list)
    end
  end

  def printEnd(arg)
    @@pre.reset
    @@pre.addLevel
    puts @@pre.getPrefix + arg
    @@pre.reset
  end

  def printChart(arg)
    #starting the parse tree
    puts "<chart>"
    @@pre.addLevelBranch #adds the first level to the ParseTree
    
    #printing "to" in the parse three
    puts @@pre.getPrefix + arg

    removeFirst #removing "to" from the printing_list
    insert("<plot_cmd>") #inserting "<plot_cmd>" into the printing_list
    masterPrint(@@printing_list)
  end

  def printPlot_Cmd(arg)#dealing with multiple <cmds>
    if @@semicolons > 0 #if they're multiple "<cmds>"
      #printing "<plot_cmd>"
      puts @@pre.getPrefix + arg
      removeFirst  #removing "<plot_cmd> from the printing_list"

      @@pre.addLevelBranch #adding a branch since they're more <cmds>

      insert("<cmd>*")
      masterPrint(@@printing_list)
    else #this will be if they're only one "<cmd>"
      #printing "<plot_cmd>"
      #if @@pre.getLayerCount != 1
      #  removePBranch
      #end

      puts @@pre.getPrefix + arg
      removeFirst  #removing "<plot_cmd> from the printing_list"

      @@pre.addLevel #adding a level since there won't be more <cmd>

      insert("<cmd>")
      masterPrint(@@printing_list)
    end
  end

  def printCmdPlus
    removeFirst #removing the <cmd>* from the printing_list
    puts @@pre.getPrefix + "<cmd>" #printing <cmd>

    #grabbing the first element in printing_list
    @holder = @@printing_list[0]


    #dealing with the sub trees of <cmd>
    handleSubs(@holder)
  end

  def printSemiColon(arg)
    puts @@pre.getPrefix + arg #printing ;
    removeFirst #removing ; from the printing list
    @@semicolons -= 1

    @@pre.removeLevel
    @@pre.addLevel

    insert("<plot_cmd>")
    masterPrint(@@printing_list)
  end

  def printCmd(arg)
    puts @@pre.getPrefix + arg
    removeFirst

    @holder = @@printing_list[0]
    handleSubs(@holder)
  end

  def printVbar(arg)
    @@pre.addLevel 
    puts @@pre.getPrefix + arg #printing vbar
    removeFirst #removing vbar from the printing_list 

    @@pre.addLevelBranch
    puts @@pre.getPrefix + "<x>" #prints <x>

    @@pre.addLevel
    puts @@pre.getPrefix + @@printing_list[0] #prints the number for <x>
    removeFirst

    @@pre.removeLevel
    puts @@pre.getPrefix + "<y>" #prints <y>

    @@pre.addLevel
    puts @@pre.getPrefix + @@printing_list[0] #prints the number for <y>
    removeFirst

    @@pre.removeLevel
    puts @@pre.getPrefix + @@printing_list[0] #prints the , 
    removeFirst

    removePBranch
    #puts @@pre.getLayerCount

    puts @@pre.getPrefix + "<y>" #prints <y>

    @@pre.addLevel
    puts @@pre.getPrefix + @@printing_list[0] #prints the number for <y>

    #removing all branchs past <cmd> in the parse three
    @@pre.removeLevel
    @@pre.removeLevel
    @@pre.removeLevel

    masterPrint(@@printing_list)
  end

  def printHbar(arg)
    @@pre.addLevel
    puts @@pre.getPrefix + arg #printing hbar
    removeFirst #removing hbar from the printing_list

    @@pre.addLevelBranch
    puts @@pre.getPrefix + "<x>" #prints <x>

    @@pre.addLevel
    puts @@pre.getPrefix + @@printing_list[0] #prints the number for <x>
    removeFirst
    
    @@pre.removeLevel
    puts @@pre.getPrefix + "<y>" #prints <y>

    @@pre.addLevel
    puts @@pre.getPrefix + @@printing_list[0] #prints the number for <y>
    removeFirst

    @@pre.removeLevel
    puts @@pre.getPrefix + @@printing_list[0] #prints the , 
    removeFirst

    removePBranch

    puts @@pre.getPrefix + "<x>" #prints <x>

    @@pre.addLevel
    puts @@pre.getPrefix + @@printing_list[0] #prints the number for <x>

    #removing all branchs past <cmd> in the parse three
    @@pre.removeLevel
    @@pre.removeLevel
    @@pre.removeLevel

    masterPrint(@@printing_list)

  end

  def printFill(arg)
    @@pre.addLevel
    puts @@pre.getPrefix + arg #printing fill
    removeFirst #removing fill from the printing_list

    @@pre.addLevelBranch
    puts @@pre.getPrefix + "<x>" #prints <x>

    @@pre.addLevel
    puts @@pre.getPrefix + @@printing_list[0] #prints the number for <x>
    removeFirst
    
    removePBranch

    @@pre.removeLevel
    puts @@pre.getPrefix + "<y>" #prints <y>

    @@pre.addLevel
    puts @@pre.getPrefix + @@printing_list[0] #prints the number for <y>
    removeFirst

    #removing all branchs past <cmd> in the parse three
    @@pre.removeLevel
    @@pre.removeLevel
    @@pre.removeLevel

    masterPrint(@@printing_list)
  end

  def handleSubs(arg)
    case arg
    when "vbar"
      printVbar(arg)
    when "hbar"
      printHbar(arg)
    when "fill"
      printFill(arg)
    end
  end

  def removePBranch
    @@pre.removeLevel
    @@pre.removeLevel
    @@pre.addLevel
    @@pre.addLevel
  end

  def insert(arg)
    @@printing_list.unshift(arg) #putting the arg infront of the printing list
  end

  def removeFirst
    @@printing_list.shift() #removes the first value from the @@printing_list
  end
  
  #takes in array of strings and returns a array prepared for use
  def filter(arg)
    @holder = ""
    @stack = []

    #going through the list
    for i in arg
      if(isLexeme(i))
        @stack << i #this pushs the lexeme into the array
      else 
        #since we know it's not a lexeme we split it because
        #it will most likely be the non-terminal for the <x><y>,<x>
        temp = i.split("")
        
        #pushes the lexems into the processing stack
        for x in temp
          @stack << x
        end

      end
    end

    return @stack
  end

  #takes in a string and checks if it's a lexeme
  def isLexeme(arg)
    for i in @@lexemes
      if arg == i
        return true
      end
    end
    return false
  end
end

=begin
demo for the input
i = "to vbar 43,1; fill 22; hbar 32,1 end"
tree = ParseTree.new(i)
tree.draw
=end
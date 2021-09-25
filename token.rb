#NOTE THIS FILE IS DEFUNCT
#NOTE THIS FILE IS DEFUNCT
#NOTE THIS FILE IS DEFUNCT
#NOTE THIS FILE IS DEFUNCT


=begin


require 'strscan'#import String Scanner


class Token #MUST BE CAPITAL
  #YOU CANNOT OVERLOAD METHODS

  #Create token variables?
  @@token_var = "VAR"
  @@token_plus = "PLUS"
  @@token_minus = "MINUS"




  #Object Variable
  attr_accessor :type, :value

  

  def Token_initialize(type, value)
    @type = type
    @value =value

  end

 

  def Token_Output

      puts @type
      puts @value

  end



 

end#end of class

class Lexar

  attr_accessor :input


  def Lexar_Constructor(string_IN)
    @input = string_IN


    #track text
    string = StringScanner.new(@input)

    #track position
    pos = string.pos()

    #track current char
    currentChar = string.charpos()

  end


  def Lexar_Advance

    


  end

end#end of Lexar class


=end

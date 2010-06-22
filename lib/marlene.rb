module Marlene  

  ANCHOR_TEXTNODE = "I'm a bookmarklet"

  def self.build(input)
    input
  end  
  
  def Marlene.to_bookmarklet(input)
    js = Marlene::JavaScript.new(input)
    js.clean
    js.escape
    js.prefix
  end
  
  class JavaScript
    
    require 'uri'

    def initialize(code)
       @code = code
    end
    
    def clean
      @code.gsub!(/^ +/, '')           # remove line-leading whitespace
      @code.gsub!(/ +$/, '')           # remove line-ending whitespace
      @code.gsub!(/\t/, ' ')           # replace tabs with spaces
      @code.gsub!(/ +/, ' ')           # replace multiple spaces with a single space
      @code.gsub!(/^ *\/\/.+\n/, '')   # remove comment lines starting with a double slash
      @code.gsub!(/\n/, '')            # remove all newlines
      @code
    end
    
    def escape
      @code = URI.escape(@code, ' ')   # URI escape spaces only
    end

    def prefix
      @code = 'javascript:' + @code    # prefix with 'javascript:'
    end

  end
end
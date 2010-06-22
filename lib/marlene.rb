module Marlene  

  require 'uri'

  ANCHOR_TEXTNODE = "I'm a bookmarklet"

  def Marlene.to_bookmarklet(input)
    input.gsub!(/^ +/, '')           # remove line-leading whitespace
    input.gsub!(/ +$/, '')           # remove line-ending whitespace
    input.gsub!(/\t/, ' ')           # replace tabs with spaces
    input.gsub!(/ +/, ' ')           # replace multiple spaces with a single space
    input.gsub!(/^ *\/\/.+\n/, '')   # remove comment lines starting with a double slash
    input.gsub!(/\n/, '')            # remove all newlines
    input = URI.escape(input, ' ')   # URI escape spaces only
    'javascript:' + input            # prefix with 'javascript:'
  end

end
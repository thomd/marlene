module Marlene  

  require 'uri'

  ANCHOR_TEXTNODE = "I'm a bookmarklet"

  def Marlene.to_bookmarklet(input)
    js = input.to_s
    js = js.gsub(/^ +/, '')           # remove line-leading whitespace
    js = js.gsub(/ +$/, '')           # remove line-ending whitespace
    js = js.gsub(/\t/, ' ')           # replace tabs with spaces
    js = js.gsub(/ +/, ' ')           # replace multiple spaces with a single space
    js = js.gsub(/^ *\/\/.+\n/, '')   # remove comment lines starting with a double slash
    js = js.gsub(/\n/, '')            # remove all newlines
    js = URI.escape(js, ' ')          # URI escape spaces only
    'javascript:' + js                # prefix with 'javascript:'
  end

end
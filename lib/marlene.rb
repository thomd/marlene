require 'uri'

module Marlene  

  ANCHOR_TEXTNODE = "I'm a bookmarklet"

  LOADER_SCRIPT = "
    (function(){
        var script = document.createElement('script');
        script.type = 'text/javascript';
        script.src = '{{script}}?' + (new Date().getTime());
        document.getElementsByTagName('body')[0].appendChild(script);
    })()
  "
  
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

  def Marlene.to_remote_bookmarklet(input)
    js = Marlene::LOADER_SCRIPT.to_s.gsub(/\{\{script\}\}/, input.to_s)
    Marlene.to_bookmarklet(js)
  end

end
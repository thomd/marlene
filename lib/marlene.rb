require "uri"
require "yui/compressor"
require "mustache"

module Marlene  

  ANCHOR_TEXTNODE = "bookmarklet"
  PSEUDOCOL       = "javascript:"
  LOADER_SCRIPT   = "
    (function(){
        var script = document.createElement('script');
        script.type = 'text/javascript';
        script.src = '{{script}}?' + (new Date().getTime());
        document.getElementsByTagName('body')[0].appendChild(script);
    })()
  "
  HTML_OUTPUT     = "<!DOCTYPE html>
<html>
  <head>
    <meta charset=\"utf-8\" />
    <title>"+ANCHOR_TEXTNODE+"</title>
  </head>
  <body>
    <a href=\"{{bookmarklet}}\">"+ANCHOR_TEXTNODE+"</a>  
  </body>
</html>"

  def yui_compressor
    YUI::JavaScriptCompressor.new(:munge => true)
  end
end


class String
  include Marlene

  def to_bookmarklet
    js = self.to_s
    js.gsub!(/^ +/, '')                # remove line-leading whitespace
    js.gsub!(/ +$/, '')                # remove line-ending whitespace
    js.gsub!(/\t/, ' ')                # replace tabs with spaces
    js.gsub!(/ +/, ' ')                # replace multiple spaces with a single space
    js.gsub!(/^ *\/\/.+\n/, '')        # remove comment lines starting with a double slash
    js.gsub!(/\n/, '')                 # remove all newlines
    js = URI.escape(js, ' ')           # URI escape spaces only
    PSEUDOCOL + js                     # prefix with 'javascript:'
  end

  def compress
    yui_compressor.compress(self)      # use YUI compressor to minimize javascript code
  end

  def to_loader_script
    LOADER_SCRIPT.gsub(/\{\{script\}\}/, self)     # insert into loader script a javascript URL
  end
  
  def to_bookmarklet_page
    HTML_OUTPUT.gsub(/\{\{bookmarklet\}\}/, self)  # insert bookmarklet into html code for drag-drop bookmarklet onto libkbar
  end
end

require "uri"
require "yui/compressor"
require "mustache"


module Marlene  

  VERSION          = "0.1.0"
  ANCHOR_TEXTNODE  = "bookmarklet"
  PSEUDOCOL        = "javascript:"
  LOADER_SCRIPT    = File.join(File.dirname(__FILE__), 'templates', 'loader.js')
  BOOKMARKLET_PAGE = File.join(File.dirname(__FILE__), 'templates', 'page.html')

  def yui_compressor
    YUI::JavaScriptCompressor.new(:munge => true)
  end
  
end


class String
  include Marlene

  # transform into bookmarklet
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

  # use YUI compressor to minimize javascript code
  def compress
    yui_compressor.compress(self)
  end

  # insert into loader script a javascript URL
  def to_loader_script
    Mustache.template_file = LOADER_SCRIPT
    loader = Mustache.new
    loader[:script] = self
    loader.render
  end
  
  # insert bookmarklet into html code for drag-drop bookmarklet up to linkbar
  def to_bookmarklet_page
    Mustache.template_file = BOOKMARKLET_PAGE
    page = Mustache.new
    page[:bookmarklet] = self
    page[:anchor] = ANCHOR_TEXTNODE
    page.render
  end
  
end


require "rubygems"
require "spec"
require File.dirname(__FILE__) + '/../lib/marlene.rb'

describe "Marlene bookmark generator" do

  before(:all) do
    @remote_url = "http://example.com/this/is/a/remote/javascript.js"   
  end

  it "should transform a local javascript file to a bookmarklet" do
    input  = javascript_local
    output = bookmarklet_local
    input.to_bookmarklet.should == output
  end
  
  it "should transform and escape a local javascript file to a bookmarklet" do
    input  = javascript_local_unescaped
    output = bookmarklet_local_escaped
    input.to_bookmarklet.should == output
  end
  
  it "should transform an external javascript into a bookmarklet loaderscript" do
    input  = @remote_url
    output = bookmarklet_remote
    input.to_loader_script.to_bookmarklet.should == output
  end

  it "should compress javascript code with a javascript compressor" do
    input  = javascript_local
    output = javascript_local_compressed
    input.compress.should == output
  end
  
  it "should transform a local javascript file to a compressed bookmarklet" do
    input  = javascript_local
    output = bookmarklet_local_compressed
    input.compress.to_bookmarklet.should == output
  end
  
  it "should transform an external javascript into a compressed bookmarklet loaderscript" do
    input  = @remote_url
    output = bookmarklet_remote_compressed
    input.to_loader_script.compress.to_bookmarklet.should == output
  end
  
  it "should write a html page with a bookmarklet link" do
    input  = javascript_local_compressed
    output = html_page_compressed_bookmarklet
    input.compress.to_bookmarklet.to_bookmarklet_page.should == output
  end

end

# fixtures

def javascript_local
  "// a contains method for arrays
  Array.prototype.contains = function(item){
      return this.indexOf(item) > -1;
  }

  alert([1,2,3,4,5].contains(4));"
end

def javascript_local_unescaped
  %Q{console.info(indentString + methodName, '-> ', result, "(", new Date - startTime, 'ms', ")");}
end

def javascript_local_compressed
  "Array.prototype.contains=function(a){return this.indexOf(a)>-1};alert([1,2,3,4,5].contains(4));"
end

def bookmarklet_local
  "javascript:Array.prototype.contains%20=%20function(item){return%20this.indexOf(item)%20>%20-1;}alert([1,2,3,4,5].contains(4));"
end

def bookmarklet_local_escaped
  %Q{javascript:console.info(indentString%20+%20methodName,%20%27->%20%27,%20result,%20%22(%22,%20new%20Date%20-%20startTime,%20%27ms%27,%20%22)%22);}
end

def bookmarklet_local_compressed
  "javascript:Array.prototype.contains=function(a){return%20this.indexOf(a)>-1};alert([1,2,3,4,5].contains(4));"
end

def bookmarklet_remote
  "javascript:(function(){var%20script%20=%20document.createElement(%27script%27);script.type%20=%20%27text/javascript%27;script.src%20=%20%27http://example.com/this/is/a/remote/javascript.js?%27%20+%20(new%20Date().getTime());document.getElementsByTagName(%27body%27)[0].appendChild(script);})()"
end

def bookmarklet_remote_compressed
  "javascript:(function(){var%20a=document.createElement(%22script%22);a.type=%22text/javascript%22;a.src=%22http://example.com/this/is/a/remote/javascript.js?%22+(new%20Date().getTime());document.getElementsByTagName(%22body%22)[0].appendChild(a)})();"
end

def html_page_compressed_bookmarklet
  %Q(<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>bookmarklet</title>
  </head>
  <body>
    <a href="javascript:Array.prototype.contains=function(b){return%20this.indexOf(b)>-1};alert([1,2,3,4,5].contains(4));">bookmarklet</a>  
  </body>
</html>)
end
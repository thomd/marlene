require "rubygems"
require "spec"
require File.dirname(__FILE__) + '/../lib/marlene'

describe "Marlene bookmark generator" do

  before(:all) do
    @remote_url = "http://example.com/this/is/a/remote/javascript.js"   
  end

  it "should transform a local javascript file to an offline bookmarklet" do
    input  = javascript_local
    output = bookmarklet_local
    Marlene.to_bookmarklet(input).should == output
  end
  
  it "should transform a remote javascript into an online bookmarklet" do
    input  = @remote_url
    output = bookmarklet_remote
    Marlene.to_remote_bookmarklet(input).should == output
  end

  it "should compress javascript code with YUI Compressor" do
    input  = javascript_local
    output = javascript_local_compressed
    Marlene.compress(input).should == output
  end
  
  it "should transform a local javascript file to a compressed offline bookmarklet" do
    input  = javascript_local
    output = bookmarklet_local_compressed
    Marlene.to_compressed_bookmarklet(input).should == output
  end
  
  it "should transform a remote javascript into a compressed online bookmarklet" do
    input  = @remote_url
    output = bookmarklet_remote_compressed
    Marlene.to_compressed_remote_bookmarklet(input).should == output
  end
  
#  it "should write a html page with a bookmarklet link" do
#  end

end

# fixtures

def javascript_local
  "// a contains method for arrays
  Array.prototype.contains = function(item){
      return this.indexOf(item) > -1;
  }

  alert([1,2,3,4,5].contains(4));"
end

def javascript_local_compressed
  "Array.prototype.contains=function(a){return this.indexOf(a)>-1};alert([1,2,3,4,5].contains(4));"
end

def bookmarklet_local
  "javascript:Array.prototype.contains%20=%20function(item){return%20this.indexOf(item)%20>%20-1;}alert([1,2,3,4,5].contains(4));"
end

def bookmarklet_local_compressed
  "javascript:Array.prototype.contains=function(a){return%20this.indexOf(a)>-1};alert([1,2,3,4,5].contains(4));"
end

def bookmarklet_remote
  "javascript:(function(){var%20script%20=%20document.createElement('script');script.type%20=%20'text/javascript';script.src%20=%20'http://example.com/this/is/a/remote/javascript.js?'%20+%20(new%20Date().getTime());document.getElementsByTagName('body')[0].appendChild(script);})()"
end

def bookmarklet_remote_compressed
  "javascript:(function(){var%20a=document.createElement(\"script\");a.type=\"text/javascript\";a.src=\"http://example.com/this/is/a/remote/javascript.js?\"+(new%20Date().getTime());document.getElementsByTagName(\"body\")[0].appendChild(a)})();"
end
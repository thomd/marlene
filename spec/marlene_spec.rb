require "rubygems"
require "spec"
require File.dirname(__FILE__) + '/../lib/marlene'

describe "Marlene bookmark generator" do

  it "should transform a local javascript file to an offline bookmarklet" do
    @input  = File.open("spec/mock/script_local.js").read
    @output = File.open("spec/mock/bookmarklet_local.js").read
    Marlene.to_bookmarklet(@input).should == @output
  end
  
  it "should transform a remote javascript into an online bookmarklet" do
    @input  = "http://example.com/this/is/a/remote/javascript.js"
    @output = File.open("spec/mock/bookmarklet_remote.js").read
    Marlene.to_remote_bookmarklet(@input).should == @output
  end

  it "should compress javascript code with YUI Compressor" do
  end
  
  it "should transform a remote javascript into a compressed online bookmarklet" do
  end
  
  it "should write a html page with a bookmarklet link" do
  end

end

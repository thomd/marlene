require "rubygems"
require File.dirname(__FILE__) + '/../lib/marlene'

describe Marlene do

  before :each do
    @input  = File.open("spec/mock/script_1.js").read
    @output = File.open("spec/mock/bookmarklet_1.js").read
  end
  
  it "should transform a javascript file to a bookmarklet" do
    Marlene.to_bookmarklet(@input).should == @output
  end
  
  after :each do
  end
  
end

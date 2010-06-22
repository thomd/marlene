require File.dirname(__FILE__) + '/../lib/marlene'
require 'test/unit'

class TestMarlene < Test::Unit::TestCase
  
  def setup
    @input  = File.open("test/mock/script_1.js").read
    @output = File.open("test/mock/bookmarklet_1.js").read
  end
  
  def test_to_bookmarklet
    assert_equal(@output, Marlene.to_bookmarklet(@input))
  end

end

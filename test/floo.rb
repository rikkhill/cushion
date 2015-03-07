# Once I've figured out what the hell RSpec is doing with all its stuff
# this is going to look amazing

require_relative '../lib/cushion.rb'
require 'test/unit'
require 'pp'
include Cushion

class TestApi < Test::Unit::TestCase
  def test_class
    api = Cushion::Api.new('http://www.bum.com', 'password1')
    assert_equal('http://www.bum.com', api.url)
  end

  def test_arb
    # TODO environment variables for URLs
    api = Cushion::Api.new("XXXXXXXXXXXXXXXXXXXX", 'password1')
    result = api.arb("war")
    pp result
    assert(result)
  end
end

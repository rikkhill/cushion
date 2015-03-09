# Once I've figured out what the hell RSpec is doing with all its stuff
# this is going to look amazing

require_relative '../lib/cushion.rb'
require 'json'
require 'test/unit'
require 'pp'
include Cushion



class TestApi < Test::Unit::TestCase
  def setup
    @@api = Cushion::Api.new(ENV['CUSHION_URL'], ENV['CUSHION_DB'], 'password1')
  end

  def test_class
    assert_equal(ENV['CUSHION_URL'], @@api.url)
  end

  def test_arb
    result = @@api.arb("")
    pp result
    assert(result)
  end

  def test_uuid
    result = @@api.get_uuid
    pp result
    assert(result)
  end

   def test_put
     result = @@api.put_document(
       @@api.get_uuid,
       {
         :each => "tree",
         :peach => "plant",
         :pear => "cat",
         :plum => "dog"
       }
     )
     pp result
     assert(result)
   end
end

require File.dirname(__FILE__) + '/../test_helper'

class OrderTest < ActiveSupport::TestCase
  
  should_have_many :book_titles, :through => :book_title_orders
  
end

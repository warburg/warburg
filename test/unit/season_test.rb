require File.dirname(__FILE__) + '/../test_helper'

class SeasonTest < ActiveSupport::TestCase
  
  fixtures :seasons, :productions, :shows
  
  def setup
    # trigger callbacks
    Season.all.each{|s|s.save!}
  end
  
  test "generate name" do
    s = Season.new
    s.start_year = 2800
    s.end_year = 2801
    s.save!
    assert_equal s.name, '2800-2801'
  end
  
  test 'invisible seasons are invisible' do
    s = seasons('invisible')
    assert(!s.visible?)
    
    seasons = Season.visible
    assert(seasons.select{|s|s.start_year == 2009}.present?)
    assert(seasons.select{|s|s.start_year == 2008}.blank?)
    assert(seasons.select{|s|s.start_year == 1905}.blank?)
    assert(seasons.select{|s|s.start_year == 2004}.blank?)
    
    assert(Season.visible.all(:conditions => {:start_year => 2009}).present?)
    assert(Season.visible.all(:conditions => {:start_year => 1905}).blank?)

    assert(Season.visible.first(:conditions => {:start_year => 2009}))
    assert(Season.visible.first(:conditions => {:start_year => 1905}).nil?)

    assert(Season.visible.find_by_permalink('abc').blank?)
  end
  
  test 'invisible seasons are visible (to admins)' do
    seasons = Season.all
    assert(seasons.select{|s|s.start_year == 2009}.present?)
    assert(seasons.select{|s|s.start_year == 2008}.present?)
    assert(seasons.select{|s|s.start_year == 1905}.present?)
    
    assert(Season.all(:conditions => {:start_year => 2009}).present?)
    assert(Season.all(:conditions => {:start_year => 1905}).present?)

    assert(Season.first(:conditions => {:start_year => 2009}))
    assert(Season.first(:conditions => {:start_year => 1905}))

    assert(Season.find_by_permalink('abc').present?)
  end
  
  test 'seasons are returned in order' do
    seasons = Season.visible.all
    assert(seasons.index(seasons('order_1')) < seasons.index(seasons('order_2')))
    assert(seasons.index(seasons('order_2')) < seasons.index(seasons('order_3')))
  end
  
  test 'making season invisible ripples through' do
    season = seasons('ripple_invisible')
    season.visible = false
    season.save!
    production = productions('rippled_invisible_by_season')
    assert(!production.visible)
    show = shows('rippled_invisible_by_season')
    assert(!show.visible)
  end
  
  test 'making season visible ripples through' do
    season = seasons('ripple_visible')
    season.visible = true
    season.save!
    production = productions('rippled_visible_by_season')
    assert(production.visible)
    show = shows('rippled_visible_by_season')
    assert(show.visible)
  end
  
  
end

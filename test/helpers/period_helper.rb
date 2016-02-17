require 'test_helper'
include PeriodHelper

class PeriodHelperTest < ActiveSupport::TestCase
  
  test 'all' do 
    
    #assert false
    puts "period = 1 Minute"
    status, date = get_next_end_period(1, MINUTE, Time.now)
    p "status => #{status}"
    p "next date => #{date}"

    puts "period = 10 Minute"
    status, date = get_next_end_period(10, MINUTE, Time.now)
    p "status => #{status}"
    p "next date => #{date}"

    puts "period = 1 Hour"
    status, date = get_next_end_period(1, HOUR, Time.now)
    p "status => #{status}"
    p "next date => #{date}"

    puts "period = 10 Hour"
    status, date = get_next_end_period(10, HOUR, Time.now)
    p "status => #{status}"
    p "next date => #{date}"

    puts "period = 1 Day"
    status, date = get_next_end_period(1, DAY, Time.now)
    p "status => #{status}"
    p "next date => #{date}"

    puts "period = 10 Day"
    status, date = get_next_end_period(10, DAY, Time.now)
    p "status => #{status}"
    p "next date => #{date}"

    puts "period = 1 Month"
    status, date = get_next_end_period(1, MONTH, Time.now)
    p "status => #{status}"
    p "next date => #{date}"

    puts "period = 10 Month"
    status, date = get_next_end_period(10, MONTH, Time.now)
    p "status => #{status}"
    p "next date => #{date}"
  end

end
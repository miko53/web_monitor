#!/usr/bin/ruby

require 'net/http'
require 'json'
require 'digest'

uri = URI('http://localhost:3000/update/insert')
API = '76da1f320f6dc0985c685eccd6af4a20'

#p :fr.class
#p ARGV
current_id = 0
device_data = Hash.new
sensors = []

ARGV.each { |arg|
#  p arg
  arg_items = arg.split('=') 
#  p arg.split('=')[0].intern
  
  case arg_items[0].intern
    when :id
      current_id = arg_items[1].to_i
    when :address
      device_data[:address] = arg_items[1]
    when :temp
      sensor = { :id => current_id, :phys => "temp", :value => arg_items[1].to_f}
      sensors << sensor 
    when :humd
      sensor = { :id => current_id, :phys => "humd", :value => arg_items[1].to_f}
      sensors << sensor     
    when :volt
      sensor = { :id => current_id, :phys => "volt", :value => arg_items[1].to_f}
      sensors << sensor     
    else
      p "usage address=<devise_address> temp=<temperature> humd=<humidity> volt=<tension>"
      raise "unexpected argument \"#{arg_items[0]}\""
  end
}


device_data[:data] = sensors
device_data = device_data.to_json
#p device_data

#res = Net::HTTP.post_form(uri, 'api' => API, 'data' => "test")
res = Net::HTTP.post_form(uri, 'api' => API, 'data' => device_data)
#puts res.body
#p res


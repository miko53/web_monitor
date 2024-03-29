#!/usr/bin/ruby

require 'net/http'
require 'json'
require 'digest'

rails_env = ENV['RAILS_ENV']
if rails_env == "production" then
  API = ENV['API_KEY'] 
  uri = URI('http://localhost:80/web_monitor/update/insert')
else
  API = '87be6f1045c08cbec42150c32250a00f'
  uri = URI('http://localhost:3000/update/insert')
end

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
    when :press
      sensor = { :id => current_id, :phys => "press", :value => arg_items[1].to_f}
      sensors << sensor    
    when :heat
      sensor = { :id => current_id, :phys => "heat", :value => arg_items[1]}
      sensors << sensor   
    when :wind_dir
      sensor = { :id => current_id, :phys => "winddir", :value => arg_items[1]}
      sensors << sensor          
    when :wind_speed
      sensor = { :id => current_id, :phys => "windspeed", :value => arg_items[1]}
      sensors << sensor  
    when :rain_fall
      sensor = { :id => current_id, :phys => "rainfall", :value => arg_items[1]}
      sensors << sensor            
    else
      p "usage address=<devise_address> id=<sensor_id> >temp=<temperature> id=<sensor_id> humd=<humidity> id=<sensor_id> volt=<tension> id=<sensor_id> press=<pressure> id=<sensor_id> heat=<status> id=<sensor_id> wind_dir=<wind_dir> id=<sensor_id> wind_dir=<wind_speed> id=<sensor_id> rain_fall=<rain_fall>"
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


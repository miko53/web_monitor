require 'linky_meter'
require 'date'
#require 'update_helper'
#require 'byebug'

class ElectricalRetrieval
  
  def self.schedule
    username = ENV['LINKY_USERNAME']
    password = ENV['LINKY_PASSWORD']
    authentication_cookie = ENV['LINKY_COOKIE_INTERNAL_AUTH_ID']
    
    linky_device = ENV['LINKY_DEVICE_NAME']
    d = get_device(linky_device)
    
    daylight = 0
    if !Time.now.dst? 
      daylight = 1.hour
    end
    
    #p d.id
    
    last_linky_access_table = LoggerLastSucessFullLinkyAccess.find_by_device_id(d.id)
    if (last_linky_access_table.nil?)
      last_linky_access_table = LoggerLastSucessFullLinkyAccess.create(device_id: d.id)
    end
    
    #p last_linky_access_table
    
    currentDate = DateTime.now
    if !last_linky_access_table.last_ok_date.nil? && last_linky_access_table.last_ok_date.to_date == currentDate.to_date
        p "nothing to do already correctly retrieved today"
        return
    end
    
    linky = LinkyMeter.new(false)
    linky.connect(username, password, authentication_cookie)

    date_yesterday = currentDate - 3 # retrieve date of yesterday
    
    result = linky.get(date_yesterday, currentDate,  LinkyMeter::BY_HOUR)
    p result    

# {"cons"=>
#   {"aggregats"=>
#     {"heure"=>
#       {"donnees"=>
#         [{"dateDebut"=>"2024-12-25T00:00", "dateFin"=>"2024-12-25T00:30", "valeur"=>"1.924"},
#          {"dateDebut"=>"2024-12-25T00:30", "dateFin"=>"2024-12-25T01:00", "valeur"=>"1.774"},
#          {"dateDebut"=>"2024-12-25T01:00", "dateFin"=>"2024-12-25T01:30", "valeur"=>"1.036"},
#          {"dateDebut"=>"2024-12-25T01:30", "dateFin"=>"2024-12-25T02:00", "valeur"=>"1.046"},
#          {"dateDebut"=>"2024-12-25T02:00", "dateFin"=>"2024-12-25T02:30", "valeur"=>"1.066"},
#          {"dateDebut"=>"2024-12-25T02:30", "dateFin"=>"2024-12-25T03:00", "valeur"=>"0.604"},
#          {"dateDebut"=>"2024-12-25T03:00", "dateFin"=>"2024-12-25T03:30", "valeur"=>"1.084"},
#          {"dateDebut"=>"2024-12-25T03:30", "dateFin"=>"2024-12-25T04:00", "valeur"=>"1.08"},
#          {"dateDebut"=>"2024-12-25T04:00", "dateFin"=>"2024-12-25T04:30", "valeur"=>"0.602"},
#          {"dateDebut"=>"2024-12-25T04:30", "dateFin"=>"2024-12-25T05:00", "valeur"=>"1.094"},
#          {"dateDebut"=>"2024-12-25T05:00", "dateFin"=>"2024-12-25T05:30", "valeur"=>"0.666"},
#          {"dateDebut"=>"2024-12-25T05:30", "dateFin"=>"2024-12-25T06:00", "valeur"=>"1.196"},
#          {"dateDebut"=>"2024-12-25T06:00", "dateFin"=>"2024-12-25T06:30", "valeur"=>"0.736"},
#          {"dateDebut"=>"2024-12-25T06:30", "dateFin"=>"2024-12-25T07:00", "valeur"=>"0.792"},
#          {"dateDebut"=>"2024-12-25T07:00", "dateFin"=>"2024-12-25T07:30", "valeur"=>"0.64"},
#          {"dateDebut"=>"2024-12-25T07:30", "dateFin"=>"2024-12-25T08:00", "valeur"=>"0.646"},
#          {"dateDebut"=>"2024-12-25T08:00", "dateFin"=>"2024-12-25T08:30", "valeur"=>"0.65"},
#          {"dateDebut"=>"2024-12-25T08:30", "dateFin"=>"2024-12-25T09:00", "valeur"=>"0.658"},
#          {"dateDebut"=>"2024-12-25T09:00", "dateFin"=>"2024-12-25T09:30", "valeur"=>"0.644"},
#          {"dateDebut"=>"2024-12-25T09:30", "dateFin"=>"2024-12-25T10:00", "valeur"=>"0.652"},
#          {"dateDebut"=>"2024-12-25T10:00", "dateFin"=>"2024-12-25T10:30", "valeur"=>"0.648"},
#          {"dateDebut"=>"2024-12-25T10:30", "dateFin"=>"2024-12-25T11:00", "valeur"=>"0.668"},
#          {"dateDebut"=>"2024-12-25T11:00", "dateFin"=>"2024-12-25T11:30", "valeur"=>"0.752"},
#          {"dateDebut"=>"2024-12-25T11:30", "dateFin"=>"2024-12-25T12:00", "valeur"=>"0.754"},
#          {"dateDebut"=>"2024-12-25T12:00", "dateFin"=>"2024-12-25T12:30", "valeur"=>"0.656"},
#          {"dateDebut"=>"2024-12-25T12:30", "dateFin"=>"2024-12-25T13:00", "valeur"=>"0.628"},
#          {"dateDebut"=>"2024-12-25T13:00", "dateFin"=>"2024-12-25T13:30", "valeur"=>"0.632"},
#          {"dateDebut"=>"2024-12-25T13:30", "dateFin"=>"2024-12-25T14:00", "valeur"=>"0.632"},
#          {"dateDebut"=>"2024-12-25T14:00", "dateFin"=>"2024-12-25T14:30", "valeur"=>"0.612"},
#          {"dateDebut"=>"2024-12-25T14:30", "dateFin"=>"2024-12-25T15:00", "valeur"=>"0.61"},
#          {"dateDebut"=>"2024-12-25T15:00", "dateFin"=>"2024-12-25T15:30", "valeur"=>"0.6"},
#          {"dateDebut"=>"2024-12-25T15:30", "dateFin"=>"2024-12-25T16:00", "valeur"=>"0.6"},
#          {"dateDebut"=>"2024-12-25T16:00", "dateFin"=>"2024-12-25T16:30", "valeur"=>"0.612"},
#          {"dateDebut"=>"2024-12-25T16:30", "dateFin"=>"2024-12-25T17:00", "valeur"=>"0.604"},
#          {"dateDebut"=>"2024-12-25T17:00", "dateFin"=>"2024-12-25T17:30", "valeur"=>"0.718"},
#          {"dateDebut"=>"2024-12-25T17:30", "dateFin"=>"2024-12-25T18:00", "valeur"=>"0.712"},
#          {"dateDebut"=>"2024-12-25T18:00", "dateFin"=>"2024-12-25T18:30", "valeur"=>"0.696"},
#          {"dateDebut"=>"2024-12-25T18:30", "dateFin"=>"2024-12-25T19:00", "valeur"=>"0.646"},
#          {"dateDebut"=>"2024-12-25T19:00", "dateFin"=>"2024-12-25T19:30", "valeur"=>"0.634"},
#          {"dateDebut"=>"2024-12-25T19:30", "dateFin"=>"2024-12-25T20:00", "valeur"=>"0.654"},
#          {"dateDebut"=>"2024-12-25T20:00", "dateFin"=>"2024-12-25T20:30", "valeur"=>"0.656"},
#          {"dateDebut"=>"2024-12-25T20:30", "dateFin"=>"2024-12-25T21:00", "valeur"=>"0.676"},
#          {"dateDebut"=>"2024-12-25T21:00", "dateFin"=>"2024-12-25T21:30", "valeur"=>"0.69"},
#          {"dateDebut"=>"2024-12-25T21:30", "dateFin"=>"2024-12-25T22:00", "valeur"=>"0.698"},
#          {"dateDebut"=>"2024-12-25T22:00", "dateFin"=>"2024-12-25T22:30", "valeur"=>"0.696"},
#          {"dateDebut"=>"2024-12-25T22:30", "dateFin"=>"2024-12-25T23:00", "valeur"=>"2.5"},
#          {"dateDebut"=>"2024-12-25T23:00", "dateFin"=>"2024-12-25T23:30", "valeur"=>"1.396"},
#          {"dateDebut"=>"2024-12-25T23:30", "dateFin"=>"2024-12-26T00:00", "valeur"=>"1.762"},
#          {"dateDebut"=>"2024-12-26T00:00", "dateFin"=>"2024-12-26T00:30", "valeur"=>"0.804"},
#          {"dateDebut"=>"2024-12-26T00:30", "dateFin"=>"2024-12-26T01:00", "valeur"=>"1.18"},
#          {"dateDebut"=>"2024-12-26T01:00", "dateFin"=>"2024-12-26T01:30", "valeur"=>"1.18"},
#          {"dateDebut"=>"2024-12-26T01:30", "dateFin"=>"2024-12-26T02:00", "valeur"=>"0.728"},
#          {"dateDebut"=>"2024-12-26T02:00", "dateFin"=>"2024-12-26T02:30", "valeur"=>"1.198"},
#          {"dateDebut"=>"2024-12-26T02:30", "dateFin"=>"2024-12-26T03:00", "valeur"=>"0.752"},
#          {"dateDebut"=>"2024-12-26T03:00", "dateFin"=>"2024-12-26T03:30", "valeur"=>"1.212"},
#          {"dateDebut"=>"2024-12-26T03:30", "dateFin"=>"2024-12-26T04:00", "valeur"=>"0.758"},
#          {"dateDebut"=>"2024-12-26T04:00", "dateFin"=>"2024-12-26T04:30", "valeur"=>"1.258"},
#          {"dateDebut"=>"2024-12-26T04:30", "dateFin"=>"2024-12-26T05:00", "valeur"=>"0.826"},
#          {"dateDebut"=>"2024-12-26T05:00", "dateFin"=>"2024-12-26T05:30", "valeur"=>"0.906"},
#          {"dateDebut"=>"2024-12-26T05:30", "dateFin"=>"2024-12-26T06:00", "valeur"=>"1.392"},
#          {"dateDebut"=>"2024-12-26T06:00", "dateFin"=>"2024-12-26T06:30", "valeur"=>"0.948"},
#          {"dateDebut"=>"2024-12-26T06:30", "dateFin"=>"2024-12-26T07:00", "valeur"=>"0.848"},
#          {"dateDebut"=>"2024-12-26T07:00", "dateFin"=>"2024-12-26T07:30", "valeur"=>"0.89"},
#          {"dateDebut"=>"2024-12-26T07:30", "dateFin"=>"2024-12-26T08:00", "valeur"=>"0.914"},
#          {"dateDebut"=>"2024-12-26T08:00", "dateFin"=>"2024-12-26T08:30", "valeur"=>"0.944"},
#          {"dateDebut"=>"2024-12-26T08:30", "dateFin"=>"2024-12-26T09:00", "valeur"=>"0.968"},
#          {"dateDebut"=>"2024-12-26T09:00", "dateFin"=>"2024-12-26T09:30", "valeur"=>"0.99"},
#          {"dateDebut"=>"2024-12-26T09:30", "dateFin"=>"2024-12-26T10:00", "valeur"=>"1.034"},
#          {"dateDebut"=>"2024-12-26T10:00", "dateFin"=>"2024-12-26T10:30", "valeur"=>"1.042"},
#          {"dateDebut"=>"2024-12-26T10:30", "dateFin"=>"2024-12-26T11:00", "valeur"=>"1.062"},
#          {"dateDebut"=>"2024-12-26T11:00", "dateFin"=>"2024-12-26T11:30", "valeur"=>"1.094"},
#          {"dateDebut"=>"2024-12-26T11:30", "dateFin"=>"2024-12-26T12:00", "valeur"=>"1.152"},
#          {"dateDebut"=>"2024-12-26T12:00", "dateFin"=>"2024-12-26T12:30", "valeur"=>"1.12"},
#          {"dateDebut"=>"2024-12-26T12:30", "dateFin"=>"2024-12-26T13:00", "valeur"=>"0.994"},
#          {"dateDebut"=>"2024-12-26T13:00", "dateFin"=>"2024-12-26T13:30", "valeur"=>"1.002"},
#          {"dateDebut"=>"2024-12-26T13:30", "dateFin"=>"2024-12-26T14:00", "valeur"=>"0.942"},
#          {"dateDebut"=>"2024-12-26T14:00", "dateFin"=>"2024-12-26T14:30", "valeur"=>"0.936"},
#          {"dateDebut"=>"2024-12-26T14:30", "dateFin"=>"2024-12-26T15:00", "valeur"=>"0.95"},
#          {"dateDebut"=>"2024-12-26T15:00", "dateFin"=>"2024-12-26T15:30", "valeur"=>"0.93"},
#          {"dateDebut"=>"2024-12-26T15:30", "dateFin"=>"2024-12-26T16:00", "valeur"=>"0.942"},
#          {"dateDebut"=>"2024-12-26T16:00", "dateFin"=>"2024-12-26T16:30", "valeur"=>"0.948"},
#          {"dateDebut"=>"2024-12-26T16:30", "dateFin"=>"2024-12-26T17:00", "valeur"=>"0.956"},
#          {"dateDebut"=>"2024-12-26T17:00", "dateFin"=>"2024-12-26T17:30", "valeur"=>"0.976"},
#          {"dateDebut"=>"2024-12-26T17:30", "dateFin"=>"2024-12-26T18:00", "valeur"=>"1.112"},
#          {"dateDebut"=>"2024-12-26T18:00", "dateFin"=>"2024-12-26T18:30", "valeur"=>"1.136"},
#          {"dateDebut"=>"2024-12-26T18:30", "dateFin"=>"2024-12-26T19:00", "valeur"=>"1.1"},
#          {"dateDebut"=>"2024-12-26T19:00", "dateFin"=>"2024-12-26T19:30", "valeur"=>"1.078"},
#          {"dateDebut"=>"2024-12-26T19:30", "dateFin"=>"2024-12-26T20:00", "valeur"=>"1.104"},
#          {"dateDebut"=>"2024-12-26T20:00", "dateFin"=>"2024-12-26T20:30", "valeur"=>"1.166"},
#          {"dateDebut"=>"2024-12-26T20:30", "dateFin"=>"2024-12-26T21:00", "valeur"=>"1.164"},
#          {"dateDebut"=>"2024-12-26T21:00", "dateFin"=>"2024-12-26T21:30", "valeur"=>"1.2"},
#          {"dateDebut"=>"2024-12-26T21:30", "dateFin"=>"2024-12-26T22:00", "valeur"=>"1.25"},
#          {"dateDebut"=>"2024-12-26T22:00", "dateFin"=>"2024-12-26T22:30", "valeur"=>"1.258"},
#          {"dateDebut"=>"2024-12-26T22:30", "dateFin"=>"2024-12-26T23:00", "valeur"=>"2.898"},
#          {"dateDebut"=>"2024-12-26T23:00", "dateFin"=>"2024-12-26T23:30", "valeur"=>"1.98"},
#          {"dateDebut"=>"2024-12-26T23:30", "dateFin"=>"2024-12-27T00:00", "valeur"=>"2.0"},
#          {"dateDebut"=>"2024-12-27T00:00", "dateFin"=>"2024-12-27T00:30", "valeur"=>"2.03"},
#          {"dateDebut"=>"2024-12-27T00:30", "dateFin"=>"2024-12-27T01:00", "valeur"=>"2.04"},
#          {"dateDebut"=>"2024-12-27T01:00", "dateFin"=>"2024-12-27T01:30", "valeur"=>"1.54"},
#          {"dateDebut"=>"2024-12-27T01:30", "dateFin"=>"2024-12-27T02:00", "valeur"=>"1.968"},
#          {"dateDebut"=>"2024-12-27T02:00", "dateFin"=>"2024-12-27T02:30", "valeur"=>"1.628"},
#          {"dateDebut"=>"2024-12-27T02:30", "dateFin"=>"2024-12-27T03:00", "valeur"=>"1.56"},
#          {"dateDebut"=>"2024-12-27T03:00", "dateFin"=>"2024-12-27T03:30", "valeur"=>"2.208"},
#          {"dateDebut"=>"2024-12-27T03:30", "dateFin"=>"2024-12-27T04:00", "valeur"=>"1.738"},
#          {"dateDebut"=>"2024-12-27T04:00", "dateFin"=>"2024-12-27T04:30", "valeur"=>"2.056"},
#          {"dateDebut"=>"2024-12-27T04:30", "dateFin"=>"2024-12-27T05:00", "valeur"=>"1.942"},
#          {"dateDebut"=>"2024-12-27T05:00", "dateFin"=>"2024-12-27T05:30", "valeur"=>"1.834"},
#          {"dateDebut"=>"2024-12-27T05:30", "dateFin"=>"2024-12-27T06:00", "valeur"=>"2.386"},
#          {"dateDebut"=>"2024-12-27T06:00", "dateFin"=>"2024-12-27T06:30", "valeur"=>"1.968"},
#          {"dateDebut"=>"2024-12-27T06:30", "dateFin"=>"2024-12-27T07:00", "valeur"=>"2.102"},
#          {"dateDebut"=>"2024-12-27T07:00", "dateFin"=>"2024-12-27T07:30", "valeur"=>"2.176"},
#          {"dateDebut"=>"2024-12-27T07:30", "dateFin"=>"2024-12-27T08:00", "valeur"=>"2.152"},
#          {"dateDebut"=>"2024-12-27T08:00", "dateFin"=>"2024-12-27T08:30", "valeur"=>"2.122"},
#          {"dateDebut"=>"2024-12-27T08:30", "dateFin"=>"2024-12-27T09:00", "valeur"=>"2.21"},
#          {"dateDebut"=>"2024-12-27T09:00", "dateFin"=>"2024-12-27T09:30", "valeur"=>"2.198"},
#          {"dateDebut"=>"2024-12-27T09:30", "dateFin"=>"2024-12-27T10:00", "valeur"=>"2.244"},
#          {"dateDebut"=>"2024-12-27T10:00", "dateFin"=>"2024-12-27T10:30", "valeur"=>"2.336"},
#          {"dateDebut"=>"2024-12-27T10:30", "dateFin"=>"2024-12-27T11:00", "valeur"=>"2.31"},
#          {"dateDebut"=>"2024-12-27T11:00", "dateFin"=>"2024-12-27T11:30", "valeur"=>"2.272"},
#          {"dateDebut"=>"2024-12-27T11:30", "dateFin"=>"2024-12-27T12:00", "valeur"=>"2.24"},
#          {"dateDebut"=>"2024-12-27T12:00", "dateFin"=>"2024-12-27T12:30", "valeur"=>"2.144"},
#          {"dateDebut"=>"2024-12-27T12:30", "dateFin"=>"2024-12-27T13:00", "valeur"=>"2.038"},
#          {"dateDebut"=>"2024-12-27T13:00", "dateFin"=>"2024-12-27T13:30", "valeur"=>"1.986"},
#          {"dateDebut"=>"2024-12-27T13:30", "dateFin"=>"2024-12-27T14:00", "valeur"=>"2.016"},
#          {"dateDebut"=>"2024-12-27T14:00", "dateFin"=>"2024-12-27T14:30", "valeur"=>"1.938"},
#          {"dateDebut"=>"2024-12-27T14:30", "dateFin"=>"2024-12-27T15:00", "valeur"=>"1.868"},
#          {"dateDebut"=>"2024-12-27T15:00", "dateFin"=>"2024-12-27T15:30", "valeur"=>"1.782"},
#          {"dateDebut"=>"2024-12-27T15:30", "dateFin"=>"2024-12-27T16:00", "valeur"=>"1.728"},
#          {"dateDebut"=>"2024-12-27T16:00", "dateFin"=>"2024-12-27T16:30", "valeur"=>"1.754"},
#          {"dateDebut"=>"2024-12-27T16:30", "dateFin"=>"2024-12-27T17:00", "valeur"=>"1.738"},
#          {"dateDebut"=>"2024-12-27T17:00", "dateFin"=>"2024-12-27T17:30", "valeur"=>"1.804"},
#          {"dateDebut"=>"2024-12-27T17:30", "dateFin"=>"2024-12-27T18:00", "valeur"=>"1.828"},
#          {"dateDebut"=>"2024-12-27T18:00", "dateFin"=>"2024-12-27T18:30", "valeur"=>"1.848"},
#          {"dateDebut"=>"2024-12-27T18:30", "dateFin"=>"2024-12-27T19:00", "valeur"=>"1.882"},
#          {"dateDebut"=>"2024-12-27T19:00", "dateFin"=>"2024-12-27T19:30", "valeur"=>"1.932"},
#          {"dateDebut"=>"2024-12-27T19:30", "dateFin"=>"2024-12-27T20:00", "valeur"=>"1.938"},
#          {"dateDebut"=>"2024-12-27T20:00", "dateFin"=>"2024-12-27T20:30", "valeur"=>"2.064"},
#          {"dateDebut"=>"2024-12-27T20:30", "dateFin"=>"2024-12-27T21:00", "valeur"=>"2.138"},
#          {"dateDebut"=>"2024-12-27T21:00", "dateFin"=>"2024-12-27T21:30", "valeur"=>"2.104"},
#          {"dateDebut"=>"2024-12-27T21:30", "dateFin"=>"2024-12-27T22:00", "valeur"=>"2.09"},
#          {"dateDebut"=>"2024-12-27T22:00", "dateFin"=>"2024-12-27T22:30", "valeur"=>"2.094"},
#          {"dateDebut"=>"2024-12-27T22:30", "dateFin"=>"2024-12-27T23:00", "valeur"=>"3.72"},
#          {"dateDebut"=>"2024-12-27T23:00", "dateFin"=>"2024-12-27T23:30", "valeur"=>"2.87"},
#          {"dateDebut"=>"2024-12-27T23:30", "dateFin"=>"2024-12-28T00:00", "valeur"=>"2.726"},
#          {"dateDebut"=>"2024-12-28T00:00", "dateFin"=>"2024-12-28T00:30", "valeur"=>"2.678"},
#          {"dateDebut"=>"2024-12-28T00:30", "dateFin"=>"2024-12-28T01:00", "valeur"=>"2.242"},
#          {"dateDebut"=>"2024-12-28T01:00", "dateFin"=>"2024-12-28T01:30", "valeur"=>"2.732"},
#          {"dateDebut"=>"2024-12-28T01:30", "dateFin"=>"2024-12-28T02:00", "valeur"=>"2.31"},
#          {"dateDebut"=>"2024-12-28T02:00", "dateFin"=>"2024-12-28T02:30", "valeur"=>"2.806"},
#          {"dateDebut"=>"2024-12-28T02:30", "dateFin"=>"2024-12-28T03:00", "valeur"=>"2.338"},
#          {"dateDebut"=>"2024-12-28T03:00", "dateFin"=>"2024-12-28T03:30", "valeur"=>"2.45"},
#          {"dateDebut"=>"2024-12-28T03:30", "dateFin"=>"2024-12-28T04:00", "valeur"=>"2.998"},
#          {"dateDebut"=>"2024-12-28T04:00", "dateFin"=>"2024-12-28T04:30", "valeur"=>"2.578"},
#          {"dateDebut"=>"2024-12-28T04:30", "dateFin"=>"2024-12-28T05:00", "valeur"=>"2.456"},
#          {"dateDebut"=>"2024-12-28T05:00", "dateFin"=>"2024-12-28T05:30", "valeur"=>"2.942"},
#          {"dateDebut"=>"2024-12-28T05:30", "dateFin"=>"2024-12-28T06:00", "valeur"=>"2.496"},
#          {"dateDebut"=>"2024-12-28T06:00", "dateFin"=>"2024-12-28T06:30", "valeur"=>"2.556"},
#          {"dateDebut"=>"2024-12-28T06:30", "dateFin"=>"2024-12-28T07:00", "valeur"=>"2.574"},
#          {"dateDebut"=>"2024-12-28T07:00", "dateFin"=>"2024-12-28T07:30", "valeur"=>"2.584"},
#          {"dateDebut"=>"2024-12-28T07:30", "dateFin"=>"2024-12-28T08:00", "valeur"=>"2.61"},
#          {"dateDebut"=>"2024-12-28T08:00", "dateFin"=>"2024-12-28T08:30", "valeur"=>"2.624"},
#          {"dateDebut"=>"2024-12-28T08:30", "dateFin"=>"2024-12-28T09:00", "valeur"=>"2.678"},
#          {"dateDebut"=>"2024-12-28T09:00", "dateFin"=>"2024-12-28T09:30", "valeur"=>"2.668"},
#          {"dateDebut"=>"2024-12-28T09:30", "dateFin"=>"2024-12-28T10:00", "valeur"=>"2.72"},
#          {"dateDebut"=>"2024-12-28T10:00", "dateFin"=>"2024-12-28T10:30", "valeur"=>"2.848"},
#          {"dateDebut"=>"2024-12-28T10:30", "dateFin"=>"2024-12-28T11:00", "valeur"=>"4.658"},
#          {"dateDebut"=>"2024-12-28T11:00", "dateFin"=>"2024-12-28T11:30", "valeur"=>"4.324"},
#          {"dateDebut"=>"2024-12-28T11:30", "dateFin"=>"2024-12-28T12:00", "valeur"=>"6.846"},
#          {"dateDebut"=>"2024-12-28T12:00", "dateFin"=>"2024-12-28T12:30", "valeur"=>"6.526"},
#          {"dateDebut"=>"2024-12-28T12:30", "dateFin"=>"2024-12-28T13:00", "valeur"=>"6.476"},
#          {"dateDebut"=>"2024-12-28T13:00", "dateFin"=>"2024-12-28T13:30", "valeur"=>"6.426"},
#          {"dateDebut"=>"2024-12-28T13:30", "dateFin"=>"2024-12-28T14:00", "valeur"=>"6.268"},
#          {"dateDebut"=>"2024-12-28T14:00", "dateFin"=>"2024-12-28T14:30", "valeur"=>"6.594"},
#          {"dateDebut"=>"2024-12-28T14:30", "dateFin"=>"2024-12-28T15:00", "valeur"=>"7.228"},
#          {"dateDebut"=>"2024-12-28T15:00", "dateFin"=>"2024-12-28T15:30", "valeur"=>"6.732"},
#          {"dateDebut"=>"2024-12-28T15:30", "dateFin"=>"2024-12-28T16:00", "valeur"=>"6.512"},
#          {"dateDebut"=>"2024-12-28T16:00", "dateFin"=>"2024-12-28T16:30", "valeur"=>"6.432"},
#          {"dateDebut"=>"2024-12-28T16:30", "dateFin"=>"2024-12-28T17:00", "valeur"=>"6.242"},
#          {"dateDebut"=>"2024-12-28T17:00", "dateFin"=>"2024-12-28T17:30", "valeur"=>"6.196"},
#          {"dateDebut"=>"2024-12-28T17:30", "dateFin"=>"2024-12-28T18:00", "valeur"=>"6.174"},
#          {"dateDebut"=>"2024-12-28T18:00", "dateFin"=>"2024-12-28T18:30", "valeur"=>"6.282"},
#          {"dateDebut"=>"2024-12-28T18:30", "dateFin"=>"2024-12-28T19:00", "valeur"=>"6.074"},
#          {"dateDebut"=>"2024-12-28T19:00", "dateFin"=>"2024-12-28T19:30", "valeur"=>"5.82"},
#          {"dateDebut"=>"2024-12-28T19:30", "dateFin"=>"2024-12-28T20:00", "valeur"=>"5.486"},
#          {"dateDebut"=>"2024-12-28T20:00", "dateFin"=>"2024-12-28T20:30", "valeur"=>"5.43"},
#          {"dateDebut"=>"2024-12-28T20:30", "dateFin"=>"2024-12-28T21:00", "valeur"=>"5.0"},
#          {"dateDebut"=>"2024-12-28T21:00", "dateFin"=>"2024-12-28T21:30", "valeur"=>"4.368"},
#          {"dateDebut"=>"2024-12-28T21:30", "dateFin"=>"2024-12-28T22:00", "valeur"=>"4.294"},
#          {"dateDebut"=>"2024-12-28T22:00", "dateFin"=>"2024-12-28T22:30", "valeur"=>"0.746"},
#          {"dateDebut"=>"2024-12-28T22:30", "dateFin"=>"2024-12-28T23:00", "valeur"=>"2.772"},
#          {"dateDebut"=>"2024-12-28T23:00", "dateFin"=>"2024-12-28T23:30", "valeur"=>"3.756"},
#          {"dateDebut"=>"2024-12-28T23:30", "dateFin"=>"2024-12-29T00:00", "valeur"=>"3.714"}],
#        "unite"=>"kW"}},
#    "grandeurMetier"=>"CONS",
#    "grandeurPhysique"=>"PA",
#    "dateDebut"=>"2024-12-25",
#    "dateFin"=>"2024-12-28"}}
    
    
    #if (result['1']['CONS']['data'][0] == "NaN") then
    #  p "it is NaN --> quit"
    #  return
    #end
    
    #linky_device = 'web@linky_home'
    #p result
    items_list = Array.new
    for i in 0..result['cons']['aggregats']['heure']['donnees'].count-1 
      item_date = result['cons']['aggregats']['heure']['donnees'][i]['dateDebut']
      item_data = result['cons']['aggregats']['heure']['donnees'][i]['valeur']
      
      if (item_data != "NaN") then
        item = Hash.new
        item['date'] = DateTime.parse(item_date) + daylight
        item['value'] = item_data * 1000 #set in W not kW
        #p item['date']
        #p item['value']
        items_list << item
      end
    end
    
    s = create_sensor(d, 0, "ElectricalMeter")
    if (d.follow) then
      insert_sample_datas(s, items_list)
    end
    
    result = linky.get(date_yesterday, currentDate,  LinkyMeter::BY_DAY)
    
  #   result = {"cons"=>
  # {"aggregats"=>
  #   {"jour"=>
  #     {"donnees"=>
  #       [{"dateDebut"=>"2024-12-25T00:00", "dateFin"=>"2024-12-25T23:59:59.000000999", "valeur"=>"20.366"},
  #        {"dateDebut"=>"2024-12-26T00:00", "dateFin"=>"2024-12-26T23:59:59.000000999", "valeur"=>"26.611"},
  #        {"dateDebut"=>"2024-12-27T00:00", "dateFin"=>"2024-12-27T23:59:59.000000999", "valeur"=>"49.645"},
  #        {"dateDebut"=>"2024-12-28T00:00", "dateFin"=>"2024-12-28T23:59:59.000000999", "valeur"=>"101.132"}],
  #      "unite"=>"kWh"},
  #    "semaine"=>{"donnees"=>[{"dateDebut"=>"2024-12-23T00:00", "dateFin"=>"2024-12-29T23:59:59.000000999", "valeur"=>"197.75400000000002"}], "unite"=>"kWh"},
  #    "mois"=>{"donnees"=>[{"dateDebut"=>"2024-12-01T00:00", "dateFin"=>"2024-12-31T23:59:59.000000999", "valeur"=>"197.75400000000002"}], "unite"=>"kWh"},
  #    "annee"=>{"donnees"=>[{"dateDebut"=>"2024-01-01T00:00", "dateFin"=>"2024-12-31T23:59:59.000000999", "valeur"=>"197.75400000000002"}], "unite"=>"kWh"}},
  #  "grandeurMetier"=>"CONS",   "grandeurPhysique"=>"EA",   "dateDebut"=>"2024-12-25",   "dateFin"=>"2024-12-28"}}

    p result
    items_list = Array.new
    for i in 0..result['cons']['aggregats']['jour']['donnees'].count-1 
      item_date = result['cons']['aggregats']['jour']['donnees'][i]['dateDebut']
      item_data = result['cons']['aggregats']['jour']['donnees'][i]['valeur']

      if (item_data != "NaN") then
        item = Hash.new
        item['date'] = DateTime.parse(item_date) + daylight
        item['value'] = item_data * 1000 #set in Wh not kWh
        #p item['date']
        #p item['value']
        items_list << item
      end
    end
   
      s = create_sensor(d, 1, "ElectricalConsumption")
      if (d.follow) then
        insert_sample_datas(s, items_list)
      end
      
   last_linky_access_table.last_ok_date = currentDate
   last_linky_access_table.save
   p "correctly updated for today"
  end

  
  def self.get_device(device_adress)
    #p device_data
    device = Device.find_by_address(device_adress)
    if (device == nil) then
      ActiveRecord::Base.transaction do
        device = Device.create(address: device_adress, follow: false)
      end
    end
    
    return device
  end
  
  def self.create_sensor(device, sensor_order, sensor_type)
    s = device.sensors.find_by_order(sensor_order)
    if (s == nil) then
      s = create_sensor_1(device, sensor_order, sensor_type)
    end
    return s
  end

  def self.create_sensor_1(device,  sensor_order, sensor_type)
    #p "d --> #{d}"
    ioType = :sensor
    if (ioType == :sensor) then
      s = device.sensors.create(order: sensor_order,  sensor_type: sensor_type)
    else
      s = nil
#     s = device.actuators.create(order: d["id"], actuator_type: type)
    end
    return s
  end
  
  def self.insert_sample_datas(sensor, datas)
    case (sensor.sensor_type)
      when "Temperature"
        db = TemperatureDatum
      when "Humidity"
        db = HumidityDatum
      when "Voltage"
        db = VoltageDatum
      when "Pressure"
        db = PressureDatum
      when "ElectricalMeter"
        db = ElectricalPowerDatum
      when "ElectricalConsumption"
        db = ElectricalConsumptionDatum
      when "WindDirection"
        db = WindDirection
      when "WindSpeed"
        db = WindSpeed
      when "RainFall"
        db = RainFall
      else
        raise "DB doesn't exist"
    end

    #to avoid to insert data in double, erase previous ones before (if exists)
    ActiveRecord::Base.transaction do
      datas.each do |d|
        previous = db.find_by(dateTime: d['date'], sensor_id: sensor.id)
        if (previous != nil) then
          previous.destroy
          #p "delete #{previous.dateTime}"
        end
      end
    end
    
    ActiveRecord::Base.transaction do
      #byebug
      datas.each do |d|
        t = db.new
        t.value = d['value']
        t.sensor_id = sensor.id
        t.dateTime = d['date']
        t.save
        #p "add #{t.dateTime}"
      end
    end
    
  end

end

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
#     result = {"1"=>{"CONS"=>{"labels"=>["2020-08-15T00:30:00.000+0200", "2020-08-15T01:00:00.000+0200", "2020-08-15T01:30:00.000+0200", "2020-08-15T02:00:00.000+0200", 
#                                         "2020-08-15T02:30:00.000+0200", "2020-08-15T03:00:00.000+0200", "2020-08-15T03:30:00.000+0200", "2020-08-15T04:00:00.000+0200", 
#                                         "2020-08-15T04:30:00.000+0200", "2020-08-15T05:00:00.000+0200", "2020-08-15T05:30:00.000+0200", "2020-08-15T06:00:00.000+0200", 
#                                         "2020-08-15T06:30:00.000+0200", "2020-08-15T07:00:00.000+0200", "2020-08-15T07:30:00.000+0200", "2020-08-15T08:00:00.000+0200", 
#                                         "2020-08-15T08:30:00.000+0200", "2020-08-15T09:00:00.000+0200", "2020-08-15T09:30:00.000+0200", "2020-08-15T10:00:00.000+0200", 
#                                         "2020-08-15T10:30:00.000+0200", "2020-08-15T11:00:00.000+0200", "2020-08-15T11:30:00.000+0200", "2020-08-15T12:00:00.000+0200", 
#                                         "2020-08-15T12:30:00.000+0200", "2020-08-15T13:00:00.000+0200", "2020-08-15T13:30:00.000+0200", "2020-08-15T14:00:00.000+0200", 
#                                         "2020-08-15T14:30:00.000+0200", "2020-08-15T15:00:00.000+0200", "2020-08-15T15:30:00.000+0200", "2020-08-15T16:00:00.000+0200", 
#                                         "2020-08-15T16:30:00.000+0200", "2020-08-15T17:00:00.000+0200", "2020-08-15T17:30:00.000+0200", "2020-08-15T18:00:00.000+0200", 
#                                         "2020-08-15T18:30:00.000+0200", "2020-08-15T19:00:00.000+0200", "2020-08-15T19:30:00.000+0200", "2020-08-15T20:00:00.000+0200", 
#                                         "2020-08-15T20:30:00.000+0200", "2020-08-15T21:00:00.000+0200", "2020-08-15T21:30:00.000+0200", "2020-08-15T22:00:00.000+0200", 
#                                         "2020-08-15T22:30:00.000+0200", "2020-08-15T23:00:00.000+0200", "2020-08-15T23:30:00.000+0200", "2020-08-16T00:00:00.000+0200"], 
#                              "data"=>[0.198, 
#                                       0.19, 0.19, 0.128, 0.096, 0.096, 0.106, 0.198, 0.188, 0.188, 0.132, 0.096, 0.096, 0.098, 0.196, 0.19, 0.186, 0.136, 0.096, 0.094, 0.096, 0.198, 
#                                       0.188, 0.188, 0.14, 0.096, 0.096, 0.098, 0.198, 0.192, 2.99, 4.096, 4.206, 3.602, 3.604, 3.562, 3.596, 3.966, 1.604, 1.2, 1.318, 1.544, 2.824, 
#                                       0.416, 2.092, 1.7, 0.97, 0.236], "mesuresPasEnum"=>"PT30M", "grandeurMetier"=>"CONS", "grandeurPhysique"=>"PA", "unite"=>"W"}}}

    #if (result['1']['CONS']['data'][0] == "NaN") then
    #  p "it is NaN --> quit"
    #  return
    #end
    
    #linky_device = 'web@linky_home'
    #p result
    items_list = Array.new
    for i in 0..result['1']['CONS']['labels'].count-1 
      item_date = result['1']['CONS']['labels'][i]
      item_data = result['1']['CONS']['data'][i]
      
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
#   result = {"1"=>{"CONS"=>{"aggregats"=>{"JOUR"=>{"labels"=>["Vendredi 04/09/20"], "periodes"=>[{"grandeurPhysiqueEnum"=>"EA", "dateDebut"=>"2020-09-04T00:00:00.000+0200",  "dateFin"=>"2020-09-04T00:00:00.000+0200"}], "datas"=>[17.82]}, "SEMAINE"=>{"labels"=>["du 31/08/20 au 06/09/20"], "periodes"=>[{"grandeurPhysiqueEnum"=>"EA", "dateDebut"=>"2020-08-31T00:00:00.000+0200", "dateFin"=>"2020-09-06T23:59:59.000+0200"}], "datas"=>[17.82]}, "MOIS"=>{"labels"=>["Septembre 2020"], "periodes"=>[{"grandeurPhysiqueEnum"=>"EA", "dateDebut"=>"2020-09-01T00:00:00.000+0200", "dateFin"=>"2020-09-30T23:59:59.000+0200"}], "datas"=>[17.82]}, "ANNEE"=>{"labels"=>["2020"], "periodes"=>[{"grandeurPhysiqueEnum"=>"EA", "dateDebut"=>"2020-01-01T00:00:00.000+0100", "dateFin"=>"2020-12-31T23:59:59.000+0100"}], "datas"=>[17.82]}}, "grandeurMetier"=>"CONS", "grandeurPhysique"=>"EA", "unite"=>"Wh"}}}
#           {"1"=>{"CONS"=>{"aggregats"=>{"JOUR"=>{"labels"=>["Samedi 21/11/20", "Dimanche 22/11/20", "Lundi 23/11/20"], "periodes"=>[{"grandeurPhysiqueEnum"=>"EA", "dateDebut"=>"2020-11-21T00:00:00.000+0200", "dateFin"=>"2020-11-21T00:00:00.000+0200"}, {"grandeurPhysiqueEnum"=>"EA", "dateDebut"=>"2020-11-22T00:00:00.000+0200", "dateFin"=>"2020-11-22T00:00:00.000+0200"}, {"grandeurPhysiqueEnum"=>"EA", "dateDebut"=>"2020-11-23T00:00:00.000+0200", "dateFin"=>"2020-11-23T00:00:00.000+0200"}], "datas"=>[30.577, 31.848, 37.411]}, "SEMAINE"=>{"labels"=>["du 16/11/20 au 22/11/20", "du 23/11/20 au 29/11/20"], "periodes"=>[{"grandeurPhysiqueEnum"=>"EA", "dateDebut"=>"2020-11-16T00:00:00.000+0200", "dateFin"=>"2020-11-22T23:59:59.000+0200"}, {"grandeurPhysiqueEnum"=>"EA", "dateDebut"=>"2020-11-23T00:00:00.000+0200", "dateFin"=>"2020-11-29T23:59:59.000+0200"}], "datas"=>[62.425, 37.411]}, "MOIS"=>{"labels"=>["Novembre 2020"], "periodes"=>[{"grandeurPhysiqueEnum"=>"EA", "dateDebut"=>"2020-11-01T00:00:00.000+0100", "dateFin"=>"2020-Nov 24 21:03:00 beaglebone rails_linky: 11-30T23:59:59.000+0100"}], "datas"=>[99.836]}, "ANNEE"=>{"labels"=>["2020"], "periodes"=>[{"grandeurPhysiqueEnum"=>"EA", "dateDebut"=>"2020-01-01T00:00:00.000+0100", "dateFin"=>"2020-12-31T23:59:59.000+0100"}], "datas"=>[99.836]}}, "grandeurMetier"=>"CONS", "grandeurPhysique"=>"EA", "unite"=>"Wh"}}}
    
    p result
    items_list = Array.new
    for i in 0..result['1']['CONS']['aggregats']['JOUR']['periodes'].count-1 
      item_date = result['1']['CONS']['aggregats']['JOUR']['periodes'][i]['dateDebut']
      item_data = result['1']['CONS']['aggregats']['JOUR']['datas'][i]

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

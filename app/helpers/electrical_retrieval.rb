require 'linky_meter'
require 'date'
#require 'update_helper'
#require 'byebug'

class ElectricalRetrieval
  
  def self.schedule
    username = ENV['LINKY_USERNAME']
    password = ENV['LINKY_PASSWORD']
    authentication_cookie = ENV['LINKY_COOKIE_INTERNAL_AUTH_ID']

    linky = LinkyMeter.new()
    #p username
    #p password
    #p authentication_cookie
    linky.connect(username, password, authentication_cookie)

    date_yesterday = DateTime.now - 1 # retrieve date of yesterday
    
    result = linky.get(date_yesterday, DateTime.now,  LinkyMeter::BY_HOUR)
    
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
    
    linky_device = ENV['LINKY_DEVICE_NAME']
    #linky_device = 'web@linky_home'
    #p result
    items_list = Array.new
    for i in 0..result['1']['CONS']['labels'].count-1 
      item_date = result['1']['CONS']['labels'][i]
      item_data = result['1']['CONS']['data'][i]
      item = Hash.new
      item['date'] = DateTime.parse(item_date)
      item['value'] = item_data * 1000 #set in W not kW
      #p item['date']
      #p item['value']
      items_list << item
    end
    
    d = UpdateHelper::get_device(linky_device)
    s = UpdateHelper::create_sensor(d, 0, "ElectricalMeter")
    if (d.follow) then
      UpdateHelper::insert_sample_datas(s, items_list)
    end
    
    
     result = linky.get(date_yesterday, DateTime.now,  LinkyMeter::BY_DAY)
#    result = {"1"=>{"CONS"=>{"aggregats"=>{"JOUR"=>{"labels"=>["Vendredi 04/09/20"], "periodes"=>[{"grandeurPhysiqueEnum"=>"EA", "dateDebut"=>"2020-09-04T00:00:00.000+0200",  "dateFin"=>"2020-09-04T00:00:00.000+0200"}], "datas"=>[17.82]}, "SEMAINE"=>{"labels"=>["du 31/08/20 au 06/09/20"], "periodes"=>[{"grandeurPhysiqueEnum"=>"EA", "dateDebut"=>"2020-08-31T00:00:00.000+0200", "dateFin"=>"2020-09-06T23:59:59.000+0200"}], "datas"=>[17.82]}, "MOIS"=>{"labels"=>["Septembre 2020"], "periodes"=>[{"grandeurPhysiqueEnum"=>"EA", "dateDebut"=>"2020-09-01T00:00:00.000+0200", "dateFin"=>"2020-09-30T23:59:59.000+0200"}], "datas"=>[17.82]}, "ANNEE"=>{"labels"=>["2020"], "periodes"=>[{"grandeurPhysiqueEnum"=>"EA", "dateDebut"=>"2020-01-01T00:00:00.000+0100", "dateFin"=>"2020-12-31T23:59:59.000+0100"}], "datas"=>[17.82]}}, "grandeurMetier"=>"CONS", "grandeurPhysique"=>"EA", "unite"=>"Wh"}}}
    
    items_list = Array.new
    for i in 0..result['1']['CONS']['aggregats']['JOUR']['periodes'].count-1 
      item_date = result['1']['CONS']['aggregats']['JOUR']['periodes'][i]['dateDebut']
      item_data = result['1']['CONS']['aggregats']['JOUR']['datas'][i]
      item = Hash.new
      item['date'] = DateTime.parse(item_date)
      item['value'] = item_data * 1000 #set in Wh not kWh
      #p item['date']
      #p item['value']
      items_list << item
    end
    
    s = UpdateHelper::create_sensor(d, 1, "ElectricalConsumption")
    if (d.follow) then
      UpdateHelper::insert_sample_datas(s, items_list)
    end
    
  end

end

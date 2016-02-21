class UpdateController < ApplicationController
  protect_from_forgery except: :insert
  
  def index
     #render status: 200, json: @controller.to_json
     head :ok, content_type: "text/html"
     logger.info "update data"
  end
  
  def insert
    begin
     #p params
     logger.info "data reception"
     if (params[:data] == nil || params[:api] == nil) then
        logger.info("params are nil")
        head :error, content_type: "text/html"
     else
       #check if API is OK
       if (check_api(params[:data]) == true) then
         data = JSON.parse(params[:data])
         #insert in DB if does'nt exist
         #if exists and data must be insert, insert into DB
         update_data_from_device(data)
       end
       head :ok, content_type: "text/html"
     end
     rescue
       head :error, content_type: "text/html"       
    end
  end
  
private
  
  def check_api(api)
    return true
  end
  
  def update_data_from_device(device_data)
    #p device_data
    device = Device.find_by_address(device_data["address"])
    ActiveRecord::Base.transaction do
      if (device == nil) then
        #insert into DB
        create_device(device_data)
      else
        update_data(device, device_data) if (device.follow == true)
      end
    end
  end

  def update_data(device, device_data)
    #update 
    device_data["data"].each do |d|
      #p "d --> #{d}"
      s = device.sensors.find_by_order(d["id"])
      if (s != nil) then
        #insert into db
        s.insert_sample(d["value"])
      end
    end
  end
  
  def create_device(device_data)
    device = Device.create(address: device_data["address"], follow: false)
    create_sensor(device, device_data)
  end
  
  def create_sensor(device, device_data)
    type = ""
    device_data["data"].each do |d|
      p "d --> #{d}"
      case (d["phys"])
        when "temp"
          type = "Temperature"
        when "humd"
          type = "Humidity"
        when "volt"
          type = "Voltage"
      end
      device.sensors.create(order: d["id"],  sensor_type: type)
    end
  end

end


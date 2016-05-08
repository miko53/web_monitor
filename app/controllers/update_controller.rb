require 'period_helper'

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
       if (check_api(params[:api]) == true) then
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
    bApiOk = false;
    admin = User.find_by_user_name('admin')
    if (admin == nil) then
      logger.info("no admin found")
      bApiOk = false
    else
      if (admin.api_key == api) then
        bApiOk = true
      else
        bApiOk = false
        logger.info("wrong API provided #{api}")
      end
    end
    return bApiOk
  end
  
  def update_data_from_device(device_data)
    #p device_data
    device = Device.find_by_address(device_data["address"])
    ActiveRecord::Base.transaction do
      if (device == nil) then
        #insert into DB
        create_device(device_data)
      else
        if (device.follow == true) then
          update_data(device, device_data) 
        else
          create_sensor_if_not_exist(device, device_data)
        end
      end
    end
  end
  
  def create_sensor_if_not_exist(device, device_data)
    device_data["data"].each do |d|
      #p "d --> #{d}"
      s = device.sensors.find_by_order(d["id"])
      if (s == nil) then
        #insert into db
        s = create_sensor_1(device, d)
      end
    end
  end

  def update_data(device, device_data)
    #update 
    device_data["data"].each do |d|
      #p "d --> #{d}"
      s = device.sensors.find_by_order(d["id"])
      if (s == nil) then
        #insert into db
        s = create_sensor_1(device, d)
      end
      s.insert_sample(d["value"])
      calculate_operation_on_sensor(s, d["value"])
    end
  end
  
  def create_device(device_data)
    device = Device.create(address: device_data["address"], follow: false)
    create_sensor(device, device_data)
  end
  
  def create_sensor(device, device_data)
    type = ""
    device_data["data"].each do |d|
      #p "d --> #{d}"
      case (d["phys"])
        when "temp"
          type = "Temperature"
        when "humd"
          type = "Humidity"
        when "volt"
          type = "Voltage"
        when "press"
          type = "Pressure"
      end
      device.sensors.create(order: d["id"],  sensor_type: type)
    end
  end
  
  def create_sensor_1(device, d)
      #p "d --> #{d}"
      case (d["phys"])
        when "temp"
          type = "Temperature"
        when "humd"
          type = "Humidity"
        when "volt"
          type = "Voltage"
        when "press"
          type = "Pressure"
      end
      s = device.sensors.create(order: d["id"],  sensor_type: type)
      return s
  end
  
  def calculate_operation_on_sensor(s, value)
    s.operations.each do |operation|
      #p "operation --> #{operation}"
      #check if end of period
      now = DateTime.now
      if (now >= operation.endPeriod) then
        logger.info "We has reached the end of period, now = #{now} endPeriod = #{operation.endPeriod}, do the calcul"
        insert_new_calcul(operation, value)
      else
        #logger.info "NOT A THE END, now = #{now} endPeriod = #{operation.endPeriod}"        
        do_calcul(operation, value)
      end
    end
  end
  
  def insert_new_calcul(operation, value)
    if (operation.number_samples != 0) then
      data_value = 0.0
      case operation.calcul_type
        when 'Min'
          data_value = operation.currentValue
        when 'Max'
          data_value = operation.currentValue        
        when 'Moy'
          data_value = operation.currentValue / operation.number_samples
        else
          logger.warn "Unknown calcul type #{operation.calcul_type}"
      end
      new_calculated_data = operation.calculated_data.new(value: data_value, beginPeriod: operation.endPeriod)
      new_calculated_data.save
    end
    
    #calculate new end period
    update_end_period(operation)
    operation.currentValue = value
    operation.number_samples = 1
    operation.save
  end
  
  def do_calcul(operation, value)
    case operation.calcul_type
      when 'Min'
        if (value < operation.currentValue) then
          operation.currentValue = value
        end
      when 'Max'
        if (value > operation.currentValue) then
          operation.currentValue = value
        end
      when 'Moy'
        operation.currentValue = operation.currentValue + value
        operation.number_samples = operation.number_samples + 1
      else
        logger.warn "Unknown calcul type #{operation.calcul_type}"
    end
    operation.save
  end
  
  def update_end_period(operation)
    isValid, nextPeriod = PeriodHelper::get_next_end_period(operation.period, operation.period_unit, Time.now)
    operation.endPeriod = nextPeriod if (isValid == true)
    
#     case operation.period_unit
#       when PeriodHelper::MINUTE
#         operation.endPeriod = operation.endPeriod + operation.period * 1.minute
#       when PeriodHelper::HOUR
#         operation.endPeriod = operation.endPeriod + operation.period * 1.hour
#       when PeriodHelper::DAY
#         operation.endPeriod = operation.endPeriod + operation.period * 1.day
#       when PeriodHelper::MONTH
#         days = Time.days_in_month(operation.endPeriod.month, operation.endPeriod.year)
#         operation.endPeriod = operation.endPeriod + operation.period * days * 1.day
#       else
#         logger.warn "Unknown period_unit #{operation.period_unit}"
#     end  
  end
  
end


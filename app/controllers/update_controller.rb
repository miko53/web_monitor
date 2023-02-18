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
        head :internal_server_error, content_type: "text/html"
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
     rescue => e
       logger.error e.message
       e.backtrace.each { |line| logger.error line }
       head :internal_server_error, content_type: "text/html"       
    end
  end
  
private
  
  def check_api(api)
    bApiOk = false
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
        s = device.actuators.find_by_order(d["id"])
        if (s == nil) then
          #insert into db
          s = create_sensor_1(device, d)
        end
      end
    end
  end

  def update_data(device, device_data)
    #update 
    device_data["data"].each do |d|
      #p "d --> #{d}"
      s = device.sensors.find_by_order(d["id"])
      if (s == nil) then
        s = device.actuators.find_by_order(d["id"])
        if (s == nil) then
          #insert into db
          s = create_sensor_1(device, d)
        else
          #update value 
          #TODO check if value are in correct range (i.e. CONFORT, ECO,...)
          s.value = d["value"]
          s.refreshDateTime = DateTime.now
          s.save
        end
      end
      
      if (s.is_a?(Sensor)) then
        s.insert_sample(d["value"])
        calculate_operation_on_sensor(s, d["value"])
      end
    end
  end
  
  def create_device(device_data)
    device = Device.create(address: device_data["address"], follow: false)
    create_sensor(device, device_data)
  end
  
  def create_sensor(device, device_data)
    type = ""
    ioType = :sensor
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
        when "ElectricalMeter"
          type = "ElectricalMeter"
        when "ElectricalConsumption"
          type = "ElectricalMeter"
        when "heat"
          ioType = :actuator
          type = "heating"
        when "winddir"
          type = "WindDirection"
        when "windspeed"
          type = "WindSpeed"
        when "rainfall"
          type = "RainFall"
        else
          logger.info "ERROR 0"
          raise "Error"
      end
      if (ioType == :sensor) then
        device.sensors.create(order: d["id"],  sensor_type: type)
      else
        device.actuators.create(order: d["id"], actuator_type: type)
      end
    end
  end
  
  def create_sensor_1(device, d)
    #p "d --> #{d}"
    ioType = :sensor
      case (d["phys"])
        when "temp"
          type = "Temperature"
        when "humd"
          type = "Humidity"
        when "volt"
          type = "Voltage"
        when "press"
          type = "Pressure"
        when "ElectricalMeter"
          type = "ElectricalMeter"
        when "ElectricalConsumption"
          type = "ElectricalConsumption"
        when "winddir"
          type = "WindDirection"
        when "windspeed"
          type = "WindSpeed"
        when "rainfall"
          type = "RainFall"
        when "heat"
          ioType = :actuator
          type = "heating"
      else
          logger.info "ERROR 1"
          raise "Error"
      end
      
      if (ioType == :sensor) then
        s = device.sensors.create(order: d["id"],  sensor_type: type)
      else
        s = device.actuators.create(order: d["id"], actuator_type: type)
      end
      
      return s
  end
  
  def calculate_operation_on_sensor(s, value)
    s.operations.each do |operation|
      #p "operation --> #{operation}"
      #check if end of period
      now = DateTime.now
      if (now >= operation.endPeriod) then
        logger.info "We has reached the end of period, now = #{now} endPeriod = #{operation.endPeriod}, do the calcul"
        insert_new_calcul(operation, value, now)
      else
        #logger.info "NOT A THE END, now = #{now} endPeriod = #{operation.endPeriod}"        
        do_calcul(operation, value, now)
      end
    end
  end
  
  def insert_new_calcul(operation, value, current_date)
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
      new_calculated_data = operation.calculated_data.new(value: data_value, beginPeriod: operation.eventDateTime)
      new_calculated_data.save
    end
    
    #calculate new end period
    update_end_period(operation)
    if operation.calcul_type == 'Moy' then
      operation.eventDateTime = PeriodHelper::get_middle_period(operation.period, operation.period_unit, operation.endPeriod) 
    else
      operation.eventDateTime = current_date
    end
    operation.currentValue = value
    operation.number_samples = 1
    operation.save
  end
  
  def do_calcul(operation, value, current_date)
    case operation.calcul_type
      when 'Min'
        if (value < operation.currentValue) then
          operation.currentValue = value
          operation.eventDateTime = current_date
        end
      when 'Max'
        if (value > operation.currentValue) then
          operation.currentValue = value
          operation.eventDateTime = current_date
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
  end
  
end


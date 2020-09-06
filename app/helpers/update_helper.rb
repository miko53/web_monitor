
#require 'byebug'

module UpdateHelper
  
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
      else
        raise "DB doesn't exist"
    end

    #to avoid to insert data in double, erase previous ones before (if exists)
    ActiveRecord::Base.transaction do
      datas.each do |d|
        previous = db.find_by(dateTime: d['date'], sensor_id: sensor.id)
        if (previous != nil) then
          previous.destroy
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
      end
    end
    
  end
  
end

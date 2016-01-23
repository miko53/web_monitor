# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Device.create(name: 'D1', location: 'Upstairs', address: 'xb@10:15:5A:6B', follow: true)
Device.create(name: 'D2', location: 'Exterior', address: 'xb@10:51:5A:6C', follow: false)
Device.create(name: 'D3', location: 'Salle', address: 'xb@56:51:5A:6C', follow: true)

s = Sensor.create(device_id: 1, type: "Temperature", order: 1)
Sensor.create(device_id: 1, type: "Humidity", order: 2)
Sensor.create(device_id: 1, type: "Voltage", order: 3)

ActiveRecord::Base.transaction do
  for i in 0 ... 10000
    d = DateTime.now.since(-10000*60 + 60*i)
    TemperatureDatum.create(
    value: 15 + rand(10) + rand(0),
    sensor_id: 1,
    dateTime: d)
  
    HumidityDatum.create(
    value: 55 + rand(15) + rand(0),
    sensor_id: 2,
    dateTime: d)
  
    VoltageDatum.create(
    value: 3.3 + rand(0),
    sensor_id: 3,
    dateTime: d)
    #p i
  end
end

Sensor.create(device_id: 2, type: "Temperature", order: 1)
Sensor.create(device_id: 2, type: "Humidity", order: 2)
Sensor.create(device_id: 2, type: "Voltage", order: 3)

Sensor.create(device_id: 3, type: "Temperature", order: 1)
Sensor.create(device_id: 3, type: "Humidity", order: 2)
Sensor.create(device_id: 3, type: "Voltage", order: 3)


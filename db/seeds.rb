# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Device.create(name: 'D1', location: 'Upstairs', address: 'xb@10:15:5A:6B', follow: true)
Device.create(name: 'D2', location: 'Exterior', address: 'xb@10:51:5A:6C', follow: true)
Device.create(name: 'D3', location: 'Salle', address: 'xb@56:51:5A:6C', follow: true)

Sensor.create(device_id: 1, type: "Temperature", order: 1)
Sensor.create(device_id: 1, type: "Humidity", order: 2)
Sensor.create(device_id: 1, type: "Voltage", order: 3)


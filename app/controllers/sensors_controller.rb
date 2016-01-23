class SensorsController < ApplicationController
  def show
    @sensor = Sensor.find(params[:id])
    @samples = @sensor.db.where(sensor_id: @sensor.id).order("dateTime DESC").page(params[:page]).per_page(70)
  end
end

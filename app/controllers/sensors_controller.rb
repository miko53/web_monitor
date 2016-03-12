class SensorsController < ApplicationController
  before_filter :authenticate
  before_filter :load_sensor , only: [:show,:show_operation]

  def show
    @samples = @sensor.db.where(sensor_id: @sensor.id).order("dateTime DESC").page(params[:page]).per_page(70)
  end
  
  def show_operation
  end

private
  def load_sensor
    @sensor = Sensor.find(params[:id])
  end
  
end

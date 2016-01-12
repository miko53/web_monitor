class DevicesController < ApplicationController
  
  def index
    @devices = Device.all
  end
  
  def show
    @device = Device.find(params[:id])
    @sensors = @device.sensors
  end
  
end

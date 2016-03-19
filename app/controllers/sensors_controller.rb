class SensorsController < ApplicationController
  before_filter :authenticate
  before_filter :load_sensor , only: [:show,:edit,:update,:show_operation]

  def show
    @samples = @sensor.db.where(sensor_id: @sensor.id).order("dateTime DESC").page(params[:page]).per_page(70)
  end
  
  def edit
  end
  
  def update
    if (@sensor.update(sensor_params)) then
      flash[:info] = "sensor correctly updated"
      redirect_to device_url(@sensor.device)
    else
      flash[:error] = "sensor update failed"
      render :edit
    end    
  end
  
  def show_operation
  end

private
  def load_sensor
    @sensor = Sensor.find(params[:id])
  end
  
  def sensor_params
    params.require(:sensor).permit(:order, :name, :sensor_type)
  end
  
end

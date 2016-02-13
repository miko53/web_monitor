class DevicesController < ApplicationController
  before_filter :load_device , only: [:show,:edit,:update, :destroy]
  
  def index
    @devices = Device.all
  end
  
  def show
    if (@device != nil) then
    @sensors = @device.sensors
    end
  end
  
  def edit
    
  end
  
  def update
    if (@device.update(device_params)) then
      flash[:info] = "device correctly updated"
      redirect_to device_url(@device)
    else
      flash[:error] = "device update failed"
      render :edit
    end  end
  
  def destroy
    
  end
  
private

  def load_device
    @device = Device.find(params[:id])
  end

  def device_params
    params.require(:device).permit(:address, :name, :location, :follow)
  end
end

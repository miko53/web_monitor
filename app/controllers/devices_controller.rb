class DevicesController < ApplicationController
  before_filter :authenticate
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
      #redirect_to device_url(@device)
      redirect_to devices_url
    else
      flash[:error] = "device update failed"
      render :edit
    end  end
  
  def destroy
    #recuperer chaque sensor et 
    #dans la db retirer les samples associés.
    ActiveRecord::Base.transaction do
      @device.sensors.each do |s|
        #p s
        s.remove_samples
      end
      @device.destroy    
    end
    flash[:info] = "device removed"
    redirect_to devices_path
  end
  
private

  def load_device
    @device = Device.find(params[:id])
  end

  def device_params
    params.require(:device).permit(:address, :name, :location, :follow)
  end
end

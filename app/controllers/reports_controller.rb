class ReportsController < ApplicationController
  before_filter :load_report , only: [:show,:edit,:update, :destroy]
  helper :reports
  
  def new
    @report = Report.new
  end
  
  def index
    @reports = Report.all
  end

  def create
    #p "create"
    @report = Report.new(report_params)
    if (@report.save) then
      flash[:info] = "report created successfully"
      redirect_to report_url(@report)
    else
      flash[:error] = "report saved failed"
      render :new
    end
  end
  
  def show
    @data = Array.new
    @dataCtrl = Array.new
    @report.device_of_reports.each do |item|
      p item
      device = Device.find_by_name(item.deviceName)
      if (device != nil) then
        sensor = device.sensors.find_by_order(item.flowID)
        if (sensor != nil) then
          if (@report.isRangeSet == true) then
            if (@report.dateEnd == "now") then
                @report.dateEnd = DateTime.now
            end
            @report.dateBegin =  @report.dateEnd.to_time.since(-@report.dayRangeFromEnd.days)
          end
          samples = sensor.db.where('sensor_id=? AND (datetime(dateTime) >= datetime(?) AND datetime(dateTime) < datetime(?))',  
                                    sensor.id, 
                                    @report.dateBegin.to_time.utc, 
                                    @report.dateEnd.to_time.utc)
          sArray = Array.new
          samples.each do |sample|
            sArray << [ sample.dateTime, sample.value ]
          end
          @dataCtrl << [ item.deviceName, item.flowID, sensor.sensor_type ]
          @data << sArray
        end
      end 
    end
  end  
  
  def edit
  end
  
  def update
    if (@report.update(report_params)) then
      flash[:info] = "report correctly updated"
      redirect_to report_url(@report)
    else
      flash[:error] = "report update failed"
      render :edit
    end
  end
  
  def destroy
    @report.destroy
    flash[:info] = "report removed"
    redirect_to reports_path
  end
  
 private
  def load_report
    @report = Report.find(params[:id])
  end
  
  def report_params
    params.require(:report).permit(:id, :name, :dateBegin, :dateEnd, :isRangeSet, :dayRangeFromEnd,
            :device_of_reports_attributes => [:id, :deviceName, :flowID,:_destroy])
  end
  
end

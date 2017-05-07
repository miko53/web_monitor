
class ReportsController < ApplicationController
  before_filter :authenticate
  before_filter :load_report , only: [:show,:edit,:update, :destroy]
  helper :reports
  
  def new
    @report = current_user.reports.new
  end
  
  def index
  #  if (current_user.admin?) then
      @reports = Report.all.order(:name).page(params[:page]).per_page(10)
   # else
  #    @reports = current_user.reports
   # end
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
    @chartTitles = Array.new
    @chartDatas = Array.new
    @chartUnits = Array.new
    @chartScale = Array.new
    set_report_date
    @report.graphs.each do |graph|
      build_array_for_each_graph(graph)
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
    params.require(:report).permit(:id, :user_id, :name, :dateBegin, :dateEnd, :isRangeSet, :dayRangeFromEnd,
            :graphs_attributes => [:id, :title, :dataset_id,:_destroy,
            :datasets_attributes => [:id, :device_name, :sensor_name, :operation_name, :_destroy]])
  end
  
  def set_report_date
    if (@report.isRangeSet == true) then
      if (@report.dateEnd == "now") then
          @report.dateEnd = DateTime.now
      else
        
      end
      @report.dateBegin =  @report.dateEnd.to_time.since(-@report.dayRangeFromEnd.days)
    end
  end

  def build_array_for_each_graph(graph)
    #insert each dataset inside graph
    #p GC.start
    @chartTitles << graph.title
    sUnit = Array.new
    sChartData = Array.new
    min_max = Hash.new
    graph.datasets.each do |dataset|
      sensor = nil
      device = Device.find_by_name(dataset.device_name)
      if (device != nil) then
        sensor = device.sensors.find_by_name(dataset.sensor_name)
      end
      
      if (sensor != nil) then
        #check type of operation
        #p dataset.operation_name
        if (dataset.operation_name == "raw") then
          sArray = Array.new
          samples = sensor.db.where('sensor_id=? AND ((dateTimeInt >= ?) AND (dateTimeInt < ?))',  
                                    sensor.id, 
                                    @report.dateBegin.to_time.to_i, 
                                    @report.dateEnd.to_time.to_i).select(:id, :dateTime, :value)
          samples.find_each do |s|
            sArray << [s.dateTime, s.value]
          end
          
          if (min_max['min'] == nil) then
            min_max['min'] = samples.minimum(:value)
            min_max['max'] = samples.maximum(:value)
          else
            min_max['min'] = [ samples.minimum(:value), min_max['min']].min 
            min_max['max'] = [ samples.maximum(:value), min_max['max']].max 
          end
          
          dataset = Hash.new
          dataset['name'] = sensor.name + '_raw'
          dataset['data'] = sArray
          sChartData << dataset
          sUnit << ReportsHelper::unit(sensor.sensor_type)
        else
          #now take the operation 
          operation = sensor.operations.find_by_name(dataset.operation_name)
          if (operation != nil) then
            sArray = Array.new
            samples = CalculatedDatum.where('operation_id=? AND ((beginPeriodInt >= ?) AND (beginPeriodInt < ?))',  
                                      operation.id, 
                                      @report.dateBegin.to_time.to_i, 
                                      @report.dateEnd.to_time.to_i).select(:id, :beginPeriod, :value)
            samples.find_each do |s|
              sArray << [ s.beginPeriod, s.value ]
            end
            
            if (min_max['min'] == nil) then
              min_max['min'] = samples.minimum(:value)
              min_max['max'] = samples.maximum(:value)
            else
              min_max['min'] = [ samples.minimum(:value), min_max['min']].min 
              min_max['max'] = [ samples.maximum(:value), min_max['max']].max 
            end
            dataset = Hash.new
            dataset['name'] = operation.name
            dataset['data'] = sArray
            sChartData << dataset
            sUnit << ReportsHelper::unit(sensor.sensor_type)
          end
        end
      end
    end
    @chartUnits << sUnit
    @chartDatas << sChartData
    @chartScale << min_max
  end
  
end

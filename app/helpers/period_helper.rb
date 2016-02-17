module PeriodHelper

  MINUTE=1
  HOUR=2
  DAY=3
  WEEK=4
  MONTH=5

  #fonctionnr en prenant en faite le temps de la fin de period
  #sauvegarder la next period et checker si depasser,
  #si depasser alors enregistrer la prochaine

  #######################################################################################
  #1min ==> begin of minute
  #>1min ==> begin of hours
  #1day ==> begin of begin of day
  #>1day ==> begin of week
  #1month ==> begin of months
  #>1month ==> begin of year

  def get_next_end_period(requested_period, period_unit, current_date)
    
    status = false
    to_second = 1
    
    case(period_unit)
      
      when MINUTE
        if (requested_period > 1) then
          ref_date = current_date.beginning_of_hour
          to_second = 1.minute
        else # requested_period == 1
          ref_date = current_date.beginning_of_minute
          next_date = ref_date + 1.minute
          return true, next_date
        end
        
      when HOUR
        if (requested_period > 1) then
          ref_date = current_date.beginning_of_day
          to_second = 1.hour
        else # requested_period == 1
          ref_date = current_date.beginning_of_hour
          next_date = ref_date + 1.hour
          return true, next_date
        end  
        
      when DAY
        if (requested_period > 1) then
          ref_date = current_date.beginning_of_week
          to_second = 1.day
        else # requested_period == 1
          ref_date = current_date.beginning_of_day
          next_date = ref_date + 1.day
          return true, next_date
        end
        
      when MONTH
        if (requested_period > 1) then
          ref_date = current_date.beginning_of_year      
          next_date = ref_date
          while (next_date <= ref_date) do
            idx = 0
            while (idx < requested_period) do
              next_date = next_month(next_date)
              #days = Time.days_in_month(next_date.month, next_date.year)
              #next_date = next_date + 1.day*days
              #p ">>> #{next_date}"
              idx = idx + 1
            end
          end
          return true, next_date
        else  # requested_period == 1
          ref_date = current_date.beginning_of_month
          #days = Time.days_in_month(current_date.month, current_date.year)
          #next_date = ref_date + 1.day*days
          next_date = next_month(ref_date)
          return true, next_date
        end
        
      else
        return false, nil
    end
    
    nb_period = (current_date.to_i - ref_date.to_i) / (requested_period*to_second)
    nb_period = nb_period + 1
    next_date_in_s = ref_date.to_i + nb_period * requested_period*to_second
    next_date = Time.at(next_date_in_s)
    return true, next_date
    
  end

  def next_month(date)
    days = Time.days_in_month(date.month, date.year)
    next_date = date + 1.day*days
    return next_date
  end

#    If you have a month m and year y, use the class method on Time:
#   days = Time.days_in_month(m, y)
#    If you have a Time object t, cleaner to ask the day number of the last day of the month:
#    days = t.end_of_month.day
  
end

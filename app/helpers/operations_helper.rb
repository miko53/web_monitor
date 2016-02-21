module OperationsHelper

  def get_unit(period_unit)
    case period_unit
      when PeriodHelper::MINUTE
        return "minute(s)"
      when PeriodHelper::HOUR
        return "hour(s)"
      when PeriodHelper::DAY
        return "day(s)"
      when PeriodHelper::MONTH
        return "month(s)"
      else
        return "unknown unit"
    end
  end
end

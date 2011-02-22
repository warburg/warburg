class DateIsaar < ActiveRecord::Base
  stampable

  def self.create_from_date(date)
    self.create(:year => date.year, :month => date.month, :day => date.day)
  end
  
  def to_s
    result = ''
    result << day.to_s.rjust(2, '0') << '/' if day
    result << month.to_s.rjust(2, '0') << '/' if month
    result << year.to_s if year
    result = '---' if (result == '')
    result
  end
  
  def for_form
    result = ''
    result << year.to_s if year
    result << month.to_s.rjust(2, '0') if month
    result << day.to_s.rjust(2, '0') if day
    result
  end
  
  def self.from_s(s)
    if s.blank?
      nil
    else
      result = DateIsaar.new
      result.year = s[0..3] if s.size >= 4
      result.month = s[4..5] if s.size >= 6
      result.day = s[6..7] if s.size == 8
      result
    end
  end
  
  def to_date
    Date.new(fill(year), fill(month), fill(day))
  end
  
  private 
  
  def fill(i)
    if i.present? && i > 0
      i
    else
      1
    end
  end
end

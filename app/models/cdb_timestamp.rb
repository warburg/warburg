class CdbTimestamp < ActiveRecord::Base
  belongs_to :cdb_event, :dependent => :destroy

  def to_s
    d = date
    t = timestart
    I18n.l(Time.parse("#{d.to_s} #{t.hour}:#{t.min}:#{t.sec}"))
  end
end

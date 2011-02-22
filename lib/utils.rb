class Utils
  
  def self.i18n_db_value(obj, attribute)
    ln = %w(en nl fr)
    rvalue = obj.send("#{attribute.to_s}_#{ln.delete(I18n.locale)}")
    unless rvalue
      until ln.empty? || rvalue do
        rvalue = obj.send("#{attribute.to_s}_#{ln.delete_at(0)}")
      end
    end
    rvalue
  end
  
end
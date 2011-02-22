class Barcode
  
  def self.barcode_for(prefix, length, value)
    if value.to_s.length < length
      prefix.to_s + value.to_s.rjust(length - 1, '0')
    else
      value
    end
  end
  
end
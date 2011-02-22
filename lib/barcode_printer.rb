require "rubygems"
require "prawn"
require "barby"
require "barby/outputter/prawn_outputter"

class BarcodePrinter
  
  def print(barcodes, width, height, location)
    Prawn::Document.generate(location) do
      canvas do
        bounding_box [20,780], :width => 575, :height => 760 do    
          # barcode.annotate_pdf(self, :height => 15, :xdim => 0.5)
          stroke_rectangle bounds.top_left, bounds.width, bounds.height
        
          bounding_box [0,760], :width => width, :height => height do    
            # barcode.annotate_pdf(self, :height => 15, :xdim => 0.5)
            stroke_rectangle bounds.top_left, bounds.width, bounds.height
          end
          bounding_box [200,760], :width => width, :height => height do    
            # barcode.annotate_pdf(self, :height => 30)
            stroke_rectangle bounds.top_left, bounds.width, bounds.height
          end 
          bounding_box [400,760], :width => width, :height => height do    
            # barcode.annotate_pdf(self, :height => 30)
            stroke_rectangle bounds.top_left, bounds.width, bounds.height
          end 
        end      
      end
    end    
  end
  
end


if $0 == __FILE__
  BarcodePrinter.new.print([], 100, 30, "/Users/atog/Desktop/test.pdf")
  puts "Done."
end
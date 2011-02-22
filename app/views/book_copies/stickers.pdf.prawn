require 'extend_string'

columns = 4
rows = 9
x_offset = 0.mm
y_offset = 10.mm

pdf.font @font 
total_width = pdf.bounds.width
total_height = pdf.bounds.height

x = init_x = x_offset
y = init_y = (total_height - y_offset)
width = total_width / columns
height = total_height / rows

new_page = true

@objects.each do |object|
  
	pdf.bounding_box [x-1.mm,y], :width => width, :height => height do 
		pdf.font.size = @title_font_size
		pdf.text "*#{object.barcode.removeaccents}*", :align => :center
		
		title_base = pdf.cursor - 2.mm
		
		barcode_height = 15
		barcode_base = title_base - barcode_height
		Barby::Code39.new(object.barcode, true).annotate_pdf(pdf, :height => barcode_height, :y => barcode_base, :xdim => @xdim, :x => (width * (1 - @xdim))/2)

		pdf.font.size = @barcode_font_size
		pdf.bounding_box [0, barcode_base], :width => width, :height => pdf.font.height do
			pdf.text object.title ? object.title[0..30].removeaccents : "", :align => :center
		end
		
		x = x + width
		if x >= total_width 
			x = init_x
			y = y - height
		end
		
		if y < (height - y_offset)
			pdf.start_new_page unless @objects.last == object
			y = init_y
		end
	end
end

pdf.start_new_page(:layout => :landscape)

columns = 9
rows = 4
x_offset = 2.mm
y_offset = 0.mm

total_width = pdf.bounds.width
total_height = pdf.bounds.height

x = init_x = x_offset
y = init_y = (total_height - y_offset)
width = total_width / columns
height = total_height / rows

@objects.each do |object|
	pdf.bounding_box [x,y], :width => width, :height => height do 
		pdf.font.size = @title_font_size
    pdf.text object.library_location.gsub(/\//, "\n"), :align => :center
    
    x = x + 3.cm
		if x > total_width - 50
			x = init_x
			y = y - 5.cm
		end
		
		if y+40.mm < (height - y_offset)
			pdf.start_new_page unless @objects.last == object
			y = init_y
		end
		
	end
end




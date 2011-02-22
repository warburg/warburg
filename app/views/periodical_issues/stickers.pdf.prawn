columns = 4
rows = 21
x_offset = -3.mm
y_offset = -2.mm


pdf.font @font 
total_width = pdf.bounds.width
total_height = pdf.bounds.height
x = init_x = x_offset
y = init_y = (total_height - y_offset)

width = total_width / columns
height = total_height / rows

@objects.each do |object|
	pdf.bounding_box [x,y], :width => width, :height => height do 
		pdf.font.size = @title_font_size
		title_base = pdf.cursor - 3.mm
		
		barcode_height = 15
		barcode_base = title_base - barcode_height
		Barby::Code39.new(object.barcode, true).annotate_pdf(pdf, :height => barcode_height, :y => barcode_base, :xdim => @xdim, :x => (width * (1 - @xdim))/2)

		pdf.font.size = @barcode_font_size
		pdf.bounding_box [0, barcode_base], :width => width, :height => pdf.font.height do
			pdf.text "*#{object.barcode.removeaccents}*", :align => :center
		end
		
		x = x + width
		if x >= total_width - 3.mm 
			x = init_x
			y = y - 11.08.mm
		end
		
		if y+5.mm < (height - y_offset)
			pdf.start_new_page unless @objects.last == object
			y = init_y
		end
	end
end

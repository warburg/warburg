columns = 2
rows = 4
x_offset = 7.mm
y_offset = 8.mm


pdf.font @font 
total_width = pdf.bounds.width - 13.mm
total_height = pdf.bounds.height
x = init_x = x_offset
y = init_y = (total_height - y_offset)
width = (total_width / columns) - 5.mm
height = (total_height / rows) - 2.mm

@objects.each do |object|
	pdf.bounding_box [x,y], :width => width, :height => height do 
		pdf.font.size = @title_font_size
		title_base = pdf.cursor - 2.mm
		barcode_height = 15
		barcode_base = title_base - barcode_height
		Barby::Code39.new(object.barcode, true).annotate_pdf(pdf, :height => barcode_height, :y => barcode_base, :xdim => @xdim, :x => (width - 110)/2)

		pdf.font.size = @barcode_font_size
		pdf.bounding_box [0, barcode_base], :width => width, :height => pdf.font.height do
			pdf.text "*#{object.barcode.removeaccents}*", :align => :center
		end
		
		pdf.text "#{object.box_type.description_nl.removeaccents}", :align => :center
		
		pdf.move_down -pdf.font.descender + 2
		
		pdf.stroke do
			pdf.line_width = 0.1
			pdf.line (0, pdf.cursor, width, pdf.cursor)
		end
		
		object.contains_documents[0..13].each do |document|
			pdf.text document.title.removeaccents
		end
		
		x = x + width + 16.mm
		if x >= total_width 
			x = init_x
			y = y - height
		end
		
		if y < (height - y_offset)
			pdf.start_new_page
			y = init_y
		end
	end
end

columns = 4
rows = 21
x_offset = 2.mm
y_offset = 3.mm


parent_pdf.font @font 
total_width = parent_pdf.bounds.width
total_height = parent_pdf.bounds.height

x = init_x = x_offset
y = init_y = (total_height - y_offset)

width = total_width / columns
height = total_height / rows

@objects.each do |object|
	parent_pdf.bounding_box [x,y], :width => width, :height => height do 
		parent_pdf.font.size = @title_font_size
		parent_pdf.text object.title.removeaccents, :align => :center, :size => 12, :at => [35, 15]
		
    x = x + width
		if x >= total_width 
			x = init_x
			y = y - 12.66.mm
		end
		
		if y < (height - y_offset)
			parent_pdf.start_new_page
			y = init_y
		end
	end
end

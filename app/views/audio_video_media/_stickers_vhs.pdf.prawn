columns = 1
rows = 16
x_offset = 32.mm
y_offset = 0.mm


parent_pdf.font @font 

total_width  = parent_pdf.bounds.width
total_height = parent_pdf.bounds.height


x = init_x = x_offset
y = init_y = (total_height - y_offset)

width  = total_width - (2 * x_offset)
height = (total_height - (2 * y_offset)) / rows

@objects.each do |object|
	parent_pdf.bounding_box [x,y], :width => width, :height => height do 
		parent_pdf.font.size = @title_font_size
		parent_pdf.text object.title.removeaccents, :align => :right, :size => 12, :at => [300, 22], :style => :bold
		
		first_title  = object.audio_video_titles[0].try(:title)
		second_title = object.audio_video_titles[1].try(:title)
		third_title  = object.audio_video_titles[3].try(:title)
		
		parent_pdf.text first_title  ? first_title[0..40].removeaccents  : "", :align => :left, :at => [120, 27]
		parent_pdf.text second_title ? second_title[0..40].removeaccents : "", :align => :left, :at => [120, 18]
		parent_pdf.text third_title  ? third_title[0..40].removeaccents  : "", :align => :left, :at => [120, 9]
		
		title_base = parent_pdf.cursor - 5.mm
		
		barcode_height = 15
		barcode_base = title_base - barcode_height
		Barby::Code39.new(object.barcode, true).annotate_pdf(parent_pdf, :height => barcode_height, :y => barcode_base, :xdim => @xdim)

		parent_pdf.font.size = @barcode_font_size
		parent_pdf.bounding_box [13.mm, barcode_base], :width => width, :height => (barcode_base) do
			parent_pdf.text "*#{object.barcode.removeaccents}*", :align => :left
		end
		
		y = y - 16.86.mm
		
		if y+8 < (height - y_offset)
			parent_pdf.start_new_page
			y = init_y
		end
	end
end

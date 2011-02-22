# encoding: utf-8
#
# table.rb : Simple table drawing functionality
#
# Copyright June 2008, Gregory Brown.  All Rights Reserved.
#
# This is free software. Please see the LICENSE and COPYING files for details.

module Prawn
  class Document    
    
    # Builds and renders a Document::Table object from raw data.
    # For details on the options that can be passed, see
    # Document::Table.new
    #
    #   data = [["Gregory","Brown"],["James","Healy"],["Jia","Wu"]]
    #
    #   Prawn::Document.generate("table.pdf") do
    #     
    #     # Default table, without headers
    #     table(data)
    #
    #     # Default table with headers
    #     table data, :headers => ["First Name", "Last Name"]
    #
    #     # Very close to PDF::Writer's default SimpleTable output
    #     table data, :headers            => ["First Name", "Last Name"],
    #                 :font_size          => 10,
    #                 :vertical_padding   => 2,
    #                 :horizontal_padding => 5,
    #                 :position           => :center,
    #                 :row_colors         => :pdf_writer,
    #
    #     # Grid border style with explicit column widths.
    #     table data, :border_style => :grid,
    #                 :widths       => { 0 => 100, 1 => 150 }
    #
    #   end
    #
    #   Will raise <tt>Prawn::Errors::EmptyTable</tt> given 
    #   a nil or empty <tt>data</tt> paramater.
    #
    def table(data,options={})           
      if data.nil? || data.empty?
        raise Prawn::Errors::EmptyTable,
          "data must be a non-empty, non-nil, two dimensional array of Prawn::Cells or strings"
      end
      Prawn::Document::Table.new(data,self,options).draw
    end

    # This class implements simple PDF table generation.
    # 
    # Prawn tables have the following features:
    #
    #   * Can be generated with or without headers
    #   * Can tweak horizontal and vertical padding of text
    #   * Minimal styling support (borders / row background colors)
    #   * Can be positioned by bounding boxes (left/center aligned) or an
    #     absolute x position
    #   * Automated page-breaking as needed
    #   * Column widths can be calculated automatically or defined explictly on a 
    #     column by column basis
    #   * Text alignment can be set for the whole table or by column
    #
    # The current implementation is a bit barebones, but covers most of the
    # basic needs for PDF table generation.  If you have feature requests,
    # please share them at: http://groups.google.com/group/prawn-ruby
    #
    # Tables will be revisited before the end of the Ruby Mendicant project and
    # the most commonly needed functionality will likely be added.
    # 
    class Table  
      
      include Prawn::Configurable

      attr_reader :col_widths # :nodoc: 
      
      NUMBER_PATTERN = /^-?(?:0|[1-9]\d*)(?:\.\d+(?:[eE][+-]?\d+)?)?$/ #:nodoc: 

      # Creates a new Document::Table object. This is generally called 
      # indirectly through Document#table but can also be used explictly.
      #
      # The <tt>data</tt> argument is a two dimensional array of strings,
      # organized by row, e.g. [["r1-col1","r1-col2"],["r2-col2","r2-col2"]].
      # As with all Prawn text drawing operations, strings must be UTF-8 encoded.
      #
      # The following options are available for customizing your tables, with
      # defaults shown in [] at the end of each description.
      #
      # <tt>:headers</tt>:: An array of table headers, either strings or Cells. [Empty]
      # <tt>:align_headers</tt>:: Alignment of header text.  Specify for entire header (<tt>:left</tt>) or by column (<tt>{ 0 => :right, 1 => :left}</tt>). If omitted, the header alignment is the same as the column alignment.
      # <tt>:header_text_color</tt>:: Sets the text color of the headers
      # <tt>:header_color</tt>:: Manually sets the header color
      # <tt>:font_size</tt>:: The font size for the text cells . [12]
      # <tt>:horizontal_padding</tt>:: The horizontal cell padding in PDF points [5]
      # <tt>:vertical_padding</tt>:: The vertical cell padding in PDF points [5]
      # <tt>:padding</tt>:: Horizontal and vertical cell padding (overrides both)
      # <tt>:border_width</tt>:: With of border lines in PDF points [1]
      # <tt>:border_style</tt>:: If set to :grid, fills in all borders. If set to :underline_header, underline header only. Otherwise, borders are drawn on columns only, not rows
      # <tt>:border_color</tt>:: Sets the color of the borders.
      # <tt>:position</tt>:: One of <tt>:left</tt>, <tt>:center</tt> or <tt>n</tt>, where <tt>n</tt> is an x-offset from the left edge of the current bounding box
      # <tt>:widths:</tt> A hash of indices and widths in PDF points.  E.g. <tt>{ 0 => 50, 1 => 100 }</tt>
      # <tt>:row_colors</tt>:: An array of row background colors which are used cyclicly.   
      # <tt>:align</tt>:: Alignment of text in columns, for entire table (<tt>:center</tt>) or by column (<tt>{ 0 => :left, 1 => :center}</tt>)
      # <tt>:minimum_rows</tt>:: The minimum rows to display on a page, including header.
      #
      # Row colors are specified as html encoded values, e.g.
      # ["ffffff","aaaaaa","ccaaff"].  You can also specify 
      # <tt>:row_colors => :pdf_writer</tt> if you wish to use the default color
      # scheme from the PDF::Writer library.
      #
      # See Document#table for typical usage, as directly using this class is
      # not recommended unless you know why you want to do it.
      #
      def initialize(data, document,options={})     
        unless data.all? { |e| Array === e }
          raise Prawn::Errors::InvalidTableData,
            "data must be a two dimensional array of Prawn::Cells or strings"
        end
        
        @data     = data        
        @document = document
        
        Prawn.verify_options [:font_size,:border_style, :border_width,
         :position, :headers, :row_colors, :align, :align_headers, :header_text_color, :border_color,
         :horizontal_padding, :vertical_padding, :padding, :widths, 
         :header_color ], options     
                                            
        configuration.update(options)  

        if padding = options[:padding]
          C(:horizontal_padding => padding, :vertical_padding => padding) 
        end
         
        if options[:row_colors] == :pdf_writer 
          C(:row_colors => ["ffffff","cccccc"])  
        end
        
        if options[:row_colors]
          C(:original_row_colors => C(:row_colors)) 
        end

        calculate_column_widths(options[:widths])
      end                                        
      
      attr_reader :col_widths #:nodoc:
      
      # Width of the table in PDF points
      #
      def width
         @col_widths.inject(0) { |s,r| s + r }
      end
      
      # Draws the table onto the PDF document
      #
      def draw  
        @parent_bounds = @document.bounds  
        case C(:position) 
        when :center
          x = (@document.bounds.width - width) / 2.0
          dy = @document.bounds.absolute_top - @document.y
          @document.bounding_box [x, @parent_bounds.top], :width => width do 
            @document.move_down(dy)
            generate_table
          end
        when Numeric     
          x, y = C(:position), @document.y - @document.bounds.absolute_bottom
          @document.bounding_box([x,y], :width => width) { generate_table }
        else
          generate_table
        end
      end

      private
      
      def default_configuration     
        { :font_size           => 12, 
          :border_width        => 1, 
          :position            => :left,
          :horizontal_padding  => 5,
          :vertical_padding    => 5 } 
      end

      def calculate_column_widths(manual_widths=nil)
        @col_widths = [0] * @data[0].length    
        renderable_data.each do |row|
          row.each_with_index do |cell,i|
            length = cell.to_s.lines.map { |e| 
              @document.font.metrics.string_width(e,C(:font_size)) }.max.to_f +
                2*C(:horizontal_padding)
            @col_widths[i] = length.ceil if length > @col_widths[i]
          end
        end  
        
        manual_widths.each { |k,v| @col_widths[k] = v } if manual_widths           
      end

      def renderable_data
        C(:headers) ? [C(:headers)] + @data : @data
      end

      def generate_table    
        page_contents = []
        y_pos = @document.y 

        @document.font.size C(:font_size) do
          renderable_data.each_with_index do |row,index|
            c = Prawn::Graphics::CellBlock.new(@document)
            
            col_index = 0
            row.each do |e|
              case C(:align)
              when Hash
                align            = C(:align)[col_index]
              else
                align            = C(:align)
              end   
              
              
              align ||= e.to_s =~ NUMBER_PATTERN ? :right : :left 
              
              case e
              when Prawn::Graphics::Cell
                e.document = @document
                e.width    = @col_widths[col_index]
                e.horizontal_padding = C(:horizontal_padding)
                e.vertical_padding   = C(:vertical_padding)    
                e.border_width       = C(:border_width)
                e.border_style       = :sides
                e.align              = align 
                c << e
              else
                text = e.is_a?(Hash) ? e[:text] : e.to_s
                width = if e.is_a?(Hash) && e.has_key?(:colspan)
                  @col_widths.slice(col_index, e[:colspan]).inject { |sum, width| sum + width }
                else
                  @col_widths[col_index]
                end
                
                c << Prawn::Graphics::Cell.new(
                  :document => @document, 
                  :text     => text,
                  :width    => width,
                  :horizontal_padding => C(:horizontal_padding),
                  :vertical_padding   => C(:vertical_padding),
                  :border_width       => C(:border_width),
                  :border_style       => :sides,
                  :align              => align ) 
              end
              
              col_index += (e.is_a?(Hash) && e.has_key?(:colspan)) ? e[:colspan] : 1
            end
                                                
            bbox = @parent_bounds.stretchy? ? @document.margin_box : @parent_bounds
            if c.height > y_pos - bbox.absolute_bottom
              if C(:headers) && page_contents.length == 1
                @document.start_new_page
                y_pos = @document.y
              else
                draw_page(page_contents)
                @document.start_new_page
                if C(:headers) && page_contents.any?
                  page_contents = [page_contents[0]]
                  y_pos = @document.y - page_contents[0].height
                else
                  page_contents = []
                  y_pos = @document.y
                end
              end
            end

            page_contents << c

            y_pos -= c.height

            if index == renderable_data.length - 1
              draw_page(page_contents)
            end

          end
        end
      end

      def draw_page(contents)
        return if contents.empty?
 
        if C(:border_style) == :underline_header
          contents.each { |e| e.border_style = :none }
          contents.first.border_style = :bottom_only if C(:headers)
        elsif C(:border_style) == :grid || contents.length == 1
          contents.each { |e| e.border_style = :all }
        else
          contents.first.border_style = C(:headers) ? :all : :no_bottom
          contents.last.border_style = :no_top
        end
        
        if C(:headers)
          contents.first.cells.each_with_index do |e,i|
            if C(:align_headers)
              case C(:align_headers)
                when Hash
                  align = C(:align_headers)[i]
                else
                  align = C(:align_headers)
                end
            end
            e.align = align if align
            e.text_color = C(:header_text_color) if C(:header_text_color)
            e.background_color = C(:header_color) if C(:header_color)
          end
        end
        
        contents.each do |x|
          unless x.background_color
            x.background_color = next_row_color if C(:row_colors)
          end
          x.border_color = C(:border_color) if C(:border_color)
          
          x.draw 
        end
 
        reset_row_colors
      end


      def next_row_color
        color = C(:row_colors).shift
        C(:row_colors).push(color)
        color
      end

      def reset_row_colors    
        C(:row_colors => C(:original_row_colors).dup) if C(:row_colors)
      end

    end
  end
end

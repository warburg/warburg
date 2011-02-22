# encoding: utf-8
#
# font.rb : The Prawn font class
#
# Copyright May 2008, Gregory Brown / James Healy. All Rights Reserved.
#
# This is free software. Please see the LICENSE and COPYING files for details.
require "prawn/font/wrapping"       
require "prawn/font/metrics"
require "prawn/font/cmap" 

module Prawn 
  
  class Document 
    # Without arguments, this returns the currently selected font. Otherwise,
    # it sets the current font.
    #
    # The single parameter must be a string. It can be one of the 14 built-in
    # fonts supported by PDF, or the location of a TTF file. The BUILT_INS
    # array specifies the valid built in font values.
    #
    #   pdf.font "Times-Roman"
    #   pdf.font "Chalkboard.ttf"
    #
    # If a ttf font is specified, the full file will be embedded in the 
    # rendered PDF. This should be your preferred option in most cases. 
    # It will increase the size of the resulting file, but also make it 
    # more portable.
    #
    def font(name=nil, options={}) 
      return @font || font("Helvetica") if name.nil?

      if block_given?
        original_name = font.name
        original_size = font.size
      end
      
      @font = find_font(name, options)
      @font.add_to_current_page
     
      @font.size = options[:size] if options[:size]
      
      if block_given?
        yield
        font(original_name, :size => original_size)
      else
        @font
      end
    end

    # Looks up the given font name. Once a font has been found by that name,
    # it will be cached to subsequent lookups for that font will return the
    # same object.
    #
    def find_font(name, options={}) #:nodoc:
      if font_families.key?(name)
        family, name = name, font_families[name][options[:style] || :normal]
      end

      font_registry[name] ||= Font.new(name, options.merge(:for => self, :family => family))
    end      
       
    # Hash of Font objects keyed by names
    #
    def font_registry #:nodoc:
      @font_registry ||= {}
    end     
     
    # Hash that maps font family names to their styled individual font names
    #  
    # To add support for another font family, append to this hash, e.g:
    #
    #   pdf.font_families.update(
    #    "MyTrueTypeFamily" => { :bold        => "foo-bold.ttf", 
    #                            :italic      => "foo-italic.ttf",
    #                            :bold_italic => "foo-bold-italic.ttf",
    #                            :normal      => "foo.ttf" })
    #
    # This will then allow you to use the fonts like so:
    #
    #   pdf.font("MyTrueTypeFamily", :style => :bold)   
    #   pdf.text "Some bold text"
    #   pdf.font("MyTrueTypeFamily")
    #   pdf.text "Some normal text"
    #
    # This assumes that you have appropriate TTF fonts for each style you 
    # wish to support.
    #                                                  
    def font_families 
      @font_families ||= Hash.new { |h,k| h[k] = {} }.merge!(      
        { "Courier"     => { :bold        => "Courier-Bold",
                             :italic      => "Courier-Oblique",
                             :bold_italic => "Courier-BoldOblique",
                             :normal      => "Courier" },       
           
          "Times-Roman" => { :bold         => "Times-Bold",
                             :italic       => "Times-Italic",
                             :bold_italic  => "Times-BoldItalic",
                             :normal       => "Times-Roman" },        
           
          "Helvetica"   => { :bold         => "Helvetica-Bold",
                             :italic       => "Helvetica-Oblique",
                             :bold_italic  => "Helvetica-BoldOblique",
                             :normal       => "Helvetica" }        
        }) 
    end
  end
  
  # Provides font information and helper functions.  
  # 
  class Font
    
    BUILT_INS = %w[ Courier Helvetica Times-Roman Symbol ZapfDingbats 
                    Courier-Bold Courier-Oblique Courier-BoldOblique
                    Times-Bold Times-Italic Times-BoldItalic
                    Helvetica-Bold Helvetica-Oblique Helvetica-BoldOblique ] 
                        
    DEFAULT_SIZE = 12
      
    # The font metrics object  
    attr_reader   :metrics
    
    # The current font name
    attr_reader :name
    
    # The current font family
    attr_reader :family
  
    attr_reader  :identifier, :reference #:nodoc:
    
    # Sets the size of the current font:
    #
    #   font.size = 16
    #
    attr_writer   :size         
      
    def initialize(name,options={}) #:nodoc:
      @name       = name   
      @family     = options[:family]      
              
      @metrics    = Prawn::Font::Metrics[name] 
      @document   = options[:for]  
      
      @document.proc_set :PDF, :Text  
      @size       = DEFAULT_SIZE
      @identifier = :"F#{@document.font_registry.size + 1}"  

      @reference = nil
    end     
    
    def inspect
      "Prawn::Font< #{name}: #{size} >"
    end
    
    # Sets the default font size for use within a block. Individual overrides
    # can be used as desired. The previous font size will be restored after the
    # block.
    #
    # Prawn::Document.generate("font_size.pdf") do
    #   font.size = 16
    #   text "At size 16"
    #
    #   font.size(10) do
    #     text "At size 10"
    #     text "At size 6", :size => 6
    #     text "At size 10"
    #   end
    #
    #   text "At size 16"
    # end
    #
    # When called without an argument, this method returns the current font
    # size.
    #
    def size(points=nil)      
      return @size unless points
      size_before_yield = @size
      @size = points
      yield
      @size = size_before_yield
    end    
        
    # Gets width of string in PDF points at current font size
    #
    # If using an AFM, string *must* be encoded as WinAnsi 
    # (Use normalize_encoding to convert)
    # 
    def width_of(string)
      @metrics.string_width(string,@size)
    end     
     
    # Gets height of text in PDF points at current font size.
    # Text +:line_width+ must be specified in PDF points. 
    #
    # If using an AFM, string *must* be encoded as WinAnsi 
    # (Use normalize_encoding to convert)
    #
    def height_of(text,options={}) 
      @metrics.string_height( text, :font_size  => @size, 
                                    :line_width => options[:line_width] ) 
    end                     
     
    # Gets height of current font in PDF points at current font size
    #
    def height
      @metrics.font_height(@size)       
    end   
    
    # The height of the ascender at the current font size in PDF points
    #
    def ascender 
      @metrics.ascender / 1000.0 * @size
    end  
    
    # The height of the descender at the current font size in PDF points
    #
    def descender 
      @metrics.descender / 1000.0 * @size
    end
    
    def line_gap
      @metrics.line_gap / 1000.0 * @size
    end
                           
    def normalize_encoding(text) # :nodoc:
      # check the string is encoded sanely
      # - UTF-8 for TTF fonts
      # - ISO-8859-1 for Built-In fonts
      if @metrics.type0?
        normalize_ttf_encoding(text) 
      else
        normalize_builtin_encoding(text) 
      end 
    end
                 
    def add_to_current_page #:nodoc:
      embed! unless @reference
      @document.page_fonts.merge!(@identifier => @reference)
    end              
    
    private

    def embed!
      case(name)
      when /\.ttf$/i
        embed_ttf(name)
      else
        register_builtin(name)
      end  
    end

    # built-in fonts only work with winansi encoding, so translate the string
    def normalize_builtin_encoding(text)
      enc = Prawn::Encoding::WinAnsi.new
      text.replace text.unpack("U*").collect { |i| enc[i] }.pack("C*")
    end

    def normalize_ttf_encoding(text)
      # TODO: if the current font is a built in one, we can't use the utf-8
      # string provided by the user. We should convert it to WinAnsi or
      # MacRoman or some such.
      if text.respond_to?(:encode!)
        # if we're running under a M17n aware VM, ensure the string provided is
        # UTF-8 (by converting it if necessary)
        begin
          text.encode!("UTF-8")
        rescue
          raise Prawn::Errors::IncompatibleStringEncoding, "Encoding " +
          "#{text.encoding} can not be transparently converted to UTF-8. " +
          "Please ensure the encoding of the string you are attempting " +
          "to use is set correctly"
        end
      else
        # on a non M17N aware VM, use unpack as a hackish way to verify the
        # string is valid utf-8. I thought it was better than loading iconv
        # though.
        begin
          text.unpack("U*")
        rescue
          raise Prawn::Errors::IncompatibleStringEncoding, "The string you " +
          "are attempting to render is not encoded in valid UTF-8."
        end
      end
    end
    
    def register_builtin(name) 
      unless BUILT_INS.include?(name)
        raise Prawn::Errors::UnknownFont, "#{name} is not a known font."
      end      
      
      @reference = @document.ref( :Type     => :Font,
                                  :Subtype  => :Type1,
                                  :BaseFont => name.to_sym,
                                  :Encoding => :WinAnsiEncoding)                                                   
    end    
    
    def embed_ttf(file)
      unless File.file?(file)
        raise ArgumentError, "file #{file} does not exist"
      end

      basename = @metrics.basename

      raise "Can't detect a postscript name for #{file}" if basename.nil?

      @encodings = @metrics.cmap

      if @encodings.nil?
        raise "#{file} missing the required encoding table"
      end

      font_content = File.open(file,"rb") { |f| f.read }
      compressed_font = Zlib::Deflate.deflate(font_content)

      fontfile = @document.ref(:Length => compressed_font.size,
                               :Length1 => font_content.size,
                               :Filter => :FlateDecode )
      fontfile << compressed_font

      # TODO: Not sure what to do about CapHeight, as ttf2afm doesn't
      # pick it up. Missing proper StemV and flags
      #
      descriptor = @document.ref(:Type        => :FontDescriptor,
                                 :FontName    => basename,
                                 :FontFile2   => fontfile,
                                 :FontBBox    => @metrics.bbox,
                                 :Flags       => 32, # FIXME: additional flags
                                 :StemV       => 0,
                                 :ItalicAngle => 0,
                                 :Ascent      => @metrics.ascender,
                                 :Descent     => @metrics.descender )    

      descendant = @document.ref(:Type           => :Font,
                                 :Subtype        => :CIDFontType2, # CID, TTF
                                 :BaseFont       => basename,
                                 :CIDSystemInfo  => { :Registry   => "Adobe",
                                                      :Ordering   => "Identity",
                                                      :Supplement => 0 },
                                 :FontDescriptor => descriptor,
                                 :W              => @metrics.glyph_widths,
                                 :CIDToGIDMap    => :Identity ) 

      to_unicode_content = @metrics.to_unicode_cmap.to_s
      compressed_to_unicode = Zlib::Deflate.deflate(to_unicode_content)   
      
      to_unicode = @document.ref(:Length  => compressed_to_unicode.size,
                                 :Length1 => to_unicode_content.size,
                                 :Filter  => :FlateDecode )
      to_unicode << compressed_to_unicode

      @reference = @document.ref(:Type            => :Font,
                                 :Subtype         => :Type0,
                                 :BaseFont        => basename,
                                 :DescendantFonts => [descendant],
                                 :Encoding        => :"Identity-H",
                                 :ToUnicode       => to_unicode)

    end                              

  end
   
end

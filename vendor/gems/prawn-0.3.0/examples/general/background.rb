# encoding: utf-8
#
# This example demonstrates the use of the new :background option when
# generating a new Document.  Image is assumed to be pre-fit for your page
# size, and will not be rescaled.
#
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', '..', 'lib'))
require "prawn"

img = "#{Prawn::BASEDIR}/data/images/letterhead.jpg"

Prawn::Document.generate("background.pdf", :background => img) do
  text_options.update(:size => 18, :align => :right)
  text "My report caption"
  text_options.update(:size => 12, :align => :left, :spacing => 2)
  move_down font.height * 2
  text "Here is my text explaning this report. " * 20
  move_down font.height
  text "I'm using a soft background. " * 40
end
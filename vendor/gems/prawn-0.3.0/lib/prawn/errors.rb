# encoding: utf-8

# errors.rb : Implements custom error classes for Prawn
#
# Copyright April 2008, Gregory Brown.  All Rights Reserved.
#
# This is free software. Please see the LICENSE and COPYING files for details.

module Prawn
  module Errors
     
     # This error is raised when Prawn::PdfObject() encounters a Ruby object it
     # cannot convert to PDF
     #
     class FailedObjectConversion < StandardError; end
     
     # This error is raised when Document#page_layout is set to anything
     # other than :portrait or :landscape            
     #
     class InvalidPageLayout < StandardError; end        
     
     # This error is raised when Prawn cannot find a specified font   
     #
     class UnknownFont < StandardError; end   

     # This error is raised when Prawn is being used on a M17N aware VM,
     # and the user attempts to add text that isn't compatible with UTF-8
     # to their document
     #
     class IncompatibleStringEncoding < StandardError; end     
     
     # This error is raised when Prawn encounters an unknown key in functions
     # that accept an options hash.  This usually means there is a typo in your
     # code or that the option you are trying to use has a different name than
     # what you have specified. 
     #
     class UnknownOption < StandardError; end
     
     # This error is raised when table data is malformed
     #
     class InvalidTableData < StandardError; end 

     # This error is raised when an empty or nil table is rendered
     #
     class EmptyTable < StandardError; end 
     
  end
end   

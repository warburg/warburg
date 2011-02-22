class DocumentsController < ApplicationController
  include Userstamp
  include MainKlassController
  
  def index
    if params[:q]
      @objects = ThinkingSphinx.search params[:q], :page => params[:page], :per_page => 300, :star => true
      if @objects.empty?
        flash[:error] = t('message.no_search_results')
      end
      @subtitles = {nil => @objects}
      @subtitles_sorted = @subtitles.keys.sort
      @total_lines = @objects.size
      render "main_klass/index"
    else
      @numbers = {}
      Document.send(:subclasses).each do |cl|
        @numbers[cl] = cl.count
      end
      
      super
    end
  end
end

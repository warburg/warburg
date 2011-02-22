class PressCuttingsController < ApplicationController
  include MainKlassController
  include Userstamp
  
  def todo
    as_admin do
      paginate_params = {:conditions => ['available is null or available = ? or title is null or title = ? or library_location is null or library_location = ? or length(library_location) < 11', false, '', ''], :order => 'created_at desc', :page => params[:page], :per_page => 300}
      @objects = model_class.paginate(paginate_params) 
      if @objects.empty?
        flash[:error] = t('message.no_search_results')
      end
      @subtitles = {nil => @objects}
      @subtitles_sorted = @subtitles.keys.sort
      @total_lines = @objects.size
      render :template => 'main_klass/index'
    end
  end

  def without_language
    as_admin do
      paginate_params = {:conditions => ['not exists (select press_cutting_id from press_cutting_languages l where press_cuttings.id = l.press_cutting_id)'], :order => 'created_at desc', :page => params[:page], :per_page => 300}
      @objects = model_class.paginate(paginate_params) 
      if @objects.empty?
        flash[:error] = t('message.no_search_results')
      end
      @subtitles = {nil => @objects}
      @subtitles_sorted = @subtitles.keys.sort
      @total_lines = @objects.size
      render :template => 'main_klass/index'
    end
  end
end

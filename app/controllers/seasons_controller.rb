class SeasonsController < ApplicationController
  include Userstamp
  include MainKlassController

  def index
    @objects = admin? ? Season.all : Season.visible.all
    
    similar_field = Season.similar_field

    @subtitles = {}
    @objects.each do |object|
      # Notice the weird regexp here. This is to circumvent unicode issues:
      # this regexp gets the 3 first *full characters* (where str[0..2] get the 3 first *bytes*)
      if value = object.send(similar_field)[/..?.?/]
        subtitle = value ? value.strip.downcase.titleize + '0' : '&mdash;'
        @subtitles[subtitle] ||= []
        @subtitles[subtitle] << object
      end
    end
    @total_lines = @subtitles.size * 2 + @objects.size
    @subtitles_sorted = @subtitles.keys.sort

    render :template => 'main_klass/index'
  end

  def show
    @object = admin? ? Season.find(params[:id]) : Season.visible.find(params[:id])

    if @object.nil?
      render :file => "#{RAILS_ROOT}/public/404.html", :status => 404
      return
    end

    respond_to do |format|
      format.html do
        @object.increment_view_counter_skip_stamp if @object.respond_to?("increment_view_counter_skip_stamp")
        render :template => 'main_klass/show'
      end
      format.xml  { render :xml => @object }
      format.rdf  { render :template => 'shared/show', :locals => {:object => @object} }
    end
  end


end
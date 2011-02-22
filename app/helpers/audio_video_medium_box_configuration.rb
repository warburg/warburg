module AudioVideoMediumBoxConfiguration
  include BoxConfiguration

  def columns_for_audio_video_title_on_media
    cols = []
    cols << { :title => 'title',
              :field => lambda {|obj| link_to(obj.audio_video_title.title, obj.audio_video_title) if obj.audio_video_title} }
    cols
  end

end

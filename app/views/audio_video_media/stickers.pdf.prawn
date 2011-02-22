render :partial => (@type == 'vhs' ? 'audio_video_media/stickers_vhs' : 'audio_video_media/stickers_dvd'), :locals=>{:parent_pdf=>pdf}


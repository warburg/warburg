if RAILS_ENV == "development"
  Paperclip.options[:image_magick_path] = "/usr/local/bin"
end
class AddMoreViewFields < ActiveRecord::Migration
  CLASSES = %w(archive_parts articles audio_video_titles book_copies book_titles ephemera ico_titles periodicals repertoires warehouses)

  def self.up
    CLASSES.each{|klazz| add_view_fields(klazz)}
  end

  def self.down
    CLASSES.each{|klazz| remove_view_fields(klazz)}
  end

  def self.add_view_fields(klazz)
    add_column klazz, :views, :integer
    add_column klazz, :viewed_at, :datetime
  end

  def self.remove_view_fields(klazz)
    remove_column klazz, :views
    remove_column klazz, :viewed_at
  end
end

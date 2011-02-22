# Include hook code here
require "acts_as_similar"

# ActiveRecord::Base.extend PgTrgm::Acts::Similar
ActiveRecord::Base.send :include, PgTrgm::Acts::Similar
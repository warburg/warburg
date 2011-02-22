class Order < ActiveRecord::Base
  belongs_to :organisation
  stampable

  set_friendly_id :order_number

  has_many :book_titles, :through => :book_title_orders, :source => :book_title
  has_many :book_title_orders, :dependent => :destroy

end

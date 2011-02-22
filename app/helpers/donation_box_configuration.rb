module DonationBoxConfiguration
  include BoxConfiguration

  def columns_for_donors
    cols = []
    cols << { :title => 'name',
              :field => lambda {|obj| link_to(obj.title, obj)} }
    cols
  end



end

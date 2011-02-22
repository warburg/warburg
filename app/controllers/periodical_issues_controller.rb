class PeriodicalIssuesController < ApplicationController
  include Userstamp
  include MainKlassController
  
  skip_before_filter :verify_authenticity_token
  
  def refresh_list
    @periodical = Periodical.find(params[:periodical_id])
    @periodical_issues = @periodical.periodical_issues(:order => 'updated_at desc')
  end
end

class ErrorReportMailer < ActionMailer::Base

  @@HOST = "data.vti.be"
  @@BASE_URL = "http://#{@@HOST}"

  def new_error_report(error_report, host_with_port)
    setup_email
    @subject    += 'Nieuw error rapport'
    @object = error_report.error_reportable
    @body[:object] = @object
    @body[:error_msg] = error_report.message
    @body[:error_report] = error_report
    if @object
      @body[:url] = url_for(:action => :show, :controller => @object.class.name.tableize.to_sym, :id => @object.cached_slug, :host => host_with_port)
    end
  end

  protected

  def setup_email
    application_name = "Kennisdatabank"
    @recipients  = ERROR_MAILER_TO
    @from        = ERROR_MAILER_FROM
    @subject     = ""
    @sent_on     = Time.now
    @body[:application_name] = application_name
  end

end

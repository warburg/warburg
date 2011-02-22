class ErrorReportsController < DetailsController
  include Userstamp

  before_filter :login_required

  def add
    @error_report = ErrorReport.new(:message => params[:error_report])
    if params[:object].present? && params[:id].present?
      @object = params[:object].constantize.find(params[:id])
    end
    @error_report.error_reportable = @object
    @error_report.save!
    ErrorReportMailer.deliver_new_error_report(@error_report, request.host_with_port)

    logger.info("******** current_user: #{current_user.inspect}")
    respond_to do |format|
      format.html { @object.present? ? redirect_to(@object) : redirect_to(root_url)}
      format.js   { render :layout => false }
    end
  end

  def edit
    @error_report = ErrorReport.find(params["error_report_id"])
    @error_report.message = params[:error_report]
    @error_report.save!
    @object = eval("#{params[:object]}.find(params[:id])")
    respond_to do |format|
      format.html { redirect_to(@object) }
      format.js { render :layout => false }
    end
  end

  def destroy
    @error_report = ErrorReport.find(params[:id])
    if (@error_report.user == current_user) || admin?
      @error_report.destroy
      respond_to do |format|
        format.html {
          @object = eval("#{params[:object_class]}.find(params[:object_id])")
          redirect_to(@object) }
        format.js { render :layout => false }
      end
    end
  end

  def fix
    if admin?
      @error_report = ErrorReport.find(params[:id])
      @error_report.fixed = !@error_report.fixed
      @error_report.save!
      @object = @error_report.error_reportable
      respond_to do |format|
        format.js { render :layout => false }
      end
    end
  end

end

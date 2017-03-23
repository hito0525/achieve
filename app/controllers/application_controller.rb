class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :current_notifications, if: :signed_in?
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  PERMISSIBLE_ATTRIBUTES = %i(name avatar avatar_cache)

#CanCan::AccessDeniedというエラーが発生した場合、トップページにリダイレクトするようにする
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, :alert => exception.message
  end

  def current_notifications
  @notifications_count = Notification.where(user_id: current_user.id).where(read: false).count
  end

  private

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: PERMISSIBLE_ATTRIBUTES)
      devise_parameter_sanitizer.permit(:account_update, keys: PERMISSIBLE_ATTRIBUTES)
    end
end




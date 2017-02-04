class SessionsController < ApplicationController
  def create
    user = User.find_by(email: session_params[:email])
    return head(:not_found) unless user

    if user.authenticate(session_params[:password])
      head :no_content
    else
      render json: { errors: [I18n.t('sessions.invalid_password')] }, status: 400
    end
  end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end
end

class SessionsController < ApplicationController
  def create
    user = User.find_by(email: session_params[:email])
    return head(:not_found) unless user

    if user.valid_password?(session_params[:password])
      sign_in(user)
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

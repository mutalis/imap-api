module V2
  # VersionController
  class VersionController < ApplicationController
    include ActionController::HttpAuthentication::Token::ControllerMethods
    abstract!

    protected

    def authenticate
      authenticate_token || render_unauthorized
    end

    def authenticate_token
      authenticate_with_http_token do |token, _options|
        User.find_by(auth_token: token)
      end
    end

    def render_unauthorized
      headers['WWW-Authenticate'] = 'Token realm="Emails"'
      render json: 'Bad credentials', status: 401
    end
  end
end

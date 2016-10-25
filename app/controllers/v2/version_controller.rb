module V2
  # VersionController
  class VersionController < ApplicationController
    include ActionController::HttpAuthentication::Token::ControllerMethods
    abstract!
  end
end

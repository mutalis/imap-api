# ApplicationController
class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def not_found
    api_error(status: 404, errors: 'Not found')
  end

  def api_error(status: 500, errors: '')
    unless Rails.env.production?
      puts errors.full_messages if errors.respond_to? :full_messages
    end
    head status: status && return if errors.empty?
    render json: errors, status: status
  end
end

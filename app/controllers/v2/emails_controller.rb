module V2
  # Emails resource
  class EmailsController < VersionController
    before_action :authenticate
    before_action :set_email, only: [:show, :update, :destroy]

    # GET /emails
    def index
      @emails = Email.all

      render json: @emails, status: 200
    end

    # GET /emails/1
    def show
      render json: @email, status: :ok
    end

    # POST /emails
    def create
      @email = Email.new(email_params)

      if @email.save
        # render json: @email, status: :created, location: url_for(['v2', @email])
        render json: @email, status: :created, location: v2_email_url(@email)
      else
        render json: @email.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /emails/1
    def update
      if @email.update(email_params)
        render json: @email, status: 200
      else
        render json: @email.errors, status: :unprocessable_entity
      end
    end

    # DELETE /emails/1
    def destroy
      @email.destroy
      head 204
    end

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
      self.headers['WWW-Authenticate'] = 'Token realm="Emails"'
      render json: 'Bad credentials', status: 401
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_email
      @email = Email.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def email_params
      params.require(:email).permit(:username, :quota, :password)
    end
  end
end

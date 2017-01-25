module V2
  # Emails resource
  class EmailsController < VersionController
    before_action :authenticate
    before_action :set_email, only: [:show, :update, :destroy]

    # GET /v2/domains/:domain_id/emails
    def index
      @emails = Domain.find(params[:domain_id]).emails

      if @emails
        render json: @emails, status: 200
      else
        render json: @email.errors, status: :unprocessable_entity
      end
    end

    # GET /v2/emails/:id
    def show
      render json: @email, status: :ok
    end

    # POST /v2/domains/:domain_id/emails
    def create
      domain = Domain.find(params[:domain_id])

      if domain
        @email = Email.new(email_params)
        @email.domain = domain
          if @email.save
            # render json: @email, status: :created, location: url_for(['v2', @email])
            render json: @email, status: :created, location: v2_email_url(@email)
          else
            render json: @email.errors, status: :unprocessable_entity
          end
      end
    end

    # PATCH/PUT /v2/emails/:id
    def update
      if @email.update(email_params)
        render json: @email, status: 200
      else
        render json: @email.errors, status: :unprocessable_entity
      end
    end

    # DELETE /v2/emails/:id
    def destroy
      @email.destroy
      head 204
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

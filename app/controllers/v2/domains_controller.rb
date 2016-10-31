module V2
  # Domains Resource
  class DomainsController < VersionController
    before_action :authenticate
    before_action :set_domain, only: [:show, :update, :destroy]

    # GET /domains
    def index
      @domains = Domain.all

      render json: @domains, status: 200
    end

    # GET /domains/1
    def show
      render json: @domain, status: :ok
    end

    # POST /domains
    def create
      @domain = Domain.new(domain_params)

      if @domain.save
        render json: @domain, status: :created, location: v2_domain_url(@domain)
      else
        render json: @domain.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /domains/1
    def update
      if @domain.update(domain_params)
        render json: @domain, status: 200
      else
        render json: @domain.errors, status: :unprocessable_entity
      end
    end

    # DELETE /domains/1
    def destroy
      @domain.destroy
      head 204
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_domain
      @domain = Domain.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def domain_params
      params.require(:domain).permit(:name, :quota)
    end
  end
end

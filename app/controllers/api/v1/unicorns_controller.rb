module Api
  module V1
    class UnicornsController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_unicorn, only: [:show, :update, :destroy]

      # GET /unicorns
      def index
        @unicorns = Unicorn.all

        render json: @unicorns
      end

      # GET /unicorns/1
      def show
        render json: @unicorn
      end

      # POST /unicorns
      def create
        @unicorn = Unicorn.new(unicorn_params)
        @user = User.find(@unicorn.user_id)
        @user.update(demand: false)

        if @unicorn.save
        render json: @unicorn, status: :created
        else
        render json: @unicorn.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /unicorns/1
      def update
        if @unicorn.update(unicorn_params)
        render json: @unicorn
        else
        render json: @unicorn.errors, status: :unprocessable_entity
        end
      end

      # DELETE /unicorns/1
      def destroy
        @unicorn.destroy
      end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_unicorn
          @unicorn = Unicorn.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def unicorn_params
      params.require(:unicorn).permit(:sex, :type, :color, :user_id, :unicorn_type)
      end
      end
  end
end

# frozen_string_literal: true

module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :set_project, only: %i[show update destroy]

      # GET /projects
      # @return [String] Json Response
      def index
        @projects = Current.user.projects

        render json: @projects, status: :ok
      end

      # GET /projects/<UUID>
      # @return [String] Json Response
      def show
        render json: @project
      end

      # POST /projects
      # @return [String] Json Response
      def create
        @project = Current.user.projects.new(project_params)

        if @project.save
          render json: @project, status: :created, location: api_v1_project_url(@project)
        else
          render json: @project.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /projects/<UUID>
      # @return [String] Json Response
      def update
        if @project.update(project_params)
          render json: @project
        else
          render json: @project.errors, status: :unprocessable_entity
        end
      end

      # DELETE /projects/<UUID>
      # @return [String] Empty Body
      def destroy
        @project.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions
      # @return [[]]
      def set_project
        @project = Current.user.projects.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through
      # @return [ActionController::Parameters]
      def project_params
        params.require(:project).permit(:name)
      end
    end
  end
end

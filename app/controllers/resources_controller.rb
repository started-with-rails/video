class ResourcesController < ApplicationController
    before_action :authenticate_user!
    def new
        @resource = current_user.resources.build
    end

    def create
        @resource = Resource.new(resource_params)
        respond_to do |format|
            if @resource.save
                format.html { redirect_to @resource, notice: 'resource was successfully created.' }
                format.json { render :show, status: :created, location: @resource }
            else
                format.html { render :new }
                format.json { render json: @resource.errors, status: :unprocessable_entity }
            end
        end
    end


    private

    def resource_params
        params.require(:resource).permit(:title,:slug,:allow_download,:auto_play,:excerpt,:description,:type,:embed_code,:url,:user_id,:status,:featured,:thumbnail_option, category_ids: [])
    end
end

class ResourcesController < ApplicationController
    before_action :authenticate_user!
    def new
        @resource = Resource.new
    end

		def create
        @resource =  current_user.resources.build(resource_params)
        respond_to do |format|
            if @resource.save
                format.html { redirect_to root_path, notice: 'resource was successfully created.' }
                format.json { render :show, status: :created, location: @resource }
            else
								format.html { render :new }
                format.json { render json: @resource.errors, status: :unprocessable_entity }
            end
        end
    end


    private

    def resource_params
        params.require(:resource).permit(:title,:slug,:allow_download,:auto_play,:excerpt,:description,:resource_type, :resource_url, :accepted_terms_and_conditions,:embed_code,:user_id,:status,:featured,:thumbnail_option,:source_file, category_ids: [])
    end
end

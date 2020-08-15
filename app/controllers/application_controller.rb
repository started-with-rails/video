class ApplicationController < ActionController::Base
    include BreadCrumbs
    before_action :set_action_cable_identifier
    private

    def set_action_cable_identifier
      cookies.encrypted[:user_id] = current_user&.id
    end
end

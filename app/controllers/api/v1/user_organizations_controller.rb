module Api::V1
  class UserOrganizationsController < ApplicationController

    def create

    end

    def invite_users
      @user ||= User.find_by_email(params[:email])
    rescue ActiveRecord::RecordNotFound => e
      raise (
        ExceptionHandler::UserNotFound,
        ("#{Message.user_not_found} #{e.message}")
      )
    end
  end
end

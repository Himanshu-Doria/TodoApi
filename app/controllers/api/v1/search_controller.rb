module Api
    module V1
        class SearchController < Api::ApiController
            before_action :logged_in? ,only: [:search]
            def search
                if @user.nil?
                    return
                end
                if params[:search]
                    @users = User.search(params[:search], load: true)
                    render json: @users, status: 200, each_serializer: UserSafeParamsSerializer, root: :user, result: "Found #{@users.size} result(s)"
                else
                    error("Bad Request",400)
                end
            end

        end
    end
end

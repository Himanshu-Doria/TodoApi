module Api
    module V1   
        class BrowseController < Api::ApiController
            respond_to :json
            before_action :logged_in?, only: [:users,:info]
            def users
                if @user.nil?
                    return
                end
                users = User.all
                render json: users, each_serializer: UserSafeParamsSerializer, root: :user, status:200, result: "Success"
            end

            def info
                if @user.nil?
                    return
                end
                user = User.find_by(id: params[:id])
                if user
                    render json: user, serializer: UserSafeParamsSerializer, root: :user, status: 200,result: "Success"
                else
                    error("Not Found",404)
                end
            end
        end
    end
end

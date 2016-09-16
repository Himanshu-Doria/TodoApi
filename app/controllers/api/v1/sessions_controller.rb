module Api
    module V1
        class SessionsController < Api::ApiController
            def sign_in
                unless request.headers['X-User-id'].nil? || request.headers['X-Authentication-Token'].nil?
                    user = find_user(request.headers['X-User-id'].to_i,request.headers['X-Authentication-Token'])
                    if user.nil?
                        return
                    end
                    update_time_stamp(user)
                    user.save
                    json_response(user,200,"Success",UserSerializer,"user")
                else
                    user = User.find_by(email: params[:session][:email].downcase)
                    if user && user.authenticate(params[:session][:password])
                        update_remember_token(user)
                        update_time_stamp(user)
                        user.save
                        json_response(user,200,"Logged In Succesfully",UserSerializer,"user")
                    else
                        error("Invalid email/password",401)
                    end
                end
            end

            def sign_out
                unless request.headers['X-User-id'].nil? || request.headers['X-Authentication-Token'].nil?
                    user = find_user(request.headers['X-User-id'].to_i,request.headers['X-Authentication-Token'])
                    if user.nil?
                        return
                    end
                    update_remember_token(user)
                    user.save
                    head 204
                else
                    error("Bad Request",400)
                end
            end
            
        end
    end
end
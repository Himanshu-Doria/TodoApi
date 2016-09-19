module Api
    module V1
        class TodosController < Api::ApiController
            respond_to :json
            before_action :logged_in?, only: [:index,:create,:destroy,:update]

            def index
                if @user.nil?
                    return
                end
                render json: @user.todos, status: 200
            end


            def create
                if @user.nil?
                    return
                end
                todo = @user.todos.create(todo_params)
                if todo.save
                    render json: todo, status: 201
                else
                    render json: {errors: todo.errors}, status: 422
                end
            end


            def update
                if @user.nil?
                    return
                end
                todo = @user.todos.find_by(id: get_todo)
                if todo.nil?
                    error("Not Found",404)
                elsif todo.update(todo_params)
                    render json: todo, status: 200
                else
                    error(todo.erros,422)
                end
            end

            def destroy
                if @user.nil?
                    return
                end
                todo = @user.todos.find_by(id: get_todo)
                if todo.nil?
                    error("Not Found",404)
                else
                    todo.destroy
                    head 204
                end
            end

            private

            def get_todo
                request.headers['X-Todo-id'].to_i
            end

            def todo_params
                params.require(:todo).permit(:content)
            end
        end
    end
end
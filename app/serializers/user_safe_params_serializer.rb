class UserSafeParamsSerializer < ActiveModel::Serializer

  has_many :todos
  attributes :id, :email,:name, :age,:phone, :address,:result
  def result
    instance_options[:result]
  end 
end

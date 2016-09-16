class UserSafeParamsSerializer < ActiveModel::Serializer
  attributes :id, :email,:name, :age,:phone, :address,:result
  def result
    instance_options[:result]
  end 
end

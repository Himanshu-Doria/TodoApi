class UserSerializer < ActiveModel::Serializer
  attributes :id, :remember_token, :expires_on, :result

  def result
    instance_options[:result]
  end 
end

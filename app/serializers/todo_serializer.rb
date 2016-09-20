class TodoSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_on



  def created_on
    object.created_at.strftime("%d %b %Y")
  end
end

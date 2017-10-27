class User < ApplicationRecord

  has_many :authored_polls,
    primary_key: :id
    foreign_key: :user_id
    class_name: :Poll

  

end

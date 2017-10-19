class Tagging < ApplicationRecord
  belongs_to :tag_topic,
    primary_key: :id,
    foreign_key: :topic_id,
    class_name: :TagTopic

    belongs_to :shortened_url,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: :ShortenedUrl

    
end

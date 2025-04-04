class Post < ApplicationRecord
  validates :title, :body, :summary, presence: true
  validates :published, inclusion: { in: [ false, true ] }
end

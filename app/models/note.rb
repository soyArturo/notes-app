class Note < ApplicationRecord
  validates :body, presence: true

  def self.search_by_title(keywords)
    where title: keywords
  end
end

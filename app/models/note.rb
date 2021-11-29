class Note < ApplicationRecord
  validates :title, :body, presence: true

  def self.search_by_title(keywords)
    puts keywords
    where 'title LIKE ?', "%#{keywords}%"
  end
end

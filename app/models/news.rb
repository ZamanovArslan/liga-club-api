class News < ApplicationRecord
  validates :title, :description, presence: true
end

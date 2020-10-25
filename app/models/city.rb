class City < ApplicationRecord
  has_many :badges, dependent: :nullify
  has_many :partners, dependent: :nullify
end

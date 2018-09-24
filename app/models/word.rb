class Word < ApplicationRecord
  validates :term, presence: true
end

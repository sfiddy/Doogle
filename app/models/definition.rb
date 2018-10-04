class Definition < ApplicationRecord
  belongs_to :word
  validates :word_id, presence: true
end

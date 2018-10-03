class Word < ApplicationRecord
  validates :term, presence: true
  validate :is_valid_word, on: :create
  
  @valid = true
  
  def is_valid_word
    if @valid == false
      errors.add(:term, "is not a real word")
    end
    
  end
  
  def set_valid(valid)
    @valid = valid
  end

  def get_valid
    @valid
  end
  
end
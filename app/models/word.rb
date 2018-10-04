class Word < ApplicationRecord
  has_many :definitions
  validates :term, presence: true
  validate :generate_errors, on: :create
  
  @valid = true
  
  def generate_errors
    if term.empty?
      errors.add(:term, "can't be blank")
    elsif @valid == false
      errors.add(:term, "does not exist")
    end
  end
  
  def set_valid(valid)
    @valid = valid
  end

  def get_valid
    @valid
  end
  
end
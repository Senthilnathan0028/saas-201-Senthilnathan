class Section < ApplicationRecord
  belongs_to :department
  has_many :students, dependent: :destroy
  before_save :check_capital_string

  private

  def check_capital_string
    if name != nil
      self.name = self.name.upcase
    end
  end
end

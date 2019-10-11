class Department < ApplicationRecord
  has_many :sections, dependent: :destroy
  has_many :students, through: :sections, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  before_save :check_capital_string

  private

  def check_capital_string
    if name != nil
      self.name = self.name.upcase
    end
  end
end

class Tag
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated

  field :name, type: String

  has_and_belongs_to_many :todos
  validates :name, uniqueness: true, presence: true
end
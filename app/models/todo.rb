class Todo
  include Mongoid::Document
  include Mongoid::Enum
  include Mongoid::Paranoia
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated

  paginates_per 10

  field :title, type: String
  field :description, type: String
  field :tags, type: Array, default: []
  field	:start_date, type: Date
  field :due_date, type: Date
  field :completed_on, type: Date
  enum status: [:Assigned, :Start, :Finish]
  
  has_and_belongs_to_many :tags

  validates_presence_of :title, :status
end

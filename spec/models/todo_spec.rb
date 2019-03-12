require 'rails_helper'

RSpec.describe Todo, type: :model do

  # Validations tests
  # Ensure columns title and status are present before saving
  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:status)}

end
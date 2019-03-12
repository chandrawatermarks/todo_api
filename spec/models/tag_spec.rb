require 'rails_helper'

RSpec.describe Tag, type: :model do

  # Validations tests
  # Ensure columns name is present before saving
  it {should validate_presence_of(:name)}
end
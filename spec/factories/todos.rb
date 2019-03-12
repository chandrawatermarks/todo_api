FactoryBot.define do
  factory :todo do
    title {Faker::Lorem.word}
    status {[:Assigned, :Start, :Finish].sample}
  end
end
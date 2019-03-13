FactoryBot.define do
  factory :todo do
    title {Faker::Lorem.word}
    status {[:Assigned, :Started, :Finished].sample}
  end
end
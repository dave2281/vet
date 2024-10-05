FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "Name#{n}" }
    sequence(:surname) { |n| "Surname#{n}" }
    sequence(:patronymic) { |n| "Patronymic#{n}" }
    sequence(:description) { |n| "Description#{n}" }
    sequence(:experience) { |n| "Experience#{n}" }
    sequence(:email) { |n| "Email#{n}@example.com" }
    sequence(:password) { |n| "Password#{n}" }
    role { 'admin' }
  end
end

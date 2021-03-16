FactoryBot.define do
  factory :admin do
    name
    surname
    patronymic
    email
    password
    role { 'admin' }

    trait :deleted do
      state { 'deleted' }
    end

    trait :active do
      state { 'active' }
    end

    trait :editor do
      role { 'editor' }
    end
  end
end

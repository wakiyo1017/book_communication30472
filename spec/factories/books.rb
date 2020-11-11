FactoryBot.define do
  factory :book do
    title        {Faker::Lorem.sentence}
    author       {Faker::Name.initials(number: 2)}
    impression   {Faker::Lorem.sentence}
    association :user
    
    after(:build) do |book|
      book.image.attach(io: File.open("public/images/test_image2.png"), filename: "test_image2.png")
    end
  end
end

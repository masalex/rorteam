# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :resume do |p|
    association :job
    p.description 'Description text'
    p.name 'User Name'
    p.email 'em@example.com'
    p.phone '0999999999'
  end
end
FactoryGirl.define do
  factory :user do
    firstname     "Gregory"
    lastname      "Gay"
    email         "greggay777@gmail.com"
    streetaddress "116 Double Brook Drive"
    city          "Weaverville"
    state         "NC"
    zip           "28787"
    phone         "8283379097"
    password      "secure"
    password_confirmation "secure"

    factory :admin do
      admin true
    end
  end
end

#FactoryGirl.define do
#  factory :user do
#    sequence(:firstname)  { |n| "Person #{n}" }
#    sequence(:lastname)  { |n| "Person #{n}" }
#    sequence(:email) { |n| "person_#{n}@example.com"}
#    sequence(:streetaddress)  { |n| "#{n} Example Drive" }
#    sequence(:city)  { |n| "city_#{n}" }
#    sequence(:state)  { |n| "state_#{n}" }
#    zip   "28787"
#    phone "8283379097"
#    password "secure"
#    password_confirmation "secure"
#  end
#end
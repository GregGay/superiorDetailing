FactoryGirl.define do
  factory :user do
    firstname     "Gregory"
    lastname      "Gay"
    email         "greg@example.com"
    streetaddress "116 Double Brook Drive"
    city          "Weaverville"
    state         "NC"
    zip           "28787"
    phone         "8283379097"
    password      "secure"
    password_confirmation "secure"
  end
end
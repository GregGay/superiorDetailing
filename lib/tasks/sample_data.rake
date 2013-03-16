namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(firstname: "Gregory", lastname: "Gay",
                         email: "greggay777@gmail.com",
                         streetaddress: "116 Double Brook Drive",
                         city: "Weaverville",
                         state: "NC",
                         zip: "28787",
                         phone: "8283379097",
                         password: "secure",
                         password_confirmation: "secure")
    admin.toggle!(:admin)
  end
end
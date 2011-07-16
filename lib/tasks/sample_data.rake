require 'faker/name'

namespace :db do
  desc "Fill Database With Sample Data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    Employee.create!(
      :name => "lutzdmin",
      :email => "admin@lutzplumbingonline.com",
      :password => "admin29",
      :password_confirmation => "admin29"
    )
    Client.create!(
      :first_name => "Jimmy",
      :last_name => "Jimmerson",
      :email => "jj@example.com",
      :phone => 4224954399
    )
    25.times do |n|
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      phone = Faker::PhoneNumber.phone_number
      email = "jimmy-#{n+1}@example.com"
      Client.create!(
        :first_name => first_name,
        :last_name => last_name,
        :email => email,
        :phone => phone
      )
    end

  end
end


# == Schema Information
#
# Table name: client_addrs
#
#  id         :integer         not null, primary key
#  street     :string(255)
#  city       :string(255)
#  state      :string(255)
#  zip        :integer
#  client_id  :integer
#  created_at :datetime
#  updated_at :datetime
#  title      :string(255)
#

namespace :db do
  desc "Fill Database With Sample Data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = Employee.create!(
      :name => "lutzdmin",
      :email => "admin@lutzplumbingonline.com",
      :password => "admin29",
      :password_confirmation => "admin29"
    )
    admin.toggle!(:admin)
    Client.create!(
      :first_name => "Jimmy",
      :last_name => "Jimmerson",
      :email => "jj@example.com",
      :phone => 4224954399
    )
    25.times do |n|
      first_name = "Jimmy"
      last_name = "#{n+1}"
      phone = rand(9999999999).to_s.center(10,rand(9).to_s)
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
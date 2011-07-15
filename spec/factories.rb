Factory.define :employee do |employee|
  employee.name             "Jimmy Admin"
  employee.email                  "jimmyadmin@example.com"
  employee.password                 "foobar"
  employee.password_confirmation    "foobar"
end

Factory.sequence :email do |n|
  "employee-#{n}@example.com"
end

Factory.define :client do |client|
  client.first_name             "Jimmy"
  client.last_name              "Smiles"
  client.email                  "jimmysmiles@example.com"
  client.phone                  "0123456789"
end

Factory.sequence :email do |n|
  "client-#{n}@example.com"
end
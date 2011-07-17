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

Factory.sequence :last_name do |n|
  "#{n}"
end

Factory.sequence :email do |n|
  "client-#{n}@example.com"
end

Factory.sequence :phone do |n|
  rnum = rand(999999999).to_s.center(9,rand(9).to_s)
  "#{n}#{rnum}"
end

Factory.define :client_addr do |client_addr|
  client_addr.title "Primary"
  client_addr.street "Street"
  client_addr.city "City"
  client_addr.state "State"
  client_addr.zip 12345
  client_addr.association :client
end

Factory.define :quote do |quote|
  quote.title "Incline"
  quote.notes "Will need to purchase a shit ton of dirt.."
  quote.association :client
end

Factory.sequence :title do |n|
  "Incline #{n}"
end

Factory.define :quote_item do |quote_item|
  quote_item.item_num "K23-B"
  quote_item.description "Rocks"
  quote_item.qty 2
  quote_item.price 24.99
  quote_item.notes "Requires some dirt"
  quote_item.association :quote
end

Factory.sequence :item_num do |n|
  "KBQ-#{n}"
end
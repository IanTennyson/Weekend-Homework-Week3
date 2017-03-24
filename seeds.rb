require('pry')
require_relative('models/customers')
require_relative('models/films')
require_relative('models/tickets')

Customer.delete_all()
customer1 = Customer.new({"name" => "Ian Tennyson", "funds" => "50"})
customer1.save()
#customer1.delete()
customer2 = Customer.new({"name" => "Nicola Hopper", "funds" => "100"})
customer2.save()

Film.delete_all()
film1 = Film.new({"title" => "Logan", "price" => "10"})
film1.save()
#film1.delete()
film2 = Film.new({"title" => "Fight Club", "price" => "10"})
film2.save()

Ticket.delete_all()
ticket1 = Ticket.new({"customer_id" => customer1.id, "film_id" => film1.id})
ticket1.save()
#ticket1.delete()
ticket2 = Ticket.new({"customer_id" => customer2.id, "film_id" => film1.id})
ticket2.save()
ticket3 = Ticket.new({"customer_id" => customer2.id, "film_id" => film2.id})
ticket3.save()

binding.pry
nil
require('pry')
require_relative('models/customers')
require_relative('models/films')
require_relative('models/tickets')
require_relative('models/screenings')

Customer.delete_all()
customer1 = Customer.new({"name" => "Ian Tennyson", "funds" => "50"})
customer1.save()
#customer1.delete()
customer2 = Customer.new({"name" => "Nicola Hopper", "funds" => "100"})
customer2.save()
customer3 = Customer.new({"name" => "Dan Morgan", "funds" => "80"})
customer3.save()

Film.delete_all()
film1 = Film.new({"title" => "Logan", "price" => "10"})
film1.save()
#film1.delete()
film2 = Film.new({"title" => "Fight Club", "price" => "5"})
film2.save()
film3 = Film.new({"title" => "The Lord Of The Rings", "price" => "3"})
film3.save()

Ticket.delete_all()
ticket1 = Ticket.new({"customer_id" => customer1.id, "film_id" => film1.id})
ticket1.save()
#ticket1.delete()
ticket2 = Ticket.new({"customer_id" => customer1.id, "film_id" => film2.id})
ticket2.save()

ticket3 = Ticket.new({"customer_id" => customer2.id, "film_id" => film1.id})
ticket3.save()
ticket4 = Ticket.new({"customer_id" => customer2.id, "film_id" => film2.id})
ticket4.save()

ticket5 = Ticket.new({"customer_id" => customer3.id, "film_id" => film1.id})
ticket5.save()

Screening.delete_all()
screening1 = Screening.new({"time" => "14:00", "film_id" => film1.id})
screening1.save()
#screening1.delete()
screening2 = Screening.new({"time" => "16:00", "film_id" => film2.id})
screening2.save()
screening3 = Screening.new({"time" => "18:00", "film_id" => film3.id})
screening3.save()
screening4 = Screening.new({"time" => "20:00", "film_id" => film1.id})
screening4.save()


binding.pry
nil


























#What does this mean?
#RuntimeError: You want to finish 4 frames, but stack size is only 1
require_relative('../db/sql_runner')

class Ticket

attr_reader :id

  def initialize(options)
    @id = options['id'].to_i
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id']
  end

  def save()
      sql = "INSERT INTO tickets (customer_id, film_id) VALUES (#{@customer_id}, #{@film_id}) RETURNING *"
      ticket = SqlRunner.run(sql).first()
      @id = ticket["id"]
      pay_for_tic()
  end

  def delete
    sql = "DELETE FROM tickets WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def customer
    sql = "SELECT * FROM customers WHERE id = #{@customer_id}"
    customer = SqlRunner.run(sql).first()
    return Customer.new(customer)
  end

  def film
    sql = "SELECT * FROM films WHERE id = #{@film_id}"
    film = SqlRunner.run(sql).first()
    return Film.new(film)
  end

#The funds of the customer who owns the ticket. Returned as an int
  def funds()
    sql = "SELECT customers.funds FROM customers WHERE id = #{@customer_id}"
      funds = SqlRunner.run(sql).first().fetch("funds").to_i
      return funds
  end

#The price of the ticket from the films. Returned as an int
  def price()
    sql = "SELECT films.price FROM films WHERE id = #{@film_id}"
    price = SqlRunner.run(sql).first().fetch("price").to_i
    return price
  end

#subtracts the price of the film from the funds and calls UPDATE to insert the new value.
  def pay_for_tic()
    result = funds() - price()
    updated_funds = result.to_s
    update_funds(updated_funds)
  end

  def update_funds(updated_customer_funds)
    sql = "UPDATE customers SET (funds) = (#{updated_customer_funds}) WHERE id = #{@customer_id}"
    SqlRunner.run(sql)
  end





  def self.delete_all()
    sql = "DELETE FROM tickets"
    Ticket.map_items(sql)
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    return Ticket.map_items(sql)
  end

  def self.map_items(sql)
    tickets = SqlRunner.run(sql)
    return tickets.map { |ticket| Ticket.new(ticket) }
  end

end
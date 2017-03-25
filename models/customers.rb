require_relative('../db/sql_runner')
require_relative('tickets')
require_relative('films')

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ('#{@name}', #{@funds}) RETURNING *"
    customer = SqlRunner.run(sql).first()
    @id = customer["id"].to_i
    
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ('#{@name}', #{@funds}) WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def delete
    sql = "DELETE FROM customers WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def films()
    sql = "SELECT films.* FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE customer_id = #{@id}"
    return Film.map_items(sql)
  end

  def num_of_tickets()
    sql = "SELECT tickets.film_id FROM tickets WHERE customer_id = #{@id}"
    result = SqlRunner.run(sql).to_a
    return result.length
  end




  





  def self.delete_all()
    sql = "DELETE FROM customers"
    Customer.map_items(sql)
  end

  def self.all()
    sql = "SELECT * FROM customers"
    return Customer.map_items(sql)
  end

  def self.map_items(sql)
    customers = SqlRunner.run(sql)
    return customers.map { |customer| Customer.new(customer) }
  end

end
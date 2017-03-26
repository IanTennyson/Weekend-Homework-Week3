require_relative('../db/sql_runner')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
      sql = "INSERT INTO films (title, price) VALUES ('#{@title}', #{@price}) RETURNING *"
      film = SqlRunner.run(sql).first()
      @id = film["id"].to_i
  end

  def update()
    sql = "UPDATE films SET (title, price) = ('#{@title}', #{@price}) WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM films WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def customers()
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE film_id = #{@id}"
    return Customer.map_items(sql)
  end

  def num_of_customers()
    sql = "SELECT customers FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE film_id = #{@id}"
    result = SqlRunner.run(sql).to_a
    return result.length()
  end






  def self.delete_all
    sql = "DELETE FROM films"
    Film.map_items(sql)
  end

  def self.all()
    sql = "SELECT * FROM films"
    return Film.map_items(sql)
  end

  def self.map_items(sql)
    films = SqlRunner.run(sql)
    return films.map { |film| Film.new(film) }
  end

  def self.tickets_sold_by_title()
      sql = "SELECT films.title FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE tickets.screening_id = screening_id"
      times = SqlRunner.run(sql).values().flatten()
      count_times = Hash.new 0
      times.each do |time| 
        count_times[time] += 1
      end
      return count_times
  end

end
require_relative('../db/sql_runner')


class Screening

  attr_reader :id
  attr_accessor :time

  def initialize(options)
    @id = options['id'].to_i
    @time = options['time']
  end

  def save()
    #should #{@time} have '' around it? 
    sql = "INSERT INTO screenings (time) VALUES ('#{@time}') RETURNING *"
    screening = SqlRunner.run(sql).first()
    @id = screening["id"]
  end

  def delete()
    sql = "DELETE FROM screenings WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def film()
    sql = "SELECT films.title FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE tickets.screening_id = #{@id}"
    return SqlRunner.run(sql).first().values().pop()
  end

  def time()
    sql = "SELECT screenings.time FROM screenings WHERE id = #{@id}"
    return SqlRunner.run(sql).first().values().pop()
  end








  def self.times()
    sql = "SELECT screenings.time, films.title FROM screenings INNER JOIN tickets ON screenings.id = tickets.screening_id INNER JOIN films ON films.id = tickets.film_id"
    return SqlRunner.run(sql).values().uniq()
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)  
  end

  def self.all
    sql = "SELECT * FROM screenings"
    return Screening.map_items(sql)
  end

  def self.map_items(sql)
    screenings = SqlRunner.run(sql)
    return screenings.map { |screening| Screening.new(screening) }
  end

  def self.tickets_sold_by_screening()
    sql = "SELECT screenings.time FROM screenings INNER JOIN tickets ON screenings.id = tickets.screening_id WHERE tickets.film_id = film_id"
    times = SqlRunner.run(sql).values().flatten()
    count_times = Hash.new 0
    times.each do |time| 
      count_times[time] += 1
    end
    return count_times.to_a
  end

#
  # def self.best_seller()
    
  # end

end
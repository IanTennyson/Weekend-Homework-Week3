require_relative('../db/sql_runner')


class Screening

  attr_reader :id, :film_id
  attr_accessor :time

  def initialize(options)
    @id = options['id'].to_i
    @time = options['time']
    @film_id = options['film_id']
  end

  def save()
    #should #{@time} have '' around it? 
    sql = "INSERT INTO screenings (time, film_id) VALUES ('#{@time}', #{@film_id}) RETURNING *"
    screening = SqlRunner.run(sql).first()
    @id = screening["id"]
  end

  def delete()
    sql = "DELETE FROM screenings WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def film()
    sql = "SELECT * FROM films where id = #{@film_id}"
    return SqlRunner.run(sql).first().fetch("title")
  end




  def self.times()
    sql = "SELECT screenings.time, films.title, films.price FROM screenings INNER JOIN films ON screenings.film_id = films.id;"
    times = SqlRunner.run(sql)
    times.map { |time| time_array << Screening.new(time)}
    return time_array
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

end
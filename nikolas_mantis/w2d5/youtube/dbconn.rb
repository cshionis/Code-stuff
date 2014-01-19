require 'pg'

module DBconn

  public 

  def run_sql(sql)
    conn = PG.connect(dbname: 'youtube', host: 'localhost')

    begin
      result = conn.exec(sql)
    ensure
      conn.close
    end

    result
  end

  def run_sql_args(values, operation)

    conn = PG.connect(dbname: 'youtube', host: 'localhost')

    begin
      case operation
      when 'i'
        result = insert(values, conn)
      when 'u'
        result = update(values, conn)
      end
    ensure
      conn.close
    end

    result
  end

  def insert(values_arr, conn)
    conn.prepare('statement1', 'INSERT INTO videos (title, genre, url, description) VALUES ($1, $2, $3, $4)')
    conn.exec_prepared('statement1', values_arr)
  end

  def update(values_arr, conn)
    conn.prepare('statement1', 'UPDATE videos SET title=$1, genre=$2, url=$3, description=$4  WHERE id=$5')
    conn.exec_prepared('statement1', values_arr)
  end

end



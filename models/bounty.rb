require ('pg')

class Bounty
attr_reader :id
attr_accessor :name, :danger_level, :bounty_value, :fave_weapon

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @danger_level = options['danger_level']
    @bounty_value = options['bounty_value'].to_i
    @fave_weapon = options['fave_weapon']
  end

  def save
    db = PG.connect( { dbname: 'bounty_hunters', host: 'localhost' } )
    sql = " INSERT INTO bounties
    (
      name,
      danger_level,
      bounty_value,
      fave_weapon
    )
    VALUES
    (
      $1, $2, $3, $4
      ) RETURNING *;"
    values = [@name, @danger_level, @bounty_value, @fave_weapon]
    db.prepare("save", sql)
    array_of_hashes = db.exec_prepared("save", values)
    @id = array_of_hashes[0]['id'].to_i
    db.close
  end

  def Bounty.all
    db = PG.connect( {dbname: 'bounty_hunters', host: 'localhost'})
    sql = "SELECT * FROM bounties;"
    db.prepare("all", sql)
    all_bounties = db.exec_prepared("all")
    db.close
    return all_bounties.map { |hash| Bounty.new(hash) }
  end

  def update
    db = PG.connect( { dbname: 'bounty_hunters', host: 'localhost' } )
    sql = "UPDATE bounties SET
    (
      name,
      danger_level,
      bounty_value,
      fave_weapon
    ) =
    (
      $1, $2, $3, $4
      )
      WHERE id = $5;"
    values = [@name, @danger_level, @bounty_value, @fave_weapon, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close
  end

  def Bounty.delete_all
    db = PG.connect( {dbname: 'bounty_hunters', host: 'localhost'})
    sql = "DELETE FROM bounties;"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close
  end

  def delete
    db = PG.connect( { dbname: 'bounty_hunters', host: 'localhost' } )
    sql = "DELETE FROM bounties WHERE id = $1;"
    values = [@id]
    db.prepare("delete", sql)
    db.exec_prepared("delete", values)
    db.close
  end

  def Bounty.find_by_name(name)
    db = PG.connect( {dbname: 'bounty_hunters', host: 'localhost'})
    sql = "SELECT name FROM bounties WHERE name = $1;"
    values = [name]
    db.prepare("find", sql)
    hash = db.exec_prepared("find", values)
    db.close
    bounty_hash = hash[0]
    bounty = Bounty.new(bounty)
    return bounty
  end

  def Bounty.find_by_id(id)
    db = PG.connect( {dbname: 'bounty_hunters', host: 'localhost'})
    sql = "SELECT id FROM bounties WHERE id = $1;"
    values = [id]
    db.prepare("find", sql)
    hash = db.exec_prepared("find", values)
    db.close
    bounty_hash = hash[0]
    bounty = Bounty.new(bounty)
    return bounty
  end


end

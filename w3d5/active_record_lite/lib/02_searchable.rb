require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    where = []
    vals = []
    params.each do |k,v|
      where << "#{k} = ?"
      vals << v
    end
    where = where.join("AND ")
    data = DBConnection.execute(<<-SQL, *vals)
      SELECT *
      FROM #{self.table_name}
      WHERE #{where}
    SQL

    self.parse_all(data)
  end
end

class SQLObject
  # Mixin Searchable here...
  extend Searchable
end

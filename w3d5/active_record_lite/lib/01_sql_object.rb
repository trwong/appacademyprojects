require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    if @data
      @data
    else
      data = DBConnection.execute2(<<-SQL)
        SELECT *
        FROM #{self.table_name}
      SQL
      @data = data.first.map(&:to_sym)
    end
  end

  def self.finalize!
    self.columns
    @data.each do |col|
      define_method(col) do
        self.attributes[col]
      end

      define_method("#{col}=") do |val|
        self.attributes[col] = val
      end
    end
  end

  def self.table_name=(table_name)
    @table = table_name
  end

  def self.table_name
    @table ||= self.to_s.underscore.pluralize
  end

  def self.all
    data = DBConnection.execute(<<-SQL)
      SELECT *
      FROM #{self.table_name}
    SQL
    self.parse_all(data)
  end

  def self.parse_all(results)
    arr = []
    results.each do |result|
      arr << self.new(result)
    end
    arr
  end

  def self.find(id)
    data = DBConnection.execute(<<-SQL, id)
      SELECT *
      FROM #{self.table_name}
      WHERE id = ?
    SQL
    return nil if data.empty?
    self.new(data.first)
  end

  def initialize(params = {})
    params.keys.each do |k|
      attr_name = k.to_sym
      unless self.class.columns.include?(attr_name)
        raise "unknown attribute '#{attr_name}'"
      end
      self.send("#{attr_name}=", params[k])
    end
  end

  def attributes
    @attributes ||= {}
    @attributes
  end

  def attribute_values
    arr = []
    @attributes.each { |el| arr << el.last }
    arr
  end

  def insert
    col = self.class.columns

    col = col.drop(1)
    # col.delete(:id)
    col_names = col.join(", ")
    question_marks = (["?"] * col.count).join(", ")


    DBConnection.execute(<<-SQL, *attribute_values)
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks})
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    set = self.class.columns.drop(1).map { |col| "#{col} = ?" }.join(", ")
    attr_vals = attribute_values.drop(1)
    DBConnection.execute(<<-SQL, *attr_vals)
      UPDATE
        #{self.class.table_name}
      SET
        #{set}
      WHERE
        id = #{self.id}
    SQL
  end

  def save
    self.id ? update : insert
  end
end

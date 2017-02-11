require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  attr_accessor :table_name, :columns, :attributes
  def self.columns
    return @columns if @columns
    arr = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        "#{self.table_name}"
    SQL
    @columns = arr[0].map(&:to_sym)
  end

  def self.finalize!
    columns = self.columns
    columns.each do |col|
      define_method("#{col}") do
        self.attributes
        @attributes[col]
      end
      define_method("#{col}=") do |val|
        self.attributes
        @attributes[col] = val
      end
    end
  end

  def self.table_name=(table_name)
    # ...
    @table_name = table_name
  end

  def self.table_name
    # ...
    v = @table_name
    if v.nil?
      s = self.name
      s = SQLObject.make_table_name(s)
      v = instance_variable_set("@table_name", s)
    end
    v
  end


  def self.all
    table_name = self.table_name
    arr = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        "#{table_name}"
    SQL
    self.parse_all(arr)
  end

  def self.parse_all(results)
    results = SQLObject.arr_hashes_sym(results)
    arr = [ ]
    results.each do |hash|
      arr << self.new(hash)
    end
    arr
  end

  def self.find(id)
    arr = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        "#{self.table_name}"
      WHERE
        id = "#{id}"
    SQL
    arr_hash = SQLObject.arr_hashes_sym(arr)
    return self.new(arr_hash[0]) if !arr_hash.empty?
    nil
  end

  def initialize(params = {})
    columns = self.class.columns
    self.class.finalize!
    params.keys.each do |key|
      raise "unknown attribute '#{key}'" unless columns.include?(key)
    end
    params.keys.each do |key|
      self.send("#{key}=", params[key],)
    end

  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    @attributes.values
  end

  def insert
    values = self.attribute_values
    quest = "(" + (["?"] * values.length).join(",") + ")"
    cols = @attributes.keys.join(",")
    cols = " (" + cols + ")"
    table_name = self.class.table_name
    DBConnection.execute(<<-SQL, *values)
      INSERT INTO
      #{table_name} #{cols}
      VALUES
        #{quest}
    SQL
    self.id = DBConnection.last_insert_row_id
  end

  def update
    values = self.attribute_values[1..-1]
    quest = [ ]
    @attributes.keys.map {|key| quest << "#{key} = ?"}
    quest = " " + quest[1..-1].join(", ")
    table_name = self.class.table_name
    DBConnection.execute(<<-SQL, *values)
      UPDATE
        #{table_name}
      SET
        #{quest}
      WHERE
        id = #{self.id}
    SQL
  end

  def save
    if self.id == nil
      self.insert
    else
      self.update
    end
  end

  private

  def self.arr_hashes_sym(arr)
    arr1 = [ ]
    arr.each do |hash|
      arr1 << SQLObject.change_hash(hash)
    end
    arr1
  end

  def self.change_hash(hash)
    Hash[hash.map{ |k, v| [k.to_sym, v] }]
  end

  def self.make_table_name(string)
    arr = string.split("")
    arr1 = [ ]
    i = 1
    s = arr[0].dup.downcase
    while i < arr.length
      if arr[i] >= 'a'
        s += arr[i]
      else
        arr1.push(s)
        s = arr[i].dup.downcase if i < arr.length
      end
      i += 1
    end
    arr1.push(s)
    arr1.join('_') + "s"
  end

end

require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject

  def self.columns
  
    return @columns unless @columns.nil?

    var = DBConnection.execute2(<<-SQL)
     SELECT
      *
     FROM 
      #{self.table_name}
    SQL
    
    @columns = var[0].map(&:to_sym)
    
  end

  def self.finalize!
    columns.each do |name|
      define_method(name) do
        self.attributes[name]
      end
      define_method("#{name}=") do |arg|
        self.attributes[name] = arg
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.name.tableize
  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    # ...
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end

require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    self.class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @name = name
    @options = options
  end

  def foreign_key
    @options[:foreign_key] ? @options[:foreign_key] : "#{@name}_id".to_sym
  end

  def primary_key
    @options[:primary_key] ? @options[:primary_key] : "id".to_sym
  end

  def class_name
    @options[:class_name] ? @options[:class_name] : "#{@name.singularize.underscore.camelcase}"
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @name = name
    @self_class_name = self_class_name
    @options = options
  end

  def foreign_key
    @options[:foreign_key] ? @options[:foreign_key] : "#{@self_class_name.downcase}_id".to_sym
  end

  def primary_key
    @options[:primary_key] ? @options[:primary_key] : "id".to_sym
  end

  def class_name
    @options[:class_name] ? @options[:class_name] : "#{@name.singularize.underscore.camelcase}"
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name.to_s, options)
    define_method(name) do
      foreign_key = self.send(options.foreign_key)
      options.model_class.where(options.primary_key => foreign_key).first
    end
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name.to_s, self.to_s, options)
    define_method(name) do
      primary_key = self.send(options.primary_key)
      options.model_class.where(options.foreign_key => primary_key)
    end
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
  end
end

class SQLObject
  # Mixin Associatable here...
  extend Associatable
end

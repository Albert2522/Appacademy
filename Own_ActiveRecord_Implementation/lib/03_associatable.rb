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
    @class_name.constantize
  end

  def table_name
    @class_name.downcase.underscore + "s"
  end

  def setup_attr(hash)
    @foreign_key = hash[:foreign_key]
    @primary_key = hash[:primary_key]
    @class_name = hash[:class_name]
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    hash = {}
    hash[:foreign_key] = "#{name}_id".to_sym if options[:foreign_key] == nil
    hash[:primary_key] = "id".to_sym if options[:primary_key] == nil
    hash[:class_name] = name.to_s.underscore.singularize.camelcase if options[:class_name] == nil
    hash = hash.merge(options)
    setup_attr(hash)
  end


end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    hash = {}
    hash[:foreign_key] = "#{self_class_name.downcase}_id".to_sym if options[:foreign_key] == nil
    hash[:primary_key] = "id".to_sym if options[:primary_key] == nil
    hash[:class_name] = name.to_s.underscore.singularize.camelcase if options[:class_name] == nil
    hash = hash.merge(options)
    setup_attr(hash)
  end

end

module Associatable
  attr_accessor :assoc_options
  def belongs_to(name, options = {})
    self.assoc_options
    @assoc_options[name.to_sym] = BelongsToOptions.new(name, options)
    options = @assoc_options[name.to_sym]
    define_method(name) do
      fk = self.send(options.foreign_key.to_s)
      hash = {}
      hash[:id] = fk
      options.model_class.where(hash).first
    end
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name, self.name ,options)
    define_method(name) do
      id = self.id
      fk = options.foreign_key
      hash = { }
      hash[fk] = id
      options.model_class.where(hash)
    end
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
    @assoc_options ||={ }
  end
end

class SQLObject
  extend Searchable
  extend Associatable
end

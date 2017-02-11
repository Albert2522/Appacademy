require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    define_method(name) do
      id = self.id
      through_options = self.class.assoc_options[through_name]
      fk =  through_options.foreign_key
      id1 = self.attributes[fk]
      el1 =  through_options.model_class.where(id: id1)
      source_options = through_options.model_class.assoc_options[source_name]
      fk = source_options.foreign_key
      id1 = el1[0].attributes[fk]
      source_options.model_class.where(id: id1)[0]
    end
  end
end

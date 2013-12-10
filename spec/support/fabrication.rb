require 'fabrication'

# Patch `attributes_for` to serve slugs instead of IDs
class Fabrication::Generator::Base
  def to_hash(attributes=[], callbacks=[])
    process_attributes(attributes)
    Fabrication::Support.hash_class.new.tap do |hash|
      _attributes.map do |name, value|
        if value && value.respond_to?(:slug)
          hash["#{name}_id"] = value.slug
        else
          hash[name] = value
        end
      end
    end
  end
end

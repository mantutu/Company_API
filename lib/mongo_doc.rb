module Mongoid::Document

  def to_hash
    hash = {'id' => self.id.to_s}
    for name, field in self.class.fields
      if not name.end_with?("_id")
        if self.has_attribute?(name)
          value = self[field.name]
          hash.store name, value if not value.nil?
        end
      end
    end
    hash
  end

end

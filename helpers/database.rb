helpers do

  def generate_query(conditions, skip = [])
    condition = {}
    for field_op, value in conditions
      field, operator = field_op.split('.')
      operator = 'eq' if operator.nil?
      if skip.include?(field)
        next
      end
      case operator
      when 'eq'
        if value.to_s.empty?
          condition[field.to_sym.in] = [nil, '']
        else
          condition[field] = value
        end
      when 'regex'
        begin
          condition[field] = Regexp.new(value, true)
        rescue
          condition[field] = value
        end
      when 'ne'
        condition[field.to_sym.ne] = value
      when 'gt'
        condition[field.to_sym.gt] = value
      when 'lt'
        condition[field.to_sym.lt] = value
      when 'in'
        condition[field.to_sym.in] = value
      when 'nin'
        condition[field.to_sym.nin] = value
      when 'all'
        condition[field.to_sym.all] = value
      end
    end
    condition
  end

end

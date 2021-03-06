class ActiveAdmin::FilterFormBuilder
  def default_input_type(method, options = {})
    if column = column_for(method)
      case column.type.name.downcase.to_sym
      when :date, :datetime
        :date_range
      when :string, :text
        :string
      when :integer
        return :select if reflection_for(method.to_s.gsub('_id','').to_sym)
        :numeric
      when :float, :decimal
        :numeric
      end
    else # dirty but allows to create filters for hashes
      :string
    end
  end

  def column_for(method)
    @object.fields[method.to_s] if @object.respond_to?(:fields)
  end

  def reflection_for(method)
    @object.class.reflect_on_association(method) if @object.class.respond_to?(:reflect_on_association)
  end
end
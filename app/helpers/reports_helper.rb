module ReportsHelper
  def new_fields_template(f,association,options={})
    options[:object] ||= f.object.class.reflect_on_association(association).klass.new
    options[:partial] ||= association.to_s.singularize+"_fields"
    options[:template] ||= association.to_s+"_fields"
    options[:f] ||= :f

   tmpl = content_tag(:div,:id =>"#{options[:template]}") do
      tmpl = f.fields_for(association,options[:object], :child_index => "new_#{association}") do |b|
        render(:partial=>options[:partial],:locals =>{:f => b})
      end
    end
    tmpl = tmpl.gsub /(?<!\n)\n(?!\n)/, ' '
    return "<script> var #{options[:template]} = '#{tmpl.to_s}' </script>".html_safe
  end
  def add_child_button(name, association,target)
    content_tag(:spam,"<span>#{name}</span>".html_safe,
      :class => "add_child col-sm-2 btn btn-success glyphicon glyphicon-plus",
      :"data-association" => association,
      :target => target)
  end
  def remove_child_button(name)
    content_tag(:div,"<span>Remove</span>".html_safe,
      :class => "remove_child glyphicon glyphicon-minus")
  end
  
  
  def unit(typeName)
    unit = "-"
    case (typeName)
      when "Temperature"
        unit = "°C"
      when "Humidity"
        unit = "°H"
      when "Voltage"
        unit = "V"
      else
    end
  end
end

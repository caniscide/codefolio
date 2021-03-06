models = []

Dir.foreach("#{defined?(RAILS_ROOT) ? RAILS_ROOT : Rails.root}/app/models") do |model_path|
  if model_path =~ /.rb/ && model_path !~ /.rb~/
    model_title = model_path.gsub("~", "").gsub(".rb", "").titleize.gsub(" ", "")
    constant = eval model_title
    if not constant.nil? and constant.is_a? Class and constant.superclass == ActiveRecord::Base
      models << model_title unless models.include?(model_title)
    end
  end
end

models.each do |a|
  b = eval("#{a}.inspect")
  c = b.gsub("#{a}(", "").gsub(")", "").split(", ")
  rels = {:belongs_to => [], :has_one => [], :has_many => [], :has_and_belongs_to_many => []}
  
  e = eval("#{a}.reflect_on_all_associations(:belongs_to)")
    e.each { |ass| rels[:belongs_to] << ass.name.inspect.gsub(':', '') }
  e = eval("#{a}.reflect_on_all_associations(:has_one)")
    e.each { |ass| rels[:has_one] << ass.name.inspect.gsub(':', '') }
  e = eval("#{a}.reflect_on_all_associations(:has_many)")
    e.each { |ass| rels[:has_many] << ass.name.inspect.gsub(':', '') }
  e = eval("#{a}.reflect_on_all_associations(:has_and_belongs_to_many)")
    e.each { |ass| rels[:has_and_belongs_to_many] << ass.name.inspect.gsub(':', '') }

  op = ""

  op << %{===========
#{a}
  #{rels[:belongs_to].any? ? "Belongs To:" : "No Belongs To Association"}
    #{rels[:belongs_to].join("\n    ")}
  #{rels[:has_many].any? ? "Has Many:" : "No Has Many Association"}
    #{rels[:has_many].join("\n    ")}
  #{rels[:has_one].any? ? "Has One:" : "No Has One Association"}
    #{rels[:has_one].join("\n    ")}
  #{rels[:has_and_belongs_to_many].any? ? "Has And Belongs To Many:" : "No Has And Belongs To Many Association"}
    #{rels[:has_and_belongs_to_many].join("\n    ")}
===========
}.gsub("\n    \n", "\n")
  c.each { |f| op << "|* #{f}\n" }
  op << "===========\n\n"
  puts op
end; puts "done"




=begin
NOTES

Model.reflect_on_all_associations(:has_many)
:belongs_to
:has_one
:has_many
:has_and_belongs_to_many
eg:
>> Factor.reflect_on_all_associations(:has_many).each { |f| puts f.name.inspect }; puts "done"
:group_factors
:factor_clients
:invites
:groups
done
=> nil
=end

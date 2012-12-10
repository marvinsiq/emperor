##
# You can use other adapters like:
#
case Padrino.env
  when :development 
		ActiveRecord::Base.configurations[:development] = {
			:adapter   => 'postgresql',
			:database  => "emperor_development",
			:username  => 'postgres',
			:password  => 'postgres',
			:host      => 'localhost',
			:port      => 5432
		}

	when :test 
		ActiveRecord::Base.configurations[:test] = {
			:adapter   => 'postgresql',
			:database  => "emperor_test",
			:username  => 'postgres',
			:password  => 'postgres',
			:host      => 'localhost',
			:port      => 5432
		}
end


# Setup our logger
ActiveRecord::Base.logger = logger

# Include Active Record class name as root for JSON serialized output.
ActiveRecord::Base.include_root_in_json = true

# Store the full class name (including module namespace) in STI type column.
ActiveRecord::Base.store_full_sti_class = true

# Use ISO 8601 format for JSON serialized times and dates.
ActiveSupport.use_standard_json_time_format = true

# Don't escape HTML entities in JSON, leave that for the #json_escape helper.
# if you're including raw json in an HTML page.
ActiveSupport.escape_html_entities_in_json = false

# Now we can estabilish connection with our db

if Padrino.env == :production
	ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"])
else
	ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations[Padrino.env])
end

ActiveSupport::Inflector.inflections do |inflect|
  inflect.irregular 'perfil', 'perfis'
end

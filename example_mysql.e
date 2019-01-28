note
	description: "abel_mysql application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	EXAMPLE_MYSQL

inherit
	ARGUMENTS_32
	EXAMPLE_SHARED

create
	make

feature {NONE} -- Initialization

	make
			-- Set up the repository.
		local
			factory: PS_MYSQL_RELATIONAL_REPOSITORY_FACTORY
		do
			create factory.make

				-- Feel free to change the login credentials.
			factory.set_database ("abel_test")
			factory.set_user ("root")
			factory.set_password ("")

				-- manage types and handle the primary key.
				-- if not set the types are set to expanded types in the PS_REPOSITORY
				-- setup, then causes issues with some queries like update (1)
				--				update (object: ANY)
				--						-- Update `object` and all transitively referenced objects in the repository.
				--					require
				--						active: is_active
				--						no_error: not has_error
				--						supported: is_supported (object)
				--						not_expanded: not is_expanded (object.generating_type) -- (1)
				--						persistent: is_persistent (object)

			factory.manage ({ARTIST}, "id")
			factory.manage ({COUNTRY}, "id")

			repository := factory.new_repository

			test_insert_artist
			test_insert_country
			test_update_artist
			test_query_all_artist
			test_query_artist_by_country
		end

end

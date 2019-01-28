note
	description: "abel_mysql application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	EXAMPLE

inherit
	ARGUMENTS_32

create
	make

feature -- Access

	repository: PS_REPOSITORY

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

	test_insert_artist
		local
			l_mgr: ARTIST_MGR
		do
			create l_mgr.make (repository)
			l_mgr.insert ("Frank Sinatra")
			l_mgr.insert ("Charles Aznavour")
			l_mgr.insert ("Aretha Franklin")
			l_mgr.insert ("Carlos Gardel")
			l_mgr.insert ("Pedro Infante")
			l_mgr.insert ("Lucho Gatica")
			l_mgr.insert ("Luciano Pavarotti")
		end

	test_insert_country
		local
			l_mgr: COUNTRY_MGR
		do
			create l_mgr.make (repository)
			l_mgr.insert ("United States of America", "USA")
			l_mgr.insert ("FRANCE", "FRA")
			l_mgr.insert ("ITALY", "ITA")
			l_mgr.insert ("ARGENTINA", "ARG")
			l_mgr.insert ("MEXICO", "MEX")
			l_mgr.insert ("CHILE", "CHL")
		end

	test_update_artist
		local
			l_mgr: ARTIST_MGR
		do
			create l_mgr.make (repository)
			l_mgr.update ("Frank Sinatra", 1)
			l_mgr.update ("Charles Aznavour", 2)
			l_mgr.update ("Aretha Franklin", 1)
			l_mgr.update ("Carlos Gardel", 4)
			l_mgr.update ("Pedro Infante",5)
			l_mgr.update ("Lucho Gatica",6)
			l_mgr.update ("Luciano Pavarotti",3)
		end

	test_query_all_artist
		local
			l_mgr: ARTIST_MGR
		do
			create l_mgr.make (repository)
			across l_mgr.artist	as ic loop
				print (ic.item.name)
				io.put_new_line
			end
		end

	test_query_artist_by_country
		local
			l_mgr: ARTIST_MGR
		do
			create l_mgr.make (repository)
			across l_mgr.artist_by_country_id (1)as ic loop
				print (ic.item.name)
				io.put_new_line
			end
		end


end

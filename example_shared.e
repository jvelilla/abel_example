note
	description: "Summary description for {EXAMPLE_SHARED}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EXAMPLE_SHARED


feature -- Access
	repository: PS_REPOSITORY

feature -- DB test cases	

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

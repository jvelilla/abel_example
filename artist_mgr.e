note
	description: "Summary description for {ARTIST_MGR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ARTIST_MGR

create

	make

feature {NONE} -- Initializatiojn

	make (a_repository: PS_REPOSITORY)
		do
			repository := a_repository
		end

feature -- Access

	repository: PS_REPOSITORY

	last_generated_id: INTEGER

feature -- DB actions

	insert (a_name: READABLE_STRING_GENERAL)
			-- Insert a new artist
		local
			l_artist: ARTIST
			transaction: PS_TRANSACTION
		do
			create l_artist.make (a_name)

			transaction := repository.new_transaction

			if not transaction.has_error then
					-- The next statement will be an insert in any case.
				transaction.insert (l_artist)
			end

				-- The generated ID is now stored in `l_artist'
			last_generated_id := l_artist.id

				-- Cleanup and error handling.
			if not transaction.has_error then
				transaction.commit
			end

			if transaction.has_error then
				print ("An error occurred.%N")
			end
		end


	update (a_name: READABLE_STRING_32; id: like {COUNTRY}.id)
			-- Update an existing customer.
		local
			factory: PS_CRITERION_FACTORY
			query: PS_QUERY [ARTIST]
			transaction: PS_TRANSACTION
		do
			create factory
			 --	create query.make
			 -- query.set_criterion (factory ("name", "=", a_name ))
			 -- If the ARTIST.name feature is STRING_32
			 -- the argument `a_name` is STRING then ABEL raise an exception
			 -- PS_QUERY
			 -- PS_CRITERION.can_handle_type (type: TYPE [detachable ANY]): BOOLEAN
--			create query.make_with_criterion ((create {PS_CRITERION_FACTORY}).new_predefined ("name", {PS_CRITERION_FACTORY}.equals, a_name))
			create query.make
			query.set_criterion (factory ("name", "=", a_name))

			transaction := repository.new_transaction

			if not transaction.has_error then
				transaction.execute_query (query)
			end

			across
				query as cursor
			loop
				cursor.item.set_country_id (id)
					-- It is possible to call update.
				transaction.update (cursor.item)
			end

				-- Cleanup and error handling
			query.close
			if not transaction.has_error then
				transaction.commit
			end
			if transaction.has_error then
				print ("An error occurred!%N")
			end
		end

	artist: LIST [ARTIST]
			-- All artist
		local
			query: PS_QUERY [ARTIST]
		do
			create query.make
			repository.execute_query (query)
				-- ABEL generated SQL query `SELECT name, id, country_id FROM artist`
			create {ARRAYED_LIST [ARTIST]} Result.make (5)
			across
				query as cursor
			loop
				Result.force (cursor.item)
			end

			if query.has_error then
				print ("An error occurred!%N")
			end

			query.close
		end

	artist_by_country_id (a_country_id: like {COUNTRY}.id): LIST [ARTIST]
			-- All artist
		local
			query: PS_QUERY [ARTIST]
		do
			create query.make_with_criterion ((create {PS_CRITERION_FACTORY}).new_predefined ("country_id", {PS_CRITERION_FACTORY}.equals, a_country_id))
			repository.execute_query (query)
				-- Abel Generated Query PS_MYSQL_CONNECTION.execute_sql
				-- SELECT name, id, country_id FROM artist WHERE country_id = 1
			create {ARRAYED_LIST [ARTIST]} Result.make (5)
			across
				query as cursor
			loop
				Result.force (cursor.item)
			end

			if query.has_error then
				print ("An error occurred!%N")
			end

			query.close
		end


end

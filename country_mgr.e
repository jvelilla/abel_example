note
	description: "Summary description for {COUNTRY_MGR}."
	date: "$Date$"
	revision: "$Revision$"

class
	COUNTRY_MGR

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

	insert (a_name: STRING; a_code: STRING)
			-- Insert a new artist
		local
			l_country: COUNTRY
			transaction: PS_TRANSACTION
		do
			create l_country.make (a_name, a_code)

			transaction := repository.new_transaction

			if not transaction.has_error then
					-- The next statement will be an insert in any case.
				transaction.insert (l_country)
			end

				-- The generated ID is now stored in `l_country'
			last_generated_id := l_country.id

				-- Cleanup and error handling.
			if not transaction.has_error then
				transaction.commit
			end

			if transaction.has_error then
				print ("An error occurred.%N")
			end
		end


end


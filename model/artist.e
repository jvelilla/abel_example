note
	description: "Object Representing an Artist"
	date: "$Date$"
	revision: "$Revision$"

class
	ARTIST

create
	make,
	make_with_country

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_GENERAL)
			-- Initialization for `Current'.
		do
			set_name (a_name)
		end

	make_with_country (a_name: READABLE_STRING_GENERAL; a_country_id: like {COUNTRY}.id)
			-- Initialization for `Current'.
		do
			set_name (a_name)
		end

feature -- Access

	id: INTEGER
		-- The unique ID.

	name: STRING_32
		-- The artist name.

	country_id: INTEGER
		-- The artist country id.

feature -- Element change

	set_name (a_name: READABLE_STRING_GENERAL)
			-- Set `name` with `a_bame`.
		do
			create name.make_from_string_general (a_name)
		ensure
			name_set: name.same_string_general (a_name)
		end

	set_id (a_id: like id)
			-- Set `id` like `a_id`.
		do
			id := a_id
		ensure
			id_set: id = a_id
		end

	set_country_id (a_country_id: like country_id)
			-- Set `country_id` with `a_country_id`.
		do
			country_id := a_country_id
		ensure
			country_id_set: country_id = a_country_id
		end

end

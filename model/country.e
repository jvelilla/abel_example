note
	description: "Object Representing a Country"
	date: "$Date$"
	revision: "$Revision$"

class
	COUNTRY

create
	make

feature {NONE} -- Initialization

	make (a_name: like name; a_isocode: like isocode)
			-- Initialization for `Current'.
		do
			set_name (a_name)
			set_isocode (a_isocode)
		end

feature -- Access

	id: INTEGER
		-- The unique ID.

	name: STRING
		-- The country name

	isocode: STRING
		-- The country's use code

feature -- Element change

	set_name (a_name: like name)
			-- Set `name` with `a_bame`.
		do
			name := a_name
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

	set_isocode (a_code: like isocode)
			-- Set `isocode` with `a_code`.
		require
			valid_length: a_code.count = 3
		do
			isocode := a_code
		ensure
			isocode_set: isocode.same_string_general (a_code)
		end

end

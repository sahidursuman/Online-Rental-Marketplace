module ApplicationHelper

	# Returns the full title on a per-page basis.
	def full_title(page_title = '')
		base_title = "Armrack"
		if page_title.empty?
			base_title						# Implicit return
		else
			page_title + " | " + base_title
		end
	end
end

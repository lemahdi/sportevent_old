module ApplicationHelper

	# Returns the full title on a per-page basis
	def full_title(page_title)
		base_title = "La Yolette Parisenne"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

	# Overwrite will_paginate to specify previous and next labels in french
	def will_paginate_fr(list)
		will_paginate list, previous_label: "Précédent", next_label: "Suivant"
	end
end

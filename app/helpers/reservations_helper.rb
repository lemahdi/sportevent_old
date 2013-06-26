module ReservationsHelper
	
	def aviron_types
		Aviron.uniq(:nbplaces).asc("nbplaces").map do |aviron|
			[aviron.description, aviron.id]
		end
	end

	def creneau_times
		creneaux = Creneau.asc("debut")
		simple_double = creneaux.map do |creneau|
			["#{creneau.debut.strftime('%H:%M')}-#{creneau.fin.strftime('%H:%M')}",
			creneau.id] if creneau.fin-creneau.debut == 45.minutes
		end.select { |c| c }
		yolette = creneaux.map do |creneau|
			["#{creneau.debut.strftime('%H:%M')}-#{creneau.fin.strftime('%H:%M')}",
			creneau.id] if creneau.fin-creneau.debut == 1.hour
		end.select { |c| c }

		[["--- horaires simple et double ---", nil]] + simple_double + [["--- horaires yolette ---", nil]] + yolette
	end

	def display_creneau(creneau)
		"#{creneau.debut.strftime('%H:%M')}-#{creneau.fin.strftime('%H:%M')}"
	end

	def changed_reservation?(reservation)
		reservation.id == flash[:changed_reservation]
	end

	def equipage(reservation)
		reservation.users.map do |user|
      user.prenom
    end.join(", ")
	end

	def empty_place?(reservation)
		reservation.aviron.nbplaces > reservation.users.size
	end

	def subscribed?(reservation)
		reservation.users.each do |r|
			return true if r.id == current_user.id
		end
		false
	end

	def resa_class(reservation)
		is_empty_place = empty_place?(reservation)
		days_left = (reservation.jour - Date.today).days

		resa_class = []
		resa_class << "new_resa" if changed_reservation?(reservation)
		if is_empty_place && days_left<=1.day
			resa_class << "error"
		elsif is_empty_place && days_left<=1.week
			resa_class << "warning"
		elsif !is_empty_place
			resa_class << "success"
		end

		resa_class * " "
	end

	def build_button(reservation)
		button_params = {}
		button_params[:participate] = "yes"
		button_params[:action]      = :put
		button_params[:text]        = "Participer"
		button_params[:disabled]    = false

		if subscribed?(reservation)
			button_params[:participate] = "no"
			button_params[:action]      = :delete if reservation.users.size == 1
			button_params[:text]        = "Désister  "
		elsif !empty_place?(reservation)
			button_params[:participate] = "no"
			button_params[:disabled]    = true
		end

		return button_params
	end

	def responsable_confirmation(reservation)
		message = "Confirmée au téléphone"
		responsable = User.find_by_id(reservation.responsable_id)
		if responsable && reservation.users.size > 1
			message += " par"
			if responsable == current_user
				message += " moi"
			else
				message += " #{responsable.nom} #{responsable.prenom}"
			end
		end
		message
	end

	def confirmation_message_group(reservation)
		message = "Cette action est irreversible."
		if reservation.users.size > 1
			message += " Si vous la validez, les users inscrits seront notifiés par mail."
		end
		message += " Etes-vous sûrs de vouloir continuer ?"
	end
end

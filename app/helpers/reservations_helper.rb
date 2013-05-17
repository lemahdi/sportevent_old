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

	def mem_jour(reservation)
		if reservation.nil? || reservation.jour.nil?
			Date.today.strftime('%d-%m-%Y')
		else
			reservation.jour.strftime('%d-%m-%Y')
		end
	end

	def is_new_reservation(reservation)
		reservation.id == flash[:new_reservation]
	end

	def equipage(reservation)
		reservation.rameurs.map do |rameur|
      rameur.prenom
    end.join(",")
	end

	def empty_place?(reservation)
		reservation.aviron.nbplaces > reservation.rameurs.size
	end

	def already_subscribed?(rameur, reservation)
		reservation.rameurs.each do |r|
			return true if r.id == rameur.id
		end
		false
	end
end

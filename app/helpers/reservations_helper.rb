module ReservationsHelper
	
	def aviron_types
		Aviron.uniq(:nbplaces).order("nbplaces ASC").map do |aviron|
			[aviron.description, aviron.id]
		end
	end

	def creneau_times
		creneaux = Creneau.order('debut ASC')
		simple_double = creneaux.map do |creneau|
			["#{creneau.debut.strftime('%H:%M')}-#{creneau.fin.strftime('%H:%M')}", creneau.id] if creneau.fin-creneau.debut == 45.minutes
		end.select { |c| c }
		yolette = creneaux.map do |creneau|
			["#{creneau.debut.strftime('%H:%M')}-#{creneau.fin.strftime('%H:%M')}", creneau.id] if creneau.fin-creneau.debut == 1.hour
		end.select { |c| c }

		[["--- horaires simple et double ---", nil]] + simple_double + [["--- horaires yolette ---", nil]] + yolette
	end

	def default_jour(reservation)
		if reservation.nil? || reservation.jour.nil?
			Date.today.strftime('%d-%m-%Y')
		else
			reservation.jour.strftime('%d-%m-%Y')
		end
	end
end

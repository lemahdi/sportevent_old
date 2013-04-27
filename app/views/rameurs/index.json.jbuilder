json.array!(@rameurs) do |rameur|
  json.extract! rameur, :nom, :prenom, :email
  json.url rameur_url(rameur, format: :json)
end
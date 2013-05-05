json.array!(@reservations) do |reservation|
  json.extract! reservation, :jour, :creneau_id, :aviron_id, :confirmation
  json.url reservation_url(reservation, format: :json)
end
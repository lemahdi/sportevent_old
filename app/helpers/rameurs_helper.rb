module RameursHelper

  # Returns the Gravatar (http://gravatar.com/) for the given rameur
  def gravatar_for(rameur)
    gravatar_id = Digest::MD5::hexdigest(rameur.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: rameur.email, class: "gravatar")
  end
end

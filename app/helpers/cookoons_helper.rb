module CookoonsHelper
  def readable_price(cookoon)
    humanized_money_with_symbol cookoon.price
  end

  def cookoon_safe_picture(cookoon)
    cookoon.photos? ? "https://res.cloudinary.com/cookoon/image/upload/#{cookoon.photos.first.path}" : 'http://lorempixel.com/400/200/city/'
  end
end

module CookoonsHelper
  def readable_price(cookoon)
    humanized_money_with_symbol cookoon.price
  end
end

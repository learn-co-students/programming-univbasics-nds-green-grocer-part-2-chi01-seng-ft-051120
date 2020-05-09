require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  index = 0
  coupons.each do |coupon|
    coupon_item = find_item_by_name_in_collection(coupon[:item], cart)
    item_in_basket = !!coupon_item
    count_apply_status = item_in_basket && coupon_item[:count] >= coupon[:num]
    if item_in_basket and count_apply_status
      cart << { item: "#{coupon_item[:item]} W/COUPON",
                price: coupon[:cost] / coupon[:num],
                clearance: coupon_item[:clearance],
                count: coupon[:num]
              }
      coupon_item[:count] -= coupon[:num]
    end
    index += 1
  end
  cart
end

def apply_clearance(cart)
  cart.map do |item|
    if item[:clearance]
      item[:price] *= 0.8
    end
    item
  end
end

def checkout(cart, coupons)
  final_cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  total = 0

  final_cart.each do |item|
    total += item[:price] * item[:count]
  end

  total *= 0.9 if total > 100
  total.round(2)
end

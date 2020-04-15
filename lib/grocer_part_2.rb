require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  coupon_check = 0
  while coupon_check < cart.length do 
    coupon_compare = 0
    while coupon_compare < coupons.length do
    if cart[coupon_check][:item] == coupons[coupon_compare][:item] && cart[coupon_check][:count] >= coupons[coupon_compare][:num]
      new_cost = coupons[coupon_compare][:cost] / coupons[coupon_compare][:num]
      non_discounted_amount = cart[coupon_check][:count] % coupons[coupon_compare][:num]
      discounted_amount = cart[coupon_check][:count] - non_discounted_amount
      couponed_item = {}
      couponed_item[:item] = cart[coupon_check][:item] + " " + "W/COUPON"
      couponed_item[:price] = new_cost
      couponed_item[:clearance] = cart[coupon_check][:clearance]
      couponed_item[:count] = discounted_amount
      cart[coupon_check][:count] = non_discounted_amount
      cart << couponed_item
    end 
    coupon_compare += 1
  end 
  coupon_check += 1
  end 
  cart 
  
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end

def apply_clearance(cart)
  cart_counter = 0 
  while cart_counter < cart.length do 
    if cart[cart_counter][:clearance] == true
      cart[cart_counter][:price] = (cart[cart_counter][:price] * 0.8).round(2)
    end
    cart_counter += 1
  end
  cart 
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end

def checkout(cart, coupons)
  cleanest_cart = consolidate_cart(cart)
  cleanest_cart_with_coupons = apply_coupons(cleanest_cart, coupons)
  cleanest_cart_all_discounts = apply_clearance(cleanest_cart_with_coupons)
  cart_counting = 0 
  final_amount = 0 
  while cart_counting < cleanest_cart_all_discounts.length do
    individual_item_cost = cleanest_cart_all_discounts[cart_counting][:count] * cleanest_cart_all_discounts[cart_counting][:price]
    final_amount += individual_item_cost
    cart_counting += 1
  end
  if final_amount > 100
    final_amount = final_amount * 0.90
  end 
  final_amount 
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
end
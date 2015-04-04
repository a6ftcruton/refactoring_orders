require './report_printer'

class Order
  include ReportPrinter

  attr_reader :status, :quantity
  attr_accessor :unit_price

  def initialize(order_number, quantity, address, order_type)
    @order_number = order_number
    @quantity     = quantity
    @address      = address
    @order_type   = order_type
  end
 
  def shipping_cost
    free_shipping? ? 0 : 4.95
  end

  def ship
    ship_product
    @status = "shipped"
  end

  def order_total 
    item_total + shipping_cost
  end

  def charge
    payment = Payment.new(@order_type, order_total)
    payment.charge()
  end

  private 

  def free_shipping?
    ["ebook", "conference_ticket"].include?(@order_type)
  end

  def ship_product
    case @order_type
    when "ebook"
      # [send email with download link...]
    when "conference_ticket"
      # [print ticket]
      # [print shipping label]
    else
      # [print shipping label]
    end
  end

  def item_total
    unit_price * quantity
  end

  def send_email_receipt
    # [send email receipt]
  end
 
  # In real life, charges would happen here. For sake of this test, it simply returns true
  def charge_paypal_account(amount)
    true
  end
 
  # In real life, charges would happen here. For sake of this test, it simply returns true
  def charge_credit_card(amount)
    true
  end
end
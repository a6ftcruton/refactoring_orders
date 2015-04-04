require './report_printer'

class ConferenceTicketOrder
  include ReportPrinter

  attr_reader :status, :quantity

  def initialize(order_number, quantity, address)
    @order_number = order_number
    @address = address
    if quantity > 1 
      raise "Conference tickets are limited to one per customer" 
    else
      @quantity = quantity
    end
  end
 
  def unit_price
    300
  end

  def charge(payment_type)
    if payment_type == :cash
      send_email_receipt
      @status = "charged"
    elsif payment_type == :cheque
      send_email_receipt
      @status = "charged"
    elsif payment_type == :paypal
      charge_paypal_account total_price
      send_email_receipt
      @status = "charged"
    elsif payment_type == :stripe
      charge_credit_card total_price
      send_email_receipt
      @status = "charged"
    end
  end
 
  def ship
    # [print ticket]
    # [print shipping label]
    @status = "shipped"
  end
 
  def to_s
    report = ["Order ##{@order_number}"]
    report << "Ship to: #{@address.join(", ")}"
    report << short_line_decorator 
    report << quantity_line_decorator
    report << long_line_decorator
    report << "#{quantity}     | Conference Ticket               | $#{"%0.2f" % total_price}"
    report
  end

  def total_price
    (unit_price * quantity) + shipping_cost
  end
 
  def shipping_cost
    0
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

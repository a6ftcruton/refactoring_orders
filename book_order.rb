#We are constantly trying to expand to offer our products to new markets around the world, so we continually need to add support for different payment gateways and methods. 
#
# Also, as the company grows, we plan to bring new sales and marketing staff on board who will need to see order data in various formats (HTML, XML, etc.). 
#
# Additionally, we are planning to introduce a lot of new products into the store very soon, such as software and training seminars.

require './report_printer'

class BookOrder
  include ReportPrinter

  attr_reader :status, :quantity

  def initialize(order_number, quantity, address)
    @order_number = order_number
    @quantity = quantity
    @address = address
  end
 
  def unit_price
    14.95
  end

  def charge(order_type, payment_type)
 
    if payment_type == :cash
      send_email_receipt
      @status = "charged"
    elsif payment_type == :cheque
      send_email_receipt
      @status = "charged"
    elsif payment_type == :paypal
      if charge_paypal_account(shipping_cost(order_type) + (quantity * unit_price))
        send_email_receipt
        @status = "charged"
      else
        send_payment_failure_email
        @status = "failed"
      end
    elsif payment_type == :stripe
      if charge_credit_card(shipping_cost(order_type) + (quantity * unit_price))
        send_email_receipt
        @status = "charged"
      else
        send_payment_failure_email
        @status = "failed"
      end
    end
  end
 
  def ship(order_type)
    if order_type == "ebook"
      # [send email with download link...]
    else
      # [print shipping label]
    end
 
    @status = "shipped"
  end
 
  def to_s(order_type)
    report = ["Order ##{@order_number}"]
    report << "Ship to: #{@address.join(", ")}"
    report << short_line_decorator 
    report << quantity_line_decorator
    report << long_line_decorator
    report << "#{quantity}     | Book                            | $#{"%0.2f" % total_price(order_type)}"
    report.join("\n")
  end

  def total_price(order_type)
    (unit_price * quantity) + shipping_cost(order_type)  
  end
 
  def shipping_cost(order_type)
    order_type == "ebook" ? 0 : 4.95
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
 

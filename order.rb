require './report_printer'
require './report_printer_helpers'
require './payment'

class Order
  include ReportPrinterHelpers

  attr_reader :quantity, :order_number, :address, :order_type, :order_total, :status
  attr_accessor :unit_price 

  def initialize(order_number, quantity, address, order_type)
    @order_number = order_number
    @address      = address
    @order_type   = order_type
    if @order_type == "conference_ticket" && quantity > 1
      raise"Conference tickets are limited to one per customer"
    else
      @quantity = quantity
    end
  end
 
  def unit_price
    2.00
  end

  def shipping_cost
    free_shipping? ? 0 : 4.95
  end

  def ship
    ship_product
    @status = "shipped"
  end

  def item_total
    unit_price * quantity
  end

  def order_total 
    item_total + shipping_cost
  end

  def charge(payment_type)
    payment = Payment.new(@order_type, order_total)
    if payment.send(payment_type)
      @status = "charged"
    else
      @status = "failure"
    end
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

  def send_email_receipt
    # [send email receipt]
  end
end

require './report_printer_helpers'

class ReportPrinter
  include ReportPrinterHelpers

  def initialize(order)
    @order_number = order.order_number
    @address      = order.address
    @quantity     = order.quantity
    @total_price  = order.order_total
    @order_type   = order.order_type
  end

  def to_s
    report = ["Order ##{@order_number}"]
    report << "Ship to: #{@address.join(", ")}"
    report << decorators
    report << "#{@quantity}     | #{ format_order_type(@order_type) }                            | $#{ "%0.2f" % @total_price }"
    report.join("\n")
  end
end

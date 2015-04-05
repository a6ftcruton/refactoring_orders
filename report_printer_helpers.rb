module ReportPrinterHelpers
  def newline
    "\n"
  end

  def short_line_decorator
    "-----" + newline + newline
  end

  def long_line_decorator
    "------|---------------------------------|------" + newline
  end

  def quantity_line_decorator
    "Qty   | Item Name                       | Total" + newline
  end

  def decorators
    short_line_decorator
    quantity_line_decorator
    long_line_decorator
  end

  def format_order_type(order_type)
    order_type.split("_").map(&:capitalize).join("\s")
  end
end

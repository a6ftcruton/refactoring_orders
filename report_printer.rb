module ReportPrinter
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
end

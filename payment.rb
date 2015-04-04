class Payment
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
end 

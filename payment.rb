class Payment
  attr_reader :order_total, :payment_status

  def initialize(order_type, order_total)
    @order_type = order_type
    @order_total = order_total
  end

  def cash
    successful_payment
  end

  def cheque
    successful_payment
  end

  def paypal
    if charge_paypal_account(order_total)
      successful_payment
    else
      failed_payment
    end
  end

  def stripe
    # if charge_credit_card(order_total)
      successful_payment
    # else
    #   failed_payment
    # end
  end

  private

    def successful_payment
      send_email_receipt
      @payment_status = "charged"
    end

    def failed_payment
      send_payment_failure_email
      @payment_status = "failed"
    end

    def charge_credit_card
      true
    end

    def charge_paypal_account
      true
    end

    def send_email_receipt
      # [send email receipt]
    end

    def send_payment_failure_email
      # [send payment failure email]
    end

end 

require './order' 
require './report_printer_helpers'
require 'rspec'
 
include ReportPrinterHelpers

describe Order do
  context "with a physical book" do 
    order_number   = 1
    quantity       = 5
    street_address = "1234 Main St."
    state_address  = "New York, NY 12345"
    order_type     = "print"

    subject { Order.new(order_number, quantity, [street_address, state_address], order_type) }

    it "calculates total price, including 4.95 shipping" do
      subject.unit_price = 2.00

      expect(subject.order_total).to eq 14.95 
    end

    it "gets marked as charged" do
      subject.charge(:stripe)
 
      expect(subject.status).to eq("charged")
    end
    
    it "gets marked as shipped" do
      subject.ship
 
      expect(subject.status).to eq("shipped")
    end
    
    it "calculates shipping cost" do
      shipping_cost = subject.shipping_cost
 
      expect(shipping_cost).to eq(4.95)
    end

  end

  context "with an ebook" do 
    order_number = 1
    quantity = 5
    street_address = "1234 Main St."
    state_address = "New York, NY 12345"
    order_type = "ebook"

    subject { Order.new(order_number, quantity, [street_address, state_address], order_type) }

    it "gets marked as charged" do
      subject.charge(:stripe)
 
      expect(subject.status).to eq("charged")
    end
    
    it "gets marked as shipped" do
      subject.ship
 
      expect(subject.status).to eq("shipped")
    end

    it "calculates shipping cost" do
      shipping_cost = subject.shipping_cost
 
      expect(shipping_cost).to eq(0)
    end

  end

  context "with a conference ticket" do 
    order_number = 1
    quantity = 1
    street_address = "1234 Main St."
    state_address = "New York, NY 12345"
    order_type = "conference_ticket"

    subject { Order.new(order_number, quantity, [street_address, state_address], order_type) }

    it "gets marked as charged" do
      subject.charge(:paypal)
 
      expect(subject.status).to eq("charged")
    end
    
    it "gets marked as shipped" do
      subject.ship
 
      expect(subject.status).to eq("shipped")
    end

    it "calculates shipping cost" do
      shipping_cost = subject.shipping_cost
 
      expect(shipping_cost).to eq(0)
    end
    
    it "produces a text-based report" do
      order = Order.new(12345, 1, ["1234 Main St.", "New York, NY 12345"], "conference_ticket")
      report = ["Order #12345"]
      report << "Ship to: 1234 Main St., New York, NY 12345"
      report << decorators
      report << "1     | Conference Ticket                            | $2.00"
      formatted_report = report.join("\n")
  
      order_report = ReportPrinter.new(order) 
      expect(order_report.to_s).to eq(formatted_report) 
    end

    it "does not allow more than one conference ticket per order" do
      expect do
        Order.new(1337, 3, ["456 Test St.", "New York, NY 12345"], "conference_ticket")
      end.to raise_error("Conference tickets are limited to one per customer")
    end
  end
end


require "./order" 
require "./book_order" 
require "./conference_ticket_order" 
require "./report_printer"
require "rspec"
 
include ReportPrinter

describe Order do
  context "with a physical book" do 
    subject { Order.new(1, 5, ["1234 Main St.", "New York, NY 12345"], "print") }

    it "calculates total price" do
      subject.unit_price = 2.00
      expect(subject.order_total).to eq 14.95 
    end

    it "gets marked as charged" do
      subject.charge("print", :stripe)
 
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
    subject { Order.new(1, 5, ["1234 Main St.", "New York, NY 12345"], "ebook") }

    # it "gets marked as charged" do
    #   subject.charge("print", :stripe)
 
    #   expect(subject.status).to eq("charged")
    # end
    
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
    subject { Order.new(1, 5, ["1234 Main St.", "New York, NY 12345"], "conference_ticket") }

    # it "gets marked as charged" do
    #   subject.charge("print", :stripe)
 
    #   expect(subject.status).to eq("charged")
    # end
    
    it "gets marked as shipped" do
      subject.ship
 
      expect(subject.status).to eq("shipped")
    end

    it "calculates shipping cost" do
      shipping_cost = subject.shipping_cost
 
      expect(shipping_cost).to eq(0)
    end

  end
end

# describe BookOrder do

#   context "with a physical book" do
#     subject { BookOrder.new(1, 5, ["1234 Main St.", "New York, NY 12345"]) }
 
#     it "gets marked as charged" do
#       subject.charge("print", :stripe)
 
#       expect(subject.status).to eq("charged")
#     end
 
#     it "gets marked as shipped" do
#       subject.ship("print")
 
#       expect(subject.status).to eq("shipped")
#     end
 
#     it "calculates shipping cost" do
#       shipping_cost = subject.shipping_cost("print")
 
#       expect(shipping_cost).to eq(4.95)
#     end
#   end
 
#   context "as an ebook" do
#     subject { BookOrder.new(2, 5, ["1234 Main St.", "New York, NY 12345"]) }
 
#     it "gets marked as charged" do
#       subject.charge("ebook", :paypal)
 
#       expect(subject.status).to eq("charged")
#     end
 
#     it "gets marked as shipped" do
#       subject.ship("ebook")
 
#       expect(subject.status).to eq("shipped")
#     end
 
#     it "calculates shipping cost" do
#       shipping_cost = subject.shipping_cost("ebook")
 
#       expect(shipping_cost).to eq(0)
#     end
#   end
 
#   it "produces a text-based report" do
#     order = BookOrder.new(12345, 5, ["1234 Main St.", "New York, NY 12345"])
#     report = ["Order #12345"]
#     report << "Ship to: 1234 Main St., New York, NY 12345"
#     report << short_line_decorator 
#     report << quantity_line_decorator
#     report << long_line_decorator
#     report << "5     | Book                            | $79.70"
#     formatted_report = report.join("\n")
 
#     expect(order.to_s("print")).to eq(formatted_report) # when order_type is print, 4.95 shipping is added
#   end
# end
 
# describe ConferenceTicketOrder do
#   context "a valid conference ticket order" do
#     subject do
#       ConferenceTicketOrder.new(3, 1, ["1234 Main St.", "New York, NY 12345"])
#     end
 
#     it "gets marked as charged" do
#       subject.charge(:paypal)
 
#       expect(subject.status).to eq("charged")
#     end
 
#     it "gets marked as shipped" do
#       subject.ship
 
#       expect(subject.status).to eq("shipped")
#     end
 
#     it "calculates shipping cost" do
#       shipping_cost = subject.shipping_cost
 
#       expect(shipping_cost).to eq(0)
#     end
 
#     it "produces a text-based report" do
#       order = ConferenceTicketOrder.new(12345, 1, ["1234 Test St.", "New York, NY 12345"])
#       report = ["Order #12345"]
#       report << "Ship to: 1234 Test St., New York, NY 12345"
#       report << short_line_decorator 
#       report << quantity_line_decorator
#       report << long_line_decorator
#       report << "1     | Conference Ticket               | $300.00"
#       report.join("\n")
 
#       expect(order.to_s).to eq(report)
#     end
#   end
 
#   it "does not allow more than one conference ticket per order" do
#     expect do
#       ConferenceTicketOrder.new(1337, 3, ["456 Test St.", "New York, NY 12345"])
#     end.to raise_error("Conference tickets are limited to one per customer")
#   end
# end

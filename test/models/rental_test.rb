require "test_helper"

describe Rental do
  describe "relations" do
    before do
      @rental = rentals(:rental)
      @c = customers(:customer1) 
      @v =  videos(:video2)

    end
    
    it "belongs to a video" do
      expect(@rental.video).must_be_instance_of Video
    end
    
    it "belongs to a customer" do
      expect(@rental.customer).must_be_instance_of Customer
    end
  end
  
  describe "validations" do
    before do
      video = videos(:video2)
      customer = customers(:customer1)

      @rental = Rental.create(video_id: video.id, customer_id: customer.id, due_date: Date.today)
      
    end
    
    it "is valid when all fields are present" do
      expect(@rental.valid?).must_equal true
    end
    
    it "is not valid when video is missing" do
      @rental.video_id = nil
      
      expect(@rental.valid?).must_equal false
    end
    
    it "is not valid when customer is missing" do
      @rental.customer_id = nil
      
      expect(@rental.valid?).must_equal false
    end

    it "is not valid when the due_date is missing" do
      @rental.due_date = nil
      
      expect(@rental.valid?).must_equal false
    end
  end
end
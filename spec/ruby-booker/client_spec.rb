require 'spec_helper'

describe Booker::Client do
  #let(:client){ Booker::Client.new(Auth::PROD_KEY, Auth::PROD_SECRET) }
  let(:client){ Booker::Client.new(Auth::KEY, Auth::SECRET) }

  def it_should_be_success response
    response['IsSuccess'].should be_true
  end

  describe '#find_locations_partial' do
    it 'is success' do
      response = client.find_locations_partial
      it_should_be_success response
    end
  end

  context 'requires locations' do
    before do
      @locations = client.find_locations_partial['Results']
      @location = @locations.first
    end

    describe '#find_treatments' do

      it 'is success' do
        response = client.find_treatments(
          "LocationID" => @location['ID'], "PageNumber" => 1, "PageSize" => 5
        )
        it_should_be_success response
      end
    end

    describe '#run_multi_service_availability' do
      before do
        @treatments = client.find_treatments("LocationID" => @location['ID'])['Treatments']
      end

      it 'is success' do

        itineraries = @treatments.map do |treatment|
          {
            "IsPackage" => false,
            "Treatments" => [
              {
                "TreatmentID" => treatment['ID']
              }
            ]
          }
        end

        response = client.run_multi_service_availability(
          "LocationID" => @location['ID'],
          "Itineraries" => itineraries
        )
        it_should_be_success response
      end

      it "requires itineraries field" do
        expect {
          client.run_multi_service_availability("LocationID" => @location['ID'])
        }.to raise_error(Booker::ArgumentError)
      end
    end

    describe '#get_treatment_categories' do
      it "is success" do
        response =  client.get_treatment_categories @location['ID']
        it_should_be_success response
      end
    end

    describe '#get_treatment_sub_categories' do
      before do
        @categories = client.get_treatment_categories(@location['ID'])['LookupOptions']
        @category = @categories.first
      end

      it "is success" do
        response =  client.get_treatment_sub_categories @location['ID'], @category['ID']
        it_should_be_success response
      end
    end

    describe '#get_location' do
      it "is success" do
        response =  client.get_location @location['ID']
        it_should_be_success response
      end
    end

    describe '#get_location_online_booking_settings' do
      it "is success" do
        response =  client.get_location_online_booking_settings @location['ID']
        response['IsSuccess'].should be_true
        it_should_be_success response
      end
    end
  end

end

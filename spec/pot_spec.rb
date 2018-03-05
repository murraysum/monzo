require "spec_helper"

describe Monzo::Pot do
  context "initializing an pot" do
    before :each do
      @pot = FactoryGirl.build(:pot)
    end

    it "should have an id" do
      expect(@pot.id).to eql("pot_0000778xxfgh4iu8z83nWb")
    end

    it "should have a name" do
      expect(@pot.name).to eql("Savings")
    end

    it "should have a style" do
      expect(@pot.style).to eql("beach_ball")
    end

    it "should have a balance" do
      expect(@pot.balance).to eql(133700)
    end

    it "should have a currency"  do
      expect(@pot.currency).to eql("GBP")
    end

    it "should have a created date" do
      expect(@pot.created).to eql("2017-11-09T12:30:53.695Z")
    end

    it "should have a updated date" do
      expect(@pot.updated).to eql("2017-11-10T12:30:53.695Z")
    end
  end

  context ".all" do
    before :each do
      access_token = "abc"
      Monzo.configure(access_token)

      attributes = {}
      attributes["pots"] = [FactoryGirl.attributes_for(:pot)]

      @stub = stub_request(:get, "https://api.monzo.com/pots")
      @stub.with(headers: build_request_headers(access_token))
      @stub.to_return(status: 200, body: attributes.to_json, headers: {})

      @pots = Monzo::Pot.all
    end

    it "has performed the request" do
      expect(@stub).to have_been_requested
    end

    it "should be a list of pots" do
      expect(@pots).to be_an_instance_of(Array)
      expect(@pots.first).to be_an_instance_of(Monzo::Pot)
    end

    it "should have an id" do
      expect(@pots.first.id).to eql("pot_0000778xxfgh4iu8z83nWb")
    end

    it "should have a name" do
      expect(@pots.first.name).to eql("Savings")
    end

    it "should have a style" do
      expect(@pots.first.style).to eql("beach_ball")
    end

    it "should have a balance" do
      expect(@pots.first.balance).to eql(133700)
    end

    it "should have a currency"  do
      expect(@pots.first.currency).to eql("GBP")
    end

    it "should have a created date" do
      expect(@pots.first.created).to eql("2017-11-09T12:30:53.695Z")
    end

    it "should have a updated date" do
      expect(@pots.first.updated).to eql("2017-11-10T12:30:53.695Z")
    end
  end

  context ".find" do
    before :each do
      access_token = "abc"
      Monzo.configure(access_token)

      attributes = {}
      attributes["pot"] = FactoryGirl.attributes_for(:pot)

      pot_id = attributes["pot"]["id"]

      @stub = stub_request(:get, "https://api.monzo.com/pots/#{pot_id}").
        with(headers: build_request_headers(access_token)).
        to_return(status: 200, body: attributes.to_json, headers: {})

      @pot = Monzo::Pot.find(pot_id)
    end

    it "has performed the request" do
      expect(@stub).to have_been_requested
    end

    it "should be an instance of pot" do
      expect(@pot).to be_an_instance_of(Monzo::Pot)
    end

    it "should have an id" do
      expect(@pot.id).to eql("pot_0000778xxfgh4iu8z83nWb")
    end

    it "should have a name" do
      expect(@pot.name).to eql("Savings")
    end

    it "should have a style" do
      expect(@pot.style).to eql("beach_ball")
    end

    it "should have a balance" do
      expect(@pot.balance).to eql(133700)
    end

    it "should have a currency"  do
      expect(@pot.currency).to eql("GBP")
    end

    it "should have a created date" do
      expect(@pot.created).to eql("2017-11-09T12:30:53.695Z")
    end

    it "should have a updated date" do
      expect(@pot.updated).to eql("2017-11-10T12:30:53.695Z")
    end
  end

  context "instance methods" do
    before :each do
      @pot = FactoryGirl.build(:pot)

      @amount_to_move = 100
      @initial_balance = @pot.balance
      @account_id = FactoryGirl.attributes_for(:account)[:id]

      @request_body = {
        amount: @amount_to_move.to_s,
        dedupe_id: 'some_uuid'
      }

      @access_token = "abc"
      Monzo.configure(@access_token)

      @attributes = FactoryGirl.attributes_for(:pot)
    end

    context "#deposit!" do
      before :each do
        @attributes[:balance] += @amount_to_move
        @request_body[:source_account_id] =  @account_id

        @stub = stub_request(:put, "https://api.monzo.com/pots/#{@pot.id}/deposit")
        @stub.with(headers: build_request_headers(@access_token), body: @request_body)
        @stub.to_return(status: 200, body: @attributes.to_json, headers: {})

        @pot.deposit!(@amount_to_move, @account_id, "some_uuid")
      end

      it "has performed the request" do
        expect(@stub).to have_been_requested
      end

      it "should be a pot" do
        expect(@pot).to be_an_instance_of(Monzo::Pot)
      end

      it "should have the same id" do
        expect(@pot.id).to eq @pot.id
      end

      it "has updated the balance correctly" do
        expect(@pot.balance).to eq (@initial_balance + @amount_to_move)
      end
    end

    context "#withdraw!" do
      before :each do
        @attributes[:balance] -= @amount_to_move
        @request_body[:destination_account_id] =  @account_id

        @stub = stub_request(:put, "https://api.monzo.com/pots/#{@pot.id}/withdraw")
        @stub.with(headers: build_request_headers(@access_token), body: @request_body)
        @stub.to_return(status: 200, body: @attributes.to_json, headers: {})

        @pot.withdraw!(@amount_to_move, @account_id, "some_uuid")
      end

      it "has performed the request" do
        expect(@stub).to have_been_requested
      end

      it "should be a pot" do
        expect(@pot).to be_an_instance_of(Monzo::Pot)
      end

      it "should have the same id" do
        expect(@pot.id).to eq @pot.id
      end

      it "has updated the balance correctly" do
        expect(@pot.balance).to eq (@initial_balance - @amount_to_move)
      end
    end
  end
end

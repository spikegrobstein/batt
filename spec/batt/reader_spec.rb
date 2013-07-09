require 'spec_helper'

describe Batt::Reader do
  let(:reader) { Batt::Reader.new }
  let(:status) { reader.status }

  it "should initialize without error" do
    b = Batt::Reader.new
  end

  context "get_battery_status_osx" do
    let(:output_ac_power_no_estimate) { "Currently drawing from 'AC Power'\n -InternalBattery-0     98%; charging; (no estimate)" }
    let(:output_ac_power_estimate) { "Currently drawing from 'AC Power'\n -InternalBattery-0     88%; charging; 0:30 remaining" }
    let(:output_battery_power) { "Currently drawing from 'Battery Power'\n -InternalBattery-0     100%; discharging; 5:36 remaining" }

    let(:status) { reader.parse_battery_status_osx(output) }

    before do
      reader.stub(:get_os => :darwin)
    end

    context "when ac attached" do
      context "no estimate" do
        let(:output) { output_ac_power_no_estimate }

        it "should return a hash" do
          status.class.should == Hash
        end

        it "should return a source of 'AC Power'" do
          status[:source].should == 'AC Power'
        end

        it "should return a capacity of '98%'" do
          status[:capacity].should == '98%'
        end

        it "should return a status of 'charging'" do
          status[:status].should == 'charging'
        end

        it "should return a remaining of '(no estimate)'" do
          status[:remaining].should == '(no estimate)'
        end

      end

      context "with estimate" do
        let(:output) { output_ac_power_estimate }

      end
    end

    context "when on battery power" do
      let(:output) { output_battery_power }
    end
  end
end

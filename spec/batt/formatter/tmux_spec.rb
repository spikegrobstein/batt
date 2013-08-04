require 'spec_helper'

describe Batt::Formatter::Tmux do
  let(:formatter) { Batt::Formatter::Tmux }
  let(:string_to_format) { 'just testing' }

  describe "format" do

    context "when no colors are passed" do
      it "should return just the string" do
        formatter.format(string_to_format).should == string_to_format
      end
    end

    context "when passed just a fg color" do
      let(:output) { formatter.format(string_to_format, :fg => :red) }

      it "should not include a bg field" do
        output.should_not match(/bg=/)
      end

      it "should include the fg color in the string" do
        output.should match(/fg=red/)
      end

      it "should not have a comma in the color descriptors" do
        output.should_not match(/^#\[.+?,.+?\]/)
      end

      it "should reset the color to default at the end" do
        output.should match(/#\[default\]$/)
      end

      it "should include the string being formatted" do
        output.should match(/#{ string_to_format }/)
      end

    end

    context "when passed just a bg color" do
      let(:output) { formatter.format(string_to_format, :bg => :red) }

      it "should not include a fg field" do
        output.should_not match(/fg=/)
      end

      it "should include the bg color in the string" do
        output.should match(/bg=red/)
      end

      it "should not have a comma in the color descriptors" do
        output.should_not match(/^#\[.+?,.+?\]/)
      end

      it "should reset the color to default at the end" do
        output.should match(/#\[default\]$/)
      end

      it "should include the string being formatted" do
        output.should match(/#{ string_to_format }/)
      end

    end

    context "when passed both fg and bg colors" do
      let(:output) { formatter.format(string_to_format, :fg => :black, :bg => :red) }

      it "should include both fg and bg fields" do
        output.should match(/fg=black/)
        output.should match(/bg=red/)
      end

      it "should separate the color descriptors with a comma" do
        output.should match(/^#\[.+?,.+?\]/)
      end

      it "should reset the color to default at the end" do
        output.should match(/#\[default\]$/)
      end

      it "should include the string being formatted" do
        output.should match(/#{ string_to_format }/)
      end

    end

  end

  describe "bg_color" do

    it "should return nil if passed nil" do
      formatter.bg_color(nil).should be_nil
    end

    it "should accept a string color" do
      formatter.bg_color("red").should == 'bg=red'
    end

    it "should accept a symbol color" do
      formatter.bg_color(:red).should == 'bg=red'
    end

  end

  describe "fg_color" do

    it "should return nil if passed nil" do
      formatter.fg_color(nil).should be_nil
    end

    it "should accept a string color" do
      formatter.fg_color("red").should == 'fg=red'
    end

    it "should accept a symbol color" do
      formatter.fg_color(:red).should == 'fg=red'
    end

  end

end

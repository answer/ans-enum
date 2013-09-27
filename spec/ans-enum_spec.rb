# -*- coding: utf-8 -*-
require "spec_helper"

class Ans::Enum::EnumTest
end

describe Ans::Enum do
  subject{Ans::Enum::EnumTest}
  before do
    Ans::Enum::EnumTest.send :include, Ans::Enum
  end

  it{should be_respond_to :enum_of}

  context "enum_of" do
    subject{Ans::Enum::EnumTest.new}
    before do
      Ans::Enum::EnumTest.class_eval do
        enum_of "my_status", [:busy,:work,:wait]
      end
    end

    [:busy,:work,:wait].each do |name|
      it{should be_respond_to :"my_status_#{name}"}

      context "my_status_#{name}" do
        subject{Ans::Enum::EnumTest.new.send :"my_status_#{name}"}

        [:busy,:work,:wait].each do |status_name|
          it{should be_respond_to :"#{status_name}?"}
          it{subject.send(:"#{status_name}?").should == (name == status_name)}
          it{subject.to_s.should == "#{name}"}
        end
      end
    end

    it{should be_respond_to :my_status_null}

    context "my_status_null" do
      subject{Ans::Enum::EnumTest.new.send :my_status_null}

      [:busy,:work,:wait].each do |status_name|
        it{should be_respond_to :"#{status_name}?"}
        it{subject.send(:"#{status_name}?").should be_false}
        it{subject.to_s.should == "null"}
      end
    end
  end
end

require 'spec_helper'

module Globalize
  module ActiveRecord
    module Accessors
      module DynamicAccessors
        describe Matcher do
          context "with body_en" do
            subject :matcher do
              Matcher.new('body_en', Comment.new)
            end

            it { should be_a_match }
            its (:attribute) { should eq(:body) }
            its (:locale) { should eq(:en) }
          end
          
          context "with body_fr=" do
            subject :matcher do
              Matcher.new('body_fr=', Comment.new)
            end

            it { should be_a_match }
            its (:attribute) { should eq(:body) }
            its (:locale) { should eq(:fr) }
          end          
          
          context "with body" do
            subject :matcher do
              Matcher.new('body', Comment.new)
            end

            it { should_not be_a_match }
          end          
        end
      end
    end
  end
end
      
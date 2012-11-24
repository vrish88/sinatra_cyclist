require "spec_helper"

module Sinatra
  describe Cyclist do
    it "registers itself as an extension" do
      Base.extensions.should include Sinatra::Cyclist
    end
  end
end
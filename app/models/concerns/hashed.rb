require 'bson'

module Hashed
  extend ActiveSupport::Concern

  included do
    before_create :create_hashed_id
  end

  def create_hashed_id
    self.hashed_id = (BSON::ObjectId.new).to_s
  end
end

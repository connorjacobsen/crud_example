require 'bson'

module Public
  extend ActiveSupport::Concern

  included do
    before_create :create_public_id
  end

  def create_public_id
    self.public_id = (BSON::ObjectId.new).to_s
  end
end

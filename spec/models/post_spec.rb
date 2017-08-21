require 'rails_helper'

RSpec.describe Post, type: :model do
  # Validations
  it { validate_presence_of :content }
  it { validate_presence_of :title }

  # Associations
  it { have_many(:comments).dependent(:delete_all) }
end

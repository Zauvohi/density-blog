require 'rails_helper'

RSpec.describe Comment, type: :model do
  # Validations
  it { validate_presence_of :body }

  # Associations
  it { belong_to(:post) }

  describe "Callbacks" do
    before :each do
      @post = Post.create! title: "Test", content: "Test"
      @comment = Comment.new(name: "Anon", body: "Test", post: @post)
    end

    context "calls perform_later on CommentBroadcastJob" do
      it "with 'created' status after commit" do
        expect(CommentBroadcastJob)
          .to receive(:perform_later).with(@comment, 'created')
        @comment.save
      end

      it "with destroyed status after destroy " do
        @comment.save
        expect(CommentBroadcastJob)
          .to receive(:perform_later).with(@comment, 'destroyed')
        @comment.destroy
      end
    end

  end
end

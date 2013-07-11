require 'minitest_helper'

describe Comment do

  subject { Comment.new }

  context 'Comment model connection' do
    it { must belong_to(:commentable)}
  end

  context 'Comment db column' do
    it { must have_db_column(:description).of_type(:text) }
    it { must have_db_column(:post_id).of_type(:integer) }
    it { must have_db_column(:commentable_id).of_type(:integer) }
    it { must have_db_column(:commentable_type).of_type(:string) }
    it { must have_db_column(:created_at).of_type(:datetime) }
    it { must have_db_column(:updated_at).of_type(:datetime) }
  end

  context 'Comment validation' do
    it { must validate_presence_of(:description)}
    it { must ensure_length_of(:description).is_at_least(5)}
    it { must validate_presence_of(:commentable_type) }
    it { must ensure_length_of(:commentable_type).is_at_most(255) }
    it { must validate_presence_of(:commentable_id) }
    it { must validate_numericality_of(:commentable_id).only_integer }
    it { must ensure_length_of(:commentable_id).is_at_least(0) }
  end

end

require 'spec_helper'

RSpec.describe ContentFlagging::Flaggable do
  let(:post) { Post.create(title: "Test Post") }
  let(:user) { User.create(name: "Test User") }
  
  describe '#acts_as_flaggable' do
    it 'adds flagging methods to model' do
      expect(post).to respond_to(:flag!)
      expect(post).to respond_to(:unflag!)
      expect(post).to respond_to(:flagged?)
      expect(post).to respond_to(:flag_count)
    end
    
    it 'adds scopes to model' do
      expect(Post).to respond_to(:flagged)
      expect(Post).to respond_to(:not_flagged)
      expect(Post).to respond_to(:with_flagged)
    end
  end
  
  describe '#flag!' do
    it 'creates a flag record' do
      expect { post.flag!(flagged_by: user) }.to change { post.flags.count }.by(1)
    end
    
    it 'increments flagged_count' do
      expect { post.flag!(flagged_by: user) }.to change { post.reload.flagged_count }.by(1)
    end
  end
  
  describe '#unflag!' do
    before { post.flag!(flagged_by: user) }
    
    it 'removes flag record' do
      expect { post.unflag!(flagged_by: user) }.to change { post.flags.count }.by(-1)
    end
    
    it 'decrements flagged_count' do
      expect { post.unflag!(flagged_by: user) }.to change { post.reload.flagged_count }.by(-1)
    end
  end
  
  describe '#flagged?' do
    it 'returns false when below threshold' do
      2.times { post.flag! }
      expect(post.flagged?).to be false
    end
    
    it 'returns true when at threshold' do
      3.times { post.flag! }
      expect(post.flagged?).to be true
    end
  end
  
  describe '#flagged_at' do
    it 'returns nil when not flagged' do
      2.times { post.flag! }
      expect(post.flagged_at).to be_nil
    end
    
    it 'returns earliest flag time when flagged' do
      3.times { post.flag! }
      expect(post.flagged_at).to be_present
      expect(post.flagged_at).to be_a(Time)
    end
  end
  
  describe 'scopes' do
    let!(:normal_post) { Post.create(title: "Normal") }
    let!(:flagged_post) { Post.create(title: "Flagged") }
    
    before { 3.times { flagged_post.flag! } }
    
    it 'default scope excludes flagged content' do
      expect(Post.all).to include(normal_post)
      expect(Post.all).not_to include(flagged_post)
    end
    
    it 'with_flagged includes all content' do
      expect(Post.with_flagged).to include(normal_post, flagged_post)
    end
    
    it 'flagged scope returns only flagged content' do
      expect(Post.with_flagged.flagged).to include(flagged_post)
      expect(Post.with_flagged.flagged).not_to include(normal_post)
    end
  end
end
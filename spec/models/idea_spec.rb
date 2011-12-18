# == Schema Information
#
# Table name: ideas
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  title      :string(255)
#  content    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Idea do
  before(:each) do
    @attr = {
      :title => "title",
      :content => "test content"
    }
  end

  it "should create a new idea with attr" do
    Idea.create!(@attr)
  end
  
  it "should not create without title" do 
    no_title_idea = Idea.new(@attr.merge(:title => ""))
    no_title_idea.should_not be_valid
  end

  it "should not create with long title" do 
    long_title = "a" * 31
    long_idea = Idea.new(@attr.merge(:title => long_title))
    long_idea.should_not be_valid
  end
  
  it "should not create without content" do 
    no_content_idea = Idea.new(@attr.merge(:content => ""))
    no_content_idea.should_not be_valid
  end

  it "should not create with too short content" do 
    short_content = "a" * 5
    short_idea = Idea.new(@attr.merge(:content => short_content))
    short_idea.should_not be_valid
  end

  it "should create with long content" do 
    long_content = "a" * 400
    long_idea = Idea.new(@attr.merge(:content => long_content))
    long_idea.save
    long_idea.reload.content == long_content
  end

  it "should not create with too long content" do 
    long_content = "a" * 401
    long_idea = Idea.new(@attr.merge(:content => long_content))
    long_idea.should_not be_valid
  end

  it "should not create idea with same title" do 
    Idea.create!(@attr)
    idea = Idea.new(@attr)
    idea.should_not be_valid
  end

  it "should store right idea" do 
    long_idea = Idea.create!(@attr)
    long_idea.reload.user_id == @attr[:user_id]
    long_idea.reload.title == @attr[:title]
    long_idea.reload.content == @attr[:content]
  end

  describe "user associations" do
    before(:each) do
      @user = Factory(:user)
      @idea = @user.ideas.create(@attr)
    end

    it "should have a user attribute" do
      @idea.should respond_to(:user)
    end

    it "should have the right associated user" do
      @idea.user_id.should == @user.id
      @idea.user.should == @user
    end
  end
end

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "DynamicAccessors" do
  describe Comment.new do
    it { should respond_to(:body) }
    it { should respond_to(:body_en) }
    it { should respond_to(:body_fr) }
    it { should respond_to(:body=) }
    it { should respond_to(:body_en=) }
    it { should respond_to(:body_fr=) }
    it { should respond_to(:published_en) }
  end
  
  describe "Getters" do
    before :all do
      @comment = Comment.create
      @comment.translations.create(:locale => 'en', :body => 'English')
      @comment.translations.create(:locale => 'fr', :body => 'French')
    end
    
    it "should return English when requesting body_en" do
      @comment.body_en.should eq("English")
    end
    
    it "should return French when requesting body_fr" do
      @comment.body_fr.should eq("French")
    end
  end

  describe "Setters" do
    before :all do
      @comment = Comment.create(:body_en => "English", :body_fr => "French")
    end
    
    it "should have created two translations" do
      @comment.translations.length.should eq(2)
    end
    
    it "should return English when requesting body_en" do
      @comment.translations.find_by_locale('en').body.should eq("English")
    end
    
    it "should return French when requesting body_fr" do
      @comment.translations.find_by_locale('fr').body.should eq("French")
    end
  end

  
end

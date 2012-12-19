require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "StaticAccessors" do
  describe Post.new do
    it { should respond_to(:title_en) }
    it { should respond_to(:title_fr) }
    it { should respond_to(:title_en=) }
    it { should respond_to(:title_fr=) }
    it { should respond_to(:content_en) }
    it { should respond_to(:content_fr) }
    it { should respond_to(:content_en=) }
    it { should respond_to(:content_fr=) }
    it { should_not respond_to(:title_es) }
    it { should_not respond_to(:published_en) }
  end
  
  describe "Getters" do
    before :all do
      @post = Post.create
      @post.translations.create(:locale => 'en', :title => 'English')
      @post.translations.create(:locale => 'fr', :title => 'French')
    end
    
    it "should return English when requesting title_en" do
      @post.title_en.should eq("English")
    end
    
    it "should return French when requesting title_fr" do
      @post.title_fr.should eq("French")
    end
  end

  describe "Setters" do
    before :all do
      @post = Post.create(:title_en => "English", :title_fr => "French")
    end
    
    it "should have created two translations" do
      @post.translations.length.should eq(2)
    end
    
    it "should return English when requesting title_en" do
      @post.translations.find_by_locale('en').title.should eq("English")
    end
    
    it "should return French when requesting title_fr" do
      @post.translations.find_by_locale('fr').title.should eq("French")
    end
  end

  
end

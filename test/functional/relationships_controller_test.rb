require File.dirname(__FILE__) + '/../test_helper'

class RelationshipsControllerTest < ActionController::TestCase   
  
  fixtures :users, :articles, :productions, :periodical_issues
  
  context "delete a relation (normal)" do
    setup do
      @article = articles(:one)
      @periodical_issue = periodical_issues(:one)
      @article.periodical_issue = @periodical_issue
      @article.save(false)
      login_as :admin
      post "delete", :relationship_type => "periodical_issue", :child_id => @periodical_issue.id, :parent_class => "Article", :parent_id => @article.permalink
    end
    should "check rel ids" do
      assert @article.reload
      assert_nil @article.periodical_issue_id
    end
  end

  context "delete a relation (relationships)" do
    setup do
      @article = articles(:one)
      @production = productions(:one)
      @article.about_productions << @production
      @aap = @article.article_about_productions.first
      login_as :admin
      post "delete", :relationship_type => "article_about_productions", :child_id => @aap.id, :parent_class => "Article", :parent_id => @article.permalink
    end
    should "check rel ids" do
      assert_equal 0, ArticleAboutProduction.count
      assert @article.reload
      assert @production.reload
    end
  end


end
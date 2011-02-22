require File.dirname(__FILE__) + '/../test_helper'

class ArticleByPersonTest < ActiveSupport::TestCase

  fixtures :articles, :people, :relationships

  should 'return the other side' do
    relation = relationships(:my_relation)
    assert_equal(relation.person, relation.other_side(relation.article))
    assert_equal(relation.article, relation.other_side(relation.person))
  end

end
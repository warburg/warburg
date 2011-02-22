require File.dirname(__FILE__) + '/../../test_helper'

class ApplicationHelperTest < ActionView::TestCase
  fixtures :people, :countries, :organisations, :relationships, :genders, :languages

  context "a guest" do
    setup do
      self.stubs(:roles).returns([])
      self.stubs(:available_locales).returns(%w(nl fr en))
    end


    should "have details_rows render the simple fields" do
      I18n.locale = 'nl'
      person = people(:erwin)
      assert_dom_equal("<li><dl><dt>Voornaam</dt><dd>Erwin</dd></dl></li><li><dl><dt>Familienaam</dt><dd>Verhaert</dd></dl></li>", details_rows(person, nil, :show))
    end

    should "have details_rows hide hidden fields" do
      I18n.locale = 'nl'
      self.stubs(:roles).returns([])
      self.stubs(:available_locales).returns(%w(nl fr en))
      person = people(:ursula)
      assert_dom_equal("<li><dl><dt>Voornaam</dt><dd>Ursula</dd></dl></li><li><dl><dt>Familienaam</dt><dd>Verharen</dd></dl></li>", details_rows(person, nil, :show))
    end

    should "have details_rows follow belongs_to relations" do
      I18n.locale = 'nl'
      self.stubs(:roles).returns([])
      self.stubs(:available_locales).returns(%w(nl fr en))
      person = people(:phoebe)
      assert(details_rows(person, nil, :show) =~ /.*Voornaam.*Familienaam.*Geslacht.*Vrouw.*/)
    end

    should "render correct values" do
      I18n.locale = 'en'
      assert_equal('No', render_value(nil, nil, false, nil, :show))
      I18n.locale = 'nl'
      assert_equal('Ja', render_value(nil, nil, true, nil, :show))
      assert_equal('Nee', render_value(nil, nil, false, nil, :show))
      assert_equal('04/05/1999', render_value(nil, nil, Date.new(1999,05,04), nil, :show))
      assert_equal('Jos, Piet', render_value(nil, nil, %w(Jos Piet), nil, :show))
      assert_nil(render_value(nil, nil, nil, nil, :show))
      self.stubs(:url_for).returns('#test#')
      assert_equal("<a href=\"#test#\">Erwin Verhaert</a>", render_value(nil, nil, people(:erwin), nil, :show))
      assert_equal("Belgi‘", render_value(nil, nil, countries(:belgium), nil, :show))
    end

    should "ignore foreign translations" do
      I18n.locale = 'nl'
      assert_equal("<li><dl><dt>Naam</dt><dd>Belgi‘</dd></dl></li><li><dl><dt>ISO code</dt><dd>BE</dd></dl></li>", details_rows(countries(:belgium), nil, :show))
    end

    should 'see a decent organisation' do
      organisation = organisations(:one)
      boxes_for(organisation)
    end
  end

  context "an admin" do
    setup do
      self.stubs(:roles).returns([:admin])
      self.stubs(:available_locales).returns(%w(nl fr en))
    end

    context "while looking" do

      should "see all foreign translations" do
        I18n.locale = 'nl'
        nl = "<li><dl><dt>Naam (nl)</dt><dd>Belgi‘</dd></dl></li>"
        fr = "<li><dl><dt>Naam (fr)</dt><dd>Belgique</dd></dl></li>"
        en = "<li><dl><dt>Naam (en)</dt><dd>Belgium</dd></dl></li>"
        iso = "<li><dl><dt>ISO code</dt><dd>BE</dd></dl></li>"
        updated_at = "<li><dl><dt>Gewijzigd op</dt><dd>2009-04-24 09:59:38 UTC</dd></dl></li>"
        created_at = "<li><dl><dt>Gecre&euml;erd op</dt><dd>2009-04-24 09:59:38 UTC</dd></dl></li>"
        id = "<li><dl><dt>ID</dt><dd>762200240</dd></dl></li>"

        assert_dom_equal(nl+en+updated_at+fr+id+iso+created_at, details_rows(countries(:belgium), nil, :show))
      end

      should "see readonly fields" do
        all_fields = {}
        p = people(:joey)
        p.save!
        assert_equal('Joey Tribbiani', p.name)
        p.each_field do |key, value|
          all_fields[key] = value
        end
        assert(all_fields.keys.include?('name'))
      end

    end

    context "while editing" do
      should "have text fields for string attributes" do
        
      end

      should "not see readonly fields" do
        all_fields = {}
        p = people(:joey)
        p.save!
        assert('Joey Tribbiani', p.name)
        p.each_field(:edit) do |key, value|
          all_fields[key] = value
        end
        assert(!all_fields.keys.include?('name'))
      end

      # This test doesn't seem to work correctly :(
#      should 'have the right delete_url' do
#        assert(delete_url(relationships(:my_relation)), '')
#      end

      should 'have the right other_side_class' do
        assert_equal(Production, ProductionByPerson.other_side_class(Person))
      end

    end
  end

#  def form_authenticity_token
#    'abc'
#  end

end
require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken


  set_friendly_id :generate_permalink

  belongs_to :language

  relations [:postits, :edits]

  model_stamper
  stampable

  validates_presence_of     :login, :if => :not_openid?
  validates_length_of       :login,    :within => 3..40, :if => :not_openid?
  validates_uniqueness_of   :login, :if => :not_openid?
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message, :if => :not_openid?

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email, :if => :not_openid?
  validates_length_of       :email,    :within => 6..100 , :if => :not_openid?
  validates_uniqueness_of   :email, :if => :not_openid?
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message, :if => :not_openid?

  validates_presence_of :identity_url

  has_many :postits



  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation, :identity_url, :admin



  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_by_login(login) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  def password_required?
    not_openid? && (crypted_password.blank? or not password.blank?)
  end

  def not_openid?
    identity_url.blank?
  end

  def self.find_by_identity_url(identity_url)
    # Handle the difference between 'http://tomklaasen.net' and 'http://tomklaasen.net/'
    find(:first, :conditions => ['identity_url = ? or identity_url = ? or identity_url = ?', identity_url, "#{identity_url}/", identity_url.gsub(/\/$/, '')])
  end

  def title
    identity_url
  end

  def self.order_field
    'identity_url'
  end

  def to_s
    identity_url
  end

  def generate_permalink
    identity_url[6..-1] if identity_url
  end

  def generate_permalink=(value)
    identity_url = "http://#{value}"
  end

  def edits
    result = []
    (Global.main_classes + Global.help_classes).each do |klazz|
      unless (klazz =~ /^cdb_/) || (klazz == 'documents')
        result += eval(klazz.classify).all(:conditions => ['updater_id = ?', self.id], :order => 'updated_at desc', :limit => 10)
      end
    end
    result
  end


end

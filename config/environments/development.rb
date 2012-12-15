# Settings specified here will take precedence over those in config/environment.rb
USE_SSL_MODE = false #SSL MODEを使用しない
# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true
ActionView::Base.field_error_proc = Proc.new {|html_tag, instance|  %(<span class="fieldWithErrors">#{html_tag}</span>)}
# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false
config.action_view.cache_template_extensions         = false

# Don't care if the mailer can't send
config.action_mailer.raise_delivery_errors = true
config.log_level = :debug
config.action_mailer.default_charset = 'iso-2022-jp'

#@@sagawa windowsメール環境にする!!
 if RUBY_PLATFORM =~ /(:?mswin|mingw)/
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
  :address => "sv56.wadax.ne.jp",
  :port => 587,
  :domain => "sv56.wadax.ne.jp",
  :user_name => "harato@temona.co.jp",
  :password => "rNo1nrsz"
  }
 else
   config.action_mailer.delivery_method = :sendmail
 end

SUBDOMAIN_IS_XXX = false
MY_SUBDOMAIN = 'www'
TLD_LENGTH = 2 

CA_FILE = case RUBY_PLATFORM
when /darwin/
  '/usr/share/curl/curl-ca-bundle.crt' # Mac OS X
when /freebsd/
  '/usr/ports/security/ca-roots/files/ca-root.crt'
when /linux/
  '/etc/pki/tls/certs/ca-bundle.crt'
else
   'c:\work\curl-ca-bundle.crt' # ... Windows
end

#my_email_address = "admin_luna@lunarembassy.co.jp"
my_email_address = "harato@temona.co.jp"
# お問い合わせを受信する管理者
CONTACT_INQUIRY_RECIPIENTS = 'harato@temona.co.jp'
CONTACT_INQUIRY_RECIPIENTS_MOBILE = 'harato@temona.co.jp'


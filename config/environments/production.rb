# Settings specified here will take precedence over those in config/environment.rb
USE_SSL_MODE = true
# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes = true

# Use a different logger for distributed setups
require "syslog_logger"
config.logger = RAILS_DEFAULT_LOGGER = SyslogLogger.new('lunar')
ActionView::Base.field_error_proc = Proc.new {|html_tag, instance|  %(<span class="fieldWithErrors">#{html_tag}</span>)}

# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true

#require "#{RAILS_ROOT}/vendor/plugins/exception_notification/lib/exception_notifier"
#ExceptionNotifier.exception_recipients = ['sagawa@zutto.co.jp', 'harato@zutto.co.jp']
#ExceptionNotifier.sender_address = %("LUNAR - Application Error" <system@lunarembassy.co.jp>)
ENABLE_EXCEPTION_NOTIFICATION_FOR_LOCALHOST = false

# Enable serving of images, stylesheets, and javascripts from an asset server
# config.action_controller.asset_host                  = "http://assets.example.com"

# Disable delivery errors, bad email addresses will be ignored
#config.action_mailer.raise_delivery_errors = true
   config.action_mailer.default_charset = 'iso-2022-jp'
   config.action_mailer.delivery_method = :smtp
   config.action_mailer.smtp_settings = {
   :address => "127.0.0.1",
   :port => 25,
   :domain => "localhost"
   }

##########################################
#require "#{RAILS_ROOT}/vendor/plugins/svn_username/lib/svn_username"
#
###### Configuration of redirection #####
## ex. zutto.co.jp --> www.zutto.co.jp ##
SUBDOMAIN_IS_XXX = false
MY_SUBDOMAIN = 'www'
TLD_LENGTH = 2 # ex. 'zutto.co.jp' is 2. 'hoge.com' is 1.

####### Simple Http Auth ###########
#
#BASIC_AUTHNTICATION_FLAG = false
#
####### Configuration of HTTPS ###########
#
#HOPPING_BETWEEN_HTTP_AND_HTTPS = ['hamamura', 'haruyama'].include?(Zutto::SvnUsername.username) ? false : true

####### Configuration of UFJ Nicos #######
#
#UFJ_NICOS_HOST_ADDRESS = 'test.digi-coin.com' # テスト
CA_FILE = case RUBY_PLATFORM
when /darwin/
  '/usr/share/curl/curl-ca-bundle.crt' # Mac OS X
when /freebsd/
  '/usr/ports/security/ca-roots/files/ca-root.crt'
when /linux/
  '/etc/pki/tls/certs/ca-bundle.crt'
else
  # 'c:\work\curl-ca-bundle.crt' # ... Windows
end

##### Configuration of e-mail ##########

# SEND_EMAIL_USING_PARALLEL_PROCESSING = true

my_email_address = "hokuyo@triton.ocn.ne.jp"
CONTACT_INQUIRY_RECIPIENTS =  "hokuyo@triton.ocn.ne.jp"


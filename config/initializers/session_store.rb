# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_socialnet_session',
  :secret      => '6c3ced350dd4d008c1fc0cc8e20e5e28bd708f61da2f1093b534ccfb28cdb445862e1e428a272e8a4fb1e67a6793d757551024e717aab1607a4e708d0ffd2c23'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

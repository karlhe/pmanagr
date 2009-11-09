# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_pmanagr_session',
  :secret      => '937b02526184d15fb0ffea2e29c3c2474a94e835cf60459048fc22f60ffd9dd9118efe41a9b8df345e347f147eb59f912f0709e0ec291edb19f40f15865f2b99'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

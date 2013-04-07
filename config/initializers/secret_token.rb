# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
# TODO secretize before deployment!
Ballyhoo::Application.config.secret_key_base = '783ee5c03cf84234be968b7e5eb90923e1f2eb5d89184d13d41d4b4ffd14f4f3649adb037d030c207c78fbab4aba6abfd557652cdc025971b3052e00828768c8'

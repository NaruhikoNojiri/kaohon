server '172.31.27.28', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/Users/nojiritoshihiko/.ssh/id_rsa'

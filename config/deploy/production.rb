server '176.9.25.194', roles: %w{app db web}, ssh_options: {
                           user: 'mkonin',
                           forward_agent: true,
                           password: fetch(:password),
                           auth_methods: %w(password)
                       }
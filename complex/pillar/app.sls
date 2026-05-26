app:
  user:
    name: appuser
    uid: 5000
    gid: 5000
    group: appgroup
    home: /home/appuser
  config:
    environment: production
    debug: False
    database:
      host: localhost
      port: 5432
      name: myapp_db
      user: myapp_user
      password: changeme_in_production
    secret_key: change_this_secret_key
    allowed_hosts:
      - example.com
      - www.example.com
    log_level: INFO

postgresql:
  version: 14
  data_dir: /var/lib/postgresql/14/main
  listen_addresses: localhost
  max_connections: 100
  shared_buffers: 128MB
  allowed_networks:
    - 127.0.0.1/32
    - ::1/128

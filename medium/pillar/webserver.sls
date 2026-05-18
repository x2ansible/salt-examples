nginx:
  worker_processes: 4
  worker_connections: 1024
  server_name: example.com
  port: 80
  root_path: /var/www/html

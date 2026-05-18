# Complex Salt Example

## Description
Full application stack deployment with database, application server, and reverse proxy. Demonstrates advanced Salt features and complex state orchestration.

## Features Demonstrated
- Multiple state files with dependencies
- `user.present` - User and group management
- `file.directory` - Directory creation
- `file.managed` - Configuration file management
- `file.recurse` - Recursive file deployment
- `pkg.installed` - Multiple package installation
- `service.running` - Multiple service management
- Jinja2 templating with filters
- Pillar data with complex structures
- Grains usage (system facts)
- State requisites (`require`, `watch`, `require_in`)
- State ordering and dependencies

## Files
- `salt/top.sls` - Top file defining state application
- `salt/users.sls` - User and group management
- `salt/postgresql.sls` - Database server configuration
- `salt/application.sls` - Application deployment
- `pillar/app.sls` - Application configuration data
- `templates/app_config.py.jinja` - Application configuration template
- `templates/pg_hba.conf.jinja` - PostgreSQL authentication template
- `files/app/` - Static application files

## What This Does
1. Creates application user and group
2. Installs and configures PostgreSQL database
3. Creates application directories
4. Deploys application files
5. Configures application with environment-specific settings
6. Manages multiple services with proper dependencies
7. Uses grains to make decisions based on OS

## State Execution Order
1. users.sls (creates app user)
2. postgresql.sls (requires user)
3. application.sls (requires user and database)

## Ansible Equivalent
Should convert to:
- Multiple roles (users, postgresql, application)
- Variables from pillar → vars/defaults
- Templates (.jinja → .j2)
- Handlers for service management
- Conditional tasks based on ansible_facts

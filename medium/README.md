# Medium Salt Example

## Description
Webserver configuration with package, service, and configuration file management.

## Features Demonstrated
- `pkg.installed` - Package installation
- `file.managed` - File management with templates
- `service.running` - Service state management
- Jinja2 templating
- Pillar data (configuration variables)
- State requisites (`require`, `watch`)

## Files
- `salt/webserver.sls` - Main state file for webserver setup
- `pillar/webserver.sls` - Pillar data with configuration variables
- `templates/nginx.conf.jinja` - Nginx configuration template

## What This Does
1. Installs nginx package
2. Creates nginx configuration from template with pillar data
3. Ensures nginx service is running and enabled
4. Restarts service when configuration changes

## Ansible Equivalent
Should convert to tasks using:
- `ansible.builtin.package`
- `ansible.builtin.template`
- `ansible.builtin.service`
- Handlers for service restart

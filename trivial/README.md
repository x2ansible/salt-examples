# Trivial Salt Example

## Description
Simplest possible Salt state - installs a single package.

## Features Demonstrated
- `pkg.installed` state
- Basic state file structure

## Files
- `salt/nginx.sls` - State file for nginx package installation

## What This Does
Ensures the nginx package is installed on the system.

## Ansible Equivalent
Should convert to:
```yaml
- name: Install nginx
  ansible.builtin.package:
    name: nginx
    state: present
```

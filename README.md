# Salt Examples

This folder contains synthetic Salt state examples used to develop and test the Salt-to-Ansible convertor.

| Example  | Complexity | Features Demonstrated | Description |
| -------- | ---------- | --------------------- | ----------- |
| trivial  | Simple | Basic package management | Single package installation using pkg.installed |
| medium   | Moderate | Package, service, file, template | Web server setup with config file and service management |
| complex  | Advanced | Multi-state, pillars, grains, requisites, orchestration | Full application stack with user management, multiple services, templating, and state dependencies |

## Example Structure

Each example follows standard Salt state tree structure:
- **salt/** - Contains state files (.sls)
- **pillar/** - Contains pillar data (configuration variables)
- **templates/** - Contains Jinja2 templates for configuration files

## Running Examples

These are synthetic examples for migration testing. To test with actual Salt:

```bash
# Test a single state
salt-call --local state.apply <state-name> --file-root=./salt --pillar-root=./pillar

# Example:
cd examples/salt-examples/medium
salt-call --local state.apply webserver --file-root=./salt --pillar-root=./pillar
```

{% set app_user = pillar['app']['user']['name'] %}
{% set app_home = pillar['app']['user']['home'] %}
{% set app_dir = app_home + '/app' %}

include:
  - users
  - postgresql

app_packages:
  pkg.installed:
    - pkgs:
      - python3
      - python3-pip
      - python3-venv
      - git

{{ app_dir }}:
  file.directory:
    - user: {{ app_user }}
    - group: {{ pillar['app']['user']['group'] }}
    - mode: 755
    - makedirs: True
    - require:
      - user: appuser

{{ app_dir }}/config:
  file.directory:
    - user: {{ app_user }}
    - group: {{ pillar['app']['user']['group'] }}
    - mode: 750
    - require:
      - file: {{ app_dir }}

{{ app_dir }}/logs:
  file.directory:
    - user: {{ app_user }}
    - group: {{ pillar['app']['user']['group'] }}
    - mode: 755
    - require:
      - file: {{ app_dir }}

{{ app_dir }}/static:
  file.recurse:
    - source: salt://files/app/static
    - user: {{ app_user }}
    - group: {{ pillar['app']['user']['group'] }}
    - file_mode: 644
    - dir_mode: 755
    - require:
      - file: {{ app_dir }}

{{ app_dir }}/config/settings.py:
  file.managed:
    - source: salt://templates/app_config.py.jinja
    - template: jinja
    - user: {{ app_user }}
    - group: {{ pillar['app']['user']['group'] }}
    - mode: 640
    - require:
      - file: {{ app_dir }}/config

{{ app_dir }}/venv:
  virtualenv.managed:
    - python: /usr/bin/python3
    - user: {{ app_user }}
    - require:
      - pkg: app_packages
      - file: {{ app_dir }}

app_dependencies:
  pip.installed:
    - requirements: salt://files/app/requirements.txt
    - bin_env: {{ app_dir }}/venv
    - user: {{ app_user }}
    - require:
      - virtualenv: {{ app_dir }}/venv

/etc/systemd/system/myapp.service:
  file.managed:
    - source: salt://templates/myapp.service.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644

myapp_service:
  service.running:
    - name: myapp
    - enable: True
    - require:
      - file: /etc/systemd/system/myapp.service
      - pip: app_dependencies
      - service: postgresql_service
      - file: {{ app_dir }}/config/settings.py
    - watch:
      - file: {{ app_dir }}/config/settings.py
      - file: /etc/systemd/system/myapp.service

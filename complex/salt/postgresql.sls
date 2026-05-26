{% set pg_version = pillar['postgresql']['version'] %}
{% set pg_data_dir = pillar['postgresql']['data_dir'] %}

postgresql_packages:
  pkg.installed:
    - pkgs:
      - postgresql-{{ pg_version }}
      - postgresql-contrib-{{ pg_version }}
      - python3-psycopg2

{{ pg_data_dir }}:
  file.directory:
    - user: postgres
    - group: postgres
    - mode: 700
    - makedirs: True
    - require:
      - pkg: postgresql_packages

/etc/postgresql/{{ pg_version }}/main/pg_hba.conf:
  file.managed:
    - source: salt://templates/pg_hba.conf.jinja
    - template: jinja
    - user: postgres
    - group: postgres
    - mode: 640
    - require:
      - pkg: postgresql_packages

postgresql_service:
  service.running:
    - name: postgresql
    - enable: True
    - require:
      - pkg: postgresql_packages
      - file: {{ pg_data_dir }}
    - watch:
      - file: /etc/postgresql/{{ pg_version }}/main/pg_hba.conf

{% if grains['os_family'] == 'Debian' %}
postgresql_repository:
  pkgrepo.managed:
    - name: deb http://apt.postgresql.org/pub/repos/apt {{ grains['oscodename'] }}-pgdg main
    - key_url: https://www.postgresql.org/media/keys/ACCC4CF8.asc
    - require_in:
      - pkg: postgresql_packages
{% endif %}

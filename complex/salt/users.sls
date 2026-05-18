appgroup:
  group.present:
    - name: {{ pillar['app']['user']['group'] }}
    - gid: {{ pillar['app']['user']['gid'] }}

appuser:
  user.present:
    - name: {{ pillar['app']['user']['name'] }}
    - uid: {{ pillar['app']['user']['uid'] }}
    - gid: {{ pillar['app']['user']['gid'] }}
    - home: {{ pillar['app']['user']['home'] }}
    - shell: /bin/bash
    - createhome: True
    - require:
      - group: appgroup

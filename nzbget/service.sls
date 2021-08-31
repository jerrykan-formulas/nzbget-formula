{%- from "nzbget/map.jinja" import nzbget with context -%}

include:
  - nzbget.config

nzbget-user:
  user.present:
    - name: {{ nzbget.user }}
    - home: {{ nzbget.data_dir }}
    - createhome: False
    - shell: /usr/sbin/nologin
    - system: True

nzbget-data-dir:
  file.directory:
    - name: {{ nzbget.data_dir }}
    - user: {{ nzbget.user }}
    - group: {{ nzbget.user }}
    - require:
      - user: nzbget-user

nzbget-log-dir:
  file.directory:
    - name: {{ nzbget.log_dir }}
    - user: {{ nzbget.user }}
    - group: {{ nzbget.user }}
    - require:
      - user: nzbget-user

nzbget-service-file:
  file.managed:
    - name: /etc/systemd/system/{{ nzbget.service }}.service
    - source: salt://nzbget/files/nzbget.service.jinja
    - template: jinja

nzbget-service:
  service.running:
    - name: {{ nzbget.service }}
    - enable: True
    - require:
      - file: nzbget-service-file
      - file: nzbget-config-file
      - file: nzbget-data-dir
      - file: nzbget-log-dir

nzbget-restart:
  module.wait:
    - name: service.restart
    - m_name: {{ nzbget.service }}
    - require:
      - service: nzbget-service
    - watch:
      - file: nzbget-config-file

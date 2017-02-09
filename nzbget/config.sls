{%- from "nzbget/map.jinja" import nzbget with context -%}

include:
  - nzbget

nzbget-config-dir:
  file.directory:
    - name: {{ nzbget.config_dir }}

nzbget-config-file:
  file.managed:
    - name: {{ nzbget.config_file }}
    - source: salt://nzbget/files/nzbget.conf.jinja
    - template: jinja
    - require:
      - file: nzbget-config-dir

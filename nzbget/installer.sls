{%- from "nzbget/map.jinja" import nzbget with context -%}

include:
  - nzbget.install.installer
  - nzbget.service

extend:
  nzbget-service-file:
    file:
      - context:
          nzbget_bin: {{ nzbget.install_dir }}/nzbget

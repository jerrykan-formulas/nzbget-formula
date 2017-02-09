{%- from "nzbget/map.jinja" import nzbget with context -%}

nzbget-package:
  pkg.installed:
    - name: {{ nzbget.package }}

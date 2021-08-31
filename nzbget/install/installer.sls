{%- from "nzbget/map.jinja" import nzbget with context -%}

{%- set installer = '/tmp/nzbget-installer' -%}

nzbget-installer:
  file.managed:
    - name: {{ installer }}
    - source: {{ nzbget.installer }}
{%- if nzbget.installer_hash %}
    - source_hash: {{ nzbget.installer_hash }}
{%- else %}
    - skip_verify: True
{%- endif %}
    - mode: 755
    - unless: test -f {{ nzbget.install_dir }}/nzbget

nzbget-run-installer:
  cmd.run:
    - name: {{ installer }} --silent --destdir {{ nzbget.install_dir }}
    - unless: test -f {{ nzbget.install_dir }}/nzbget
    - require:
      - file: nzbget-installer

nzbget-remove-installer:
  file.absent:
    - name: {{ installer }}
    - onlyif: test -f {{ nzbget.install_dir }}/nzbget
    - require:
      - cmd: nzbget-run-installer

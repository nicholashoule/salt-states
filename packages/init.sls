# module: packages: init
# state.apply packages
#
# Pillar:
# /pkgs/init.sls
#
# Description:
# Ensure common packages are installed and configured
{% for item, v in pillar['pkgs'].items() %}
{{ item }}: 
 pkg.installed: []
     
{% endfor %}

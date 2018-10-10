# module: users: init
# state.apply users
#
# Pillar:
# /users/init.sls
#
# Description:
# module for adding default users w/ ssh-keys
{% for user, args in pillar['users'].iteritems() %}
{{ user }}:
  group.present:
    - system: True
  user.present:
    - fullname: {{ args['fullname'] }}
    - password: {{ args['password'] }}
    - shell: {{ args['shell'] }}
    - enforce_password: True
    {% if not user == 'root' %}
    - groups:
      - {{ user }}
      - adm
      - sudo
    {% endif %}
    
{% if 'ssh-keys' in args %}
# Users to manage w/ssh-keys
{{ user }}-sshkey:
  ssh_auth.present:
    - user: {{ user }}
    - config: '%h/.ssh/authorized_keys'
    - names:
      {% for key in args['ssh-keys'] %}
      - {{ key }}
      {% endfor %}
      
{% endif %}
{% endfor %}

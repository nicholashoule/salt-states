# Instruct each minion to sync custom grains when it starts
sync_grains:
  local.saltutil.sync_grains:
    - tgt: {{ data['id'] }}
    

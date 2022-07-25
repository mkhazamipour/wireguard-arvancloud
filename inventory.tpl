all:
  vars:
    ansible_user: root
    resolveconf_server: 1.1.1.1
  children:
    wireguard:
        hosts: %{ for ip in wireguard_server ~}${ip}%{ endfor ~}
        
        vars:
          ansible_user: ubuntu
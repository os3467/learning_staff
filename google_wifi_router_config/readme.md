connect to router using ssh:
```
ssh root@192.168.*.1
```

than update router openwrt packages
```
opkg update
```

now install nano and bash
```
opkg install nano
opkg install bash
```

now create a file using nano and copy the scripts into it and run them with bash.
after first script the router address will be change to 192.168.40.1 (remember this for second ssh connection)

goodluck.

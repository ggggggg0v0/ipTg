# ipTg

send IP to telegram bot

1. chmod +x ./update_ip

2. set config.yaml
```
token: xxx
chat_id: xxx
noip_user: 
noip_pwd: 
noip_hostname: 
```

3. set crontab `crontab -e``

```
@reboot /path/to/your/script.sh
*/5 * * * * /path/to/your/script.sh
```

## troubleshooting

### check cron log 

`grep CRON /var/log/syslog`


### (CRON) info (No MTA installed, discarding output)

redirect log

```
*/5 * * * * /path/to/your/script.sh > /path/to/output.log 2>&1
```

When someone is trying to brute force your host system, you maybe want to reboot the system so the Passprase of your Geli Encryption container needs to be entered.

Use the following LCI to run it:
/usr/local/bin/check_failed_logins.sh 20 "/var/log/failed_login_monitor.log"

Or Put rhis in your crontab:
0,30 *  *  *    *    /usr/local/bin/check_failed_logins.sh 20 "/var/log/failed_login_monitor.log"

Also clear the logs with:
vi /etc/newsyslog.conf

Add the following line:
/var/log/failed_login_monitor.log       640  7     1000 *     JC

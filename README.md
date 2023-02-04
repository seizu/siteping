siteping
========

Siteping is a tiny bash script for monitoring hosts, it notifies you when a host is unavailable.
The notification is using the Telegram-Bot API. Before you can use it, create your personal Telegam-Bot token.

More information: https://core.telegram.org/bots

Installation
------------
1) Install it on your Raspberry PI or your preferred Linux operating system. 
2) Copy the scripts into YOUR_HOME_DIR (or elsewhere) be sure that the directory is writable.
3) Grant execution rights to both scripts
```
   sudo chmod 755 siteping.sh
   sudo chmod 755 tpush.sh
```   
4) Edit tpush.sh and replace YOUR_TOKEN with your Telegram-Bot token and the chatId with your chatId.  
   a) to get the chatId add the Telegram BOT to the your group
   b) post a message in your group
   c) open `https://api.telegram.org/bot<YOUR_TOKEN>/getUpdates` in a browser  
   d) copy the chat:id<YOUR CHAT ID> from the json respons.  
      If you get an empty result, add the bot again to the group.

5) Edit siteping.sh and add new host names or change the existing host names for your needs.
   Don't remove the default counter value 1 at the end of each host name.
   If you do not want to receive a notification every hour, change the default counter value to 5 
6) Add siteping.sh as cronjob to run as background process. Edit the crontab
```
   sudo crontab -e
```   
7) Add these lines and save your crontab 
```
   @reboot /YOUR_HOME_DIR/siteping.sh &
   0 * * * *  /YOUR_HOME_DIR/siteping.sh &
```
8) Test the notification script, go to your home dir an run the tpush.sh script
```
   cd /YOUR_HOME_DIR
   ./tpush.sh "hello world"
```
9) If your Telegram app does not receive your message, check the above steps again.

Default setting of siteping.sh
```
count=5       (Sends a notification every 60 seconds 5 times when a host is down or unavailable.)
interval=60   (Checks the host list every 60 seconds) 
timeout=1     (ping timeout 1 second)
```

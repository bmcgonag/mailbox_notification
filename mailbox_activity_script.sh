#!/bin/bash

# first check if wireless is connected.
while [  iwgetid = "" ]; do
             echo "No WIfi"
         done

# make sure to install "ntfy" for sending notifications

# you can modify this command to send a notification to any service
# that ntfy supports.   I have just defaulted it to Telegram.
#
# If you use telegram, you'll want to find BotFather, and go through
# te steps to create a bot.

ntfy -b telegram send "Mailbox Opened!"

# after sending the message, wait 30 seconds, then shutdown the 
# raspberry pi zero w until the next time the mailbox is open.

sleep 30s

sudo shutdown -h now

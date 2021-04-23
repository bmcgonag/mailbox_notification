# Mailbox Notifications

A simple, wifi based, notification system for your physical mailbox.  

I'm sure this is a niche ttat very few fall into, but my mailbox is a bit far from my front door, and my ring camera doesn't catch the postal worker when he comes to deliver the mail. 

Rather than travel down to the box several times a day, I used this to send me a simple "Mailbox Activity" notification when the box is opened.

## Software you'll need
- this repository (specifically the .sh and .service files).
- Ntfy - a cli tool for sending notifications to various services. https://ntfy.readthedocs.io/en/latest/
- A Raspberry PI (zer w preferred, but any wifi capable pi can work).  
- A battery power supply
- A wifi signal that can be picked up from wherever this is placed. 
- A magnetic switch that can work with a Normally Open circuit.
- An SD Card that can hold Raspberry PI OS Lite (no Desktop / UI).

## Process
1. Install Raspberry Pi OS lite on your SD card.  Use a tool like Balena Etcher to do this. 
2. Setup your PI to have wireless access to your network, and make sure to give yourself SSH access. 
   a. Wifi Access - You need to create a wpa_supplicant.conf file in the "boot" folder of the SD Card before you put it in the PI for the first time.

wpa_supplicant.conf
```
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=<your two character country code, e.g. UK, US, etc>

network={
     ssid="<your wireless ssid (network name)>"
     psk="<your wireless network password>"
     key_mgmt=WPA-PSK
}
```
   b. SSH Access - Create an empty file simply named "SSH" in the "boot" folder of the SD Card before you use it in the PI for the first time.

4. Eject your SD Card from your computer, and put it in the pi, and boot.  Give it about 3 minutes to boot, then find the IP for the Pi on your network. You can use a tool like AngryIPScanner for this, or check your Wireless router control software. 
5. ssh into your Pi, `ssh pi@<your local ip>`, and enter the password 'raspberry'. 
6. Once logged in, you can run `sudo raspi-config` and change any configs you want from there. 
7. Once logged in, type `passwd` into the terminal. Enter the current password 'raspberry', and then enter a new password twice to change the password for accessing your pi.
8. Now, you can copy the files from the repo into the pi.

`scp mailbox_activity_script.sh pi@<your local pi ip address>:~/`
`scp sendMailboxAct.service pi@<your local pi ip address>:~/`

9. Once copied over, ssh back into your pi.
10. Install Ntfy on your pi.
11. Open the mailbox_acitivy_script.sh file and make sure to setup Ntfy to use the service you prefer (if not Telegram). 

You can test the send using Ntfy by just copying and pasting the command into an empty terminal 

Once working, and sedning the message, you can save it to your .sh file.

12. Now, take the sendMailboxAct.service file, and move it to /etc/systemd/system/
13. You may need to change the permissions to make it executable `sudo chmod +x /etc/systemd/system/sendMailboxAct.service`
14. Start the service with `sudo systemctl start sendMailboxAct`

NOTE: be ready, when it starts, it will send a message and shutdown the pi.

Now setup your pi to work off of the magnetic switch, so when it closes (the two magnets come together) the pi starts, sends the message then shuts back down.


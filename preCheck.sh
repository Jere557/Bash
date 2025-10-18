#!/bin/bash
fileDate=$(date +%Y-%m-%d_-_%H:%M:%S)
filename=preCheck-$(hostname)-$fileDate.html
dirPath="/home/$(whoami)/Reports/"
if [ ! -d "$dirPath" ]; then
    mkdir ~/Reports/
fi 
title_Output=$(echo "Pre-Upgrade Report for $(hostname)")
uptime_Output=$(echo -e "$(hostname) has been $(uptime -p); since $(uptime -since)")
#lsblk_Output=$(lsblk)
#fstab_Output=$(cat /etc/fstab)
#os_Output=$(cat /etc/os-release)
#uname_Output=$(uname -r)
#df_Output=$(df -h)
#free_Output=$(free -gh)
#route_Output=$(route -n)
#int_Output=(ifconfig -a)

cat << EOF > $dirPath$filename
<!DOCTYPE html>
<html>
<head>
    <title>$title_Output</title>
</head>
<body>
<h1>$(hostname) Details</h1>
<h2>Uptime:</h2>
<pre>$uptime_Output</pre>
<h2>List of Block Devices</h2>
<pre>$(lsblk)</pre>
<h2>List of Accessible Filesystems</h2>
<pre>$(cat /etc/fstab)</pre>
<h2>OS Information</h2>
<pre>$(cat /etc/os-release)</pre>
<h2>Kernel Release</h2>
<pre>$(uname -r)</pre>
<h2>Disk Space Usage</h2>
<pre>$(df -h)</pre>
<h2>Memory Usage</h2>
<pre>$(free -gh)</pre>
<h2>Route Table</h2>
<pre>$(route -n)</pre>
<h2>Interface Details</h2>
<pre>$(ifconfig -a)</pre>
</body>
</html>
EOF
echo "$dirPath$filename has been created."
cat $dirPath$filename
echo "Launching Firefox..."
firefox $dirPath$filename

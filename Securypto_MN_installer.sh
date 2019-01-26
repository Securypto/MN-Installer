#!/bin/bash


#MN Script v1.0.0
#change as needed
linuxversion="64"



securyptodir=~/.securypto
filecurrentwallet="securypto-current-wallet-linux"$linuxversion".tar.gz"
bootstrapfile=securypto-current-bootstrap.zip
cdnurl=https://cdn1.securypto.io/


cat << "EOF"
   _____  ______  _____  _    _  _____ __     __ _____  _______  ____  
  / ____||  ____|/ ____|| |  | ||  __ \\ \   / /|  __ \|__   __|/ __ \ 
 | (___  | |__  | |     | |  | || |__) |\ \_/ / | |__) |  | |  | |  | |
  \___ \ |  __| | |     | |  | ||  _  /  \   /  |  ___/   | |  | |  | |
  ____) || |____| |____ | |__| || | \ \   | |   | |       | |  | |__| |
 |_____/ |______|\_____| \____/ |_|  \_\  |_|   |_|       |_|   \____/ 
                                                                       
                                                                       
EOF


cat << "EOF"
#################################################################
#################################################################
EOF

if [ -d "$securyptodir" ]; then
echo "
WARNING:
I see that dir "$securyptodir" exist.
So you have already a wallet or a Masternode installation here.
If you are running this on your Desktop where your Securypto wallet has been installled:
ABORT NOW BEFORE I DELETE EVERYTHING, INCLUDING YOUR PRIVATEKEYS! 
"
fi
echo "
If you are running this installer on a VPS to install a Masternode, congratulations I am here to help :)
I can create a new or upgrading your current installation.
I will delete any previous installations and create a fresh install.
"
cat << "EOF"
#################################################################
#################################################################
EOF

echo "
To proceed, please type YES and press Enter
To abort, just press Enter
"

read canproceed

if [ "$canproceed" != "YES" ] ; then
exit
fi


masternodeipfinded=`dig @ns1-1.akamaitech.net ANY whoami.akamai.net +short`
echo ""
echo ""
echo "Please enter the Masternode IP and press Enter."
echo "I think its:" $masternodeipfinded 
echo "Type YES if my guess is correct or just type the correct IP and then press Enter."
read masternodeip
if [ "$masternodeip" = "YES" ]; then
masternodeip=$masternodeipfinded
fi 

echo ""
echo ""
echo "Please enter your masternodeprivkey and press Enter."
read masternodeprivkey


if [ "$canproceed" = "YES" ] && [ ! -z "$masternodeprivkey" ] && [ ! -z "$masternodeip" ] ; then


cat << "EOF"
#################################################################
#################################################################
        I N S T A L L A T I O N      P L A S E   W A I T
#################################################################
#################################################################
EOF



rm $bootstrapfile 2> /dev/null
rm $filecurrentwallet 2> /dev/null
rm -rf "tmpdir" 2> /dev/null
rm -rf "$securyptodir" 2> /dev/null
rm -rf "bin" 2> /dev/null
mkdir "bin"


wget -N $cdnurl$bootstrapfile --no-check-certificate
apt install unzip
unzip $bootstrapfile -d $securyptodir


wget -N $cdnurl$filecurrentwallet --no-check-certificate
mkdir tmpdir && tar zxvf $filecurrentwallet -C $_
mv -f tmpdir/*/* .


rm $bootstrapfile 2> /dev/null
rm $filecurrentwallet 2> /dev/null
rm -rf "tmpdir" 2> /dev/null
rm Start_Wallet.sh 2> /dev/null


#./bin/securypto-qt
#Software have been installed. Lets do the config

random1=`openssl rand -base64 15`
random2=`openssl rand -base64 15`



echo "rpcuser="$random1"" > $securyptodir/securypto.conf
echo "rpcpassword="$random2"" >> $securyptodir/securypto.conf
echo "rpcallowip=127.0.0.1" >> $securyptodir/securypto.conf
echo "server=1" >> $securyptodir/securypto.conf
echo "daemon=1" >> $securyptodir/securypto.conf
echo "logtimestamps=1" >> $securyptodir/securypto.conf
echo "maxconnections=256" >> $securyptodir/securypto.conf
echo "masternode=1" >> $securyptodir/securypto.conf
echo "externalip="$masternodeip"" >> $securyptodir/securypto.conf
echo "masternodeprivkey="$masternodeprivkey"" >> $securyptodir/securypto.conf




#Didnt type YES
else
echo "Sorry, you have input wrong infos, please try again."
exit
fi







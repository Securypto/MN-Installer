#####################################
HOW TO INSTALL A SECURYPTO MASTERNODE
#####################################

Steps 1-5 & 8 will be excuted on your desktop wallet.
Steps 6-7 will be excuted on your VPS.

###################################################################
###################################################################

Note: On your desktop start your wallet and disable auto zSCU minter during this setup to prevent autominting of your masternode collateral.
You can disable autominting in the option menu BEFORE unlocking your wallet if its encrypted.
Restart the wallet and check if autominting is disabled.

1) 
First we need to create a masternode’s privkey. We’ll use this later… 
Using the control wallet, go to Tools > Debug console and type the following command:

masternode genkey

2)
Stay in the Debug console, choose a name for your Masternode and type the following command.
getaccountaddress MyMasternode1

3)
Now send 10,000 SCU to the address you generated in step 2.
Be 100% sure that you entered the address correctly
We cannot help you, if you send 10,000 SCU to an incorrect address.
Send exactly 10,000 SCU, No less, no more.

4)
Now in the Debug console type the following command and save the output. We’ll also use this later… 
masternode outputs

5)
Go to tools > Open Masternode Configuration file and add this lines:
<Name of Masternode from step 2> <IP of your Masternode>:51472 <privkey from Step 1> <Output of Step 4> <Outpiutindex from Step 4>
So it will looks like this:
MN1 31.14.135.27:9996 892WPpkqbr7sr6Si4fdsfssjjapuFzAXwETCrpPJubnrmU6aKzh c8f4965ea57a68d0e6dd384324dfd28cfbe0c801015b973e7331db8ce018716999 1

Note: Its one big line, no line break!


6)
SSH login to your VPS and excute this commmands. Installer will guide you further.
(Use putty if you are on windows, https://www.putty.org/)

Type and then press Enter: ssh root@ipadres-of-your-vps
Type and then press Enter: your vps passwoord
Type and then press Enter: cd /root
Type and then press Enter: bash <(wget -O- https://raw.githubusercontent.com/Securypto/MN-Installer/master/Securypto_MN_installer.sh)


8)
Go back to your wallet.
On the vertical tab left click on Masternodes and then Start all
If you cant see the Masternodes tab, go to Settings > options > wallet and check "Show Masternodes Tab"


###################################################################
###################################################################
Note: It takes a while till your masternode has been synced to the network.
You can check the progress by comparing your current Masternode block against the live block count on https://explorer.securypto.io/
It should be the same or have a small diffrent of couple of blocks max.
Type and then press Enter: /root/bin/securypto-cli getinfo



If you want to check the status of your masternode, login to your VPS again.
Type and then press Enter: /root/bin/securypto-cli masternode status
###################################################################
###################################################################


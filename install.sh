########################################################
#  Installation Automatisée de Splunk
#
#JTT15 20251129
########################################################



#VAriable d'environnement#
export SPLUNK_HOME=/opt/splunk

#récupération et installation des sources
wget -O splunk-10.0.2-e2d18b4767e9-linux-amd64.deb "https://download.splunk.com/products/splunk/releases/10.0.2/linux/splunk-10.0.2-e2d18b4767e9-linux-amd64.deb"
apt install -y ./splunk-10.0.2-e2d18b4767e9-linux-amd64.deb

#premier lancement de plunk
$SPLUNK_HOME/bin/splunk start --no-prompt --answer-yes --accept-license

#Modification des droits sur le dossier de splunk:
chown splunk  /opt/splunk -R

#Arret 
$SPLUNK_HOME/bin/splunk stop

#Création du user admin
cat <<'EOF' > $SPLUNK_HOME/etc/system/local/user-seed.conf
[user_info]
USERNAME = admin
PASSWORD = InitPwd2025!
EOF

#Mise en place du démarrage du service splunk en automatique
$SPLUNK_HOME/bin/splunk enable boot-start -user splunk


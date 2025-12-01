########################################################
#  Installation Automatisée de Splunk
#
#JTT15 20251129
########################################################



#VAriable d'environnement#
export SPLUNK_HOME=/opt/splunk

#récupération et installation des sources
wget -O splunk-10.0.2-e2d18b4767e9-linux-amd64.deb "https://download.splunk.com/products/splunk/releases/10.0.2/linux/splunk-10.0.2-e2d18b4767e9-linux-amd64.deb"
sudo apt install -y ./splunk-10.0.2-e2d18b4767e9-linux-amd64.deb

echo "Splunk install ok"
#premier lancement de plunk
sudo $SPLUNK_HOME/bin/splunk start --no-prompt --answer-yes --accept-license


#Arret 
sudo $SPLUNK_HOME/bin/splunk stop

echo "admin user creation"
#Création du user admin
cat <<'EOF' > $SPLUNK_HOME/etc/system/local/user-seed.conf
[user_info]
USERNAME = admin
PASSWORD = InitPwd2025!
EOF

echo "auto start"
#Mise en place du démarrage du service splunk en automatique
$SPLUNK_HOME/bin/splunk enable boot-start -user splunk

echo "update rights on /opt/splunk"
#Modification des droits sur le dossier de splunk:
sudo chown splunk  /opt/splunk -R
exit 0
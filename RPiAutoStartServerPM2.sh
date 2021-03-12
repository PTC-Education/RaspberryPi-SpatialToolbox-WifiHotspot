echo "RPiToolbox - install pm2";
sudo npm install -g pm2;
sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u pi --hp /home/pi;
echo "RPiToolbox - starting server";
cd /home/pi/vuforia-spatial-edge-server;
pm2 start server.js;
cd ..;
echo "RPiToolbox - pm2 save";
pm2 save;
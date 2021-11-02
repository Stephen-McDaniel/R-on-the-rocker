# rserver.conf update
rm /etc/rstudio/rserver.conf
cp /etc/rstudio/disable_auth_rserver.conf /etc/rstudio/rserver.conf

#rsession-which-r=/usr/local/bin/R
#auth-none=1

# USER environment update
echo "USER=rstudio" >> /etc/environment

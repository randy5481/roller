export rcstring=""
export vstring="5.0.4"

gpg --armor --detach-sig weblogger-assembly/target/roller-weblogger-${vstring}${rcstring}-for-jboss.tar.gz
gpg --armor --detach-sig weblogger-assembly/target/roller-weblogger-${vstring}${rcstring}-for-jboss.zip

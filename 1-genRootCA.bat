@echo off

set /p CA_NAME=Enter CA name: 

mkdir %CA_NAME%\private
mkdir %CA_NAME%\req
mkdir %CA_NAME%\cert
mkdir %CA_NAME%\certsdb
mkdir %CA_NAME%\p12

copy template\openssl.conf %CA_NAME%\ 
copy template\index.txt %CA_NAME%\
copy template\genCert.bat %CA_NAME%\
copy template\genCA.bat %CA_NAME%\

cd %CA_NAME%
openssl req -new -newkey rsa:4096 -keyout "private/ca.pem" -out "req/ca.csr" -config "openssl.conf" -nodes
openssl ca -create_serial -out "cert/ca.cer" -days 1500 -keyfile "private/ca.pem" -selfsign -extensions v3_ca -config "openssl.conf" -infiles "req/ca.csr"
cd ..

pause
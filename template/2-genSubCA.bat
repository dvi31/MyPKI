@echo off

set /p CA_NAME=Enter CA name: 

mkdir %CA_NAME%\private
mkdir %CA_NAME%\req
mkdir %CA_NAME%\cert
mkdir %CA_NAME%\certsdb
mkdir %CA_NAME%\p12

copy openssl.conf %CA_NAME%\ 
copy index.txt %CA_NAME%\
copy genCert.bat %CA_NAME%\
copy genCA.bat %CA_NAME%\

cd %CA_NAME%
openssl genrsa -out "private/ca.pem"
openssl req -new -key "private/ca.pem" -out "../req/ca.csr" -config openssl.conf
openssl ca -create_serial -out "cert/ca.cer" -days 1500 -keyfile "private/ca.pem" -selfsign -extensions v3_ca -config "openssl.conf" -infiles "req/ca.csr"
cd ..

pause
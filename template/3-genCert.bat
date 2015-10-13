@echo off

set /p CERT_NAME=Enter certificate name: 

openssl genrsa -out private\%CERT_NAME%.pem -f4 2048
openssl req -new -key private\%CERT_NAME%.pem -out req\%CERT_NAME%.csr -config openssl.conf
openssl ca -create_serial -out cert\%CERT_NAME%.cer -days 365 -extensions v3_req -config openssl.conf -infiles req\%CERT_NAME%.csr
openssl pkcs12 -export -in cert\%CERT_NAME%.cer -inkey private\%CERT_NAME%.pem -out p12\%CERT_NAME%.p12 -name %CERT_NAME%

pause
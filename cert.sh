sudo apt install tree openssl  wget
---------------------rootca----------------
mkdir ca
cd ca
mkdir -p certs crl newcerts private subca/csr subca/certs
touch index.txt
touch index.txt.attr
echo 1000 > serial
echo 1000 > crlnumber


openssl genrsa -aes256 -out private/ca.key.pem 4096
chmod 400 private/ca.key.pem
# wget ----- rootca.cnf
openssl req  -config rootca.cnf -key private/ca.key.pem -new -x509 -days 7300 -sha256 -extensions v3_ca -out certs/ca.cert.pem

----------------subca--------------------
mkdir subca
mkdir -p certs crl newcerts private csr
touch index.txt
touch index.txt.attr
echo 1000 > serial
echo 1000 > crlnumber
 

openssl genrsa -aes256 -out private/subca.key.pem 4096
chmod 400 private/subca.key.pem

openssl req  -config subca.cnf -new -sha256  -key private/subca.key.pem  -out csr/subca.csr.pem
----------------------rootca----------------------
#copy csr of sub in the /ca/subca/csr/....

openssl ca  -config rootca.cnf -extensions v3_intermediate_ca  -days 7300 -notext -md sha256 -in subca/csr/subca.csr.pem -out subca/certs/subca.cert.pem

#copy in the subca from rootca certificate
sudo cp ../ca/subca/certs/subca.cert.pem certs/
----------------------user-------------------------
mkdir user
cd user
 openssl genrsa -out shuhari.local.key.pem 2048
 chmod 400 shuhari.local.key.pem

openssl req  -config subca.cnf   -key shuhari.local.key.pem -new -sha256  -out shuhari.local.csr.pem

---------------in the subca --------------
#copy of user csr in the subca/csr/
sudo cp ../user/shuhari.local.csr.pem csr/

 openssl ca  -config subca.cnf -extensions server_cert  -days 7300 -notext -md sha256 -in csr/shuhari.local.csr.pem -out certs/shuhari.local.cert.pem

-------------in the user --------------
#copy all in the user
cat shuhari.local.cert.pem subca.cert.pem ca.cert.pem > shuhari.local.cert.chain.pem

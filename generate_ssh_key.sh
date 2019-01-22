# Go to test directory and run the script below to generate SSH key.
cd test

# Generate a 4096 bit RSA key with a blank passphrase in the directory
ssh-keygen \
  -b 4096 \
  -C "Kitchen-Terraform AWS provider tutorial" \
  -f test/assets/key_pair \
  -N "" \
  -t rsa

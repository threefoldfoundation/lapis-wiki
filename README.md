# lapis-wiki

# Installation

**Lua**

- `sudo apt install luarocks`

**Openresty**

- `wget -qO - https://openresty.org/package/pubkey.gpg | sudo apt-key add -`
- `sudo apt-get -y install software-properties-common`
- `sudo add-apt-repository -y "deb http://openresty.org/package/ubuntu $(lsb_release -sc) main"`
- `sudo apt-get update`
- `sudo apt-get install openresty`

**Lapis**

- `luarocks install lapis`

# Requirements
- `luarocks install --server=http://rocks.moonscript.org/manifests/leafo lapis-redis`



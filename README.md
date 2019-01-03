# lapis-wiki

# Installation

**Redis**
- `sudo apt install redis-server redis-cli`

**Lua**

- `sudo apt install luarocks moonscript`

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

# Prerequisites
- Make sure weblibc is up2date
    - clone/update the repo `ssh://git@github.com/threefoldtech/jumpscale_weblibs.git` i.e in `~/code/github/threefoldtech/jumpscale_weblibs`

- Make sure you have a symlink in lapius-wiki/static for weblibc
  - in lapis-wiki directory `cd static && ln -s ~/code/github/threefoldtech/jumpscale_weblibs/weblibc weblibc`

- Make sure redis is running `service redis-server start`

# Running

- Run server `lapis server`

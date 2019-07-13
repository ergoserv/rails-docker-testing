apt-get update -qq

apt-get install -y nodejs postgresql-client

# zsh setup
apt-get install -y zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

rm -rf /var/lib/apt/lists/*

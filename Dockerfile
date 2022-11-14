FROM ubuntu

COPY init.lua /
COPY plugins.lua /
COPY snippets /

RUN \
apt update; \
apt-get install -y software-properties-common git fzf curl; \
apt-get install -y build-essential libffi-dev libssl-dev zlib1g-dev liblzma-dev libbz2-dev libreadline-dev libsqlite3-dev wget; \
git clone https://github.com/pyenv/pyenv.git ~/.pyenv; \
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc; \
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc; \
echo 'eval "$(pyenv init -)"' >> ~/.bashrc; \
source ~/.bashrc; \
pyenv install 3.9.15; \
pyenv global 3.9.15; \
pip install neovim; \
apt-add-repository --yes ppa:neovim-ppa/stable; \
git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv; \
eval "$(pyenv virtualenv-init -)" >> ~/.bashrc; \
source ~/.bashrc; \
pyenv virtualenv 3.9.15 py_env; \
pyenv global py_env; \
apt-get install -y neovim; \
mkdir -p ~/.config/nvim/lua; \
mv /init.lua ~/.config/nvim/; \
mv /plugins.lua ~/.config/nvim/lua/; \
mv /snippets ~/.config/nvim/; \
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim; \
mkdir -p ~/.local/share/fonts; \
cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf; \
cd ~ \


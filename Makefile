.PHONY: all

. := $(PWD)

all: zsh-precheck cli dotfiles editorconfig git ideavim neovim tmux vim zsh
dotfiles:
	[ -e $(HOME)/.dotfiles ] || ln -sf $(.) $(HOME)/.dotfiles
editorconfig:
	ln -sf $(.)/.editorconfig $(HOME)
git:
	ln -sf $(.)/.gitconfig $(.)/.gitignore $(.)/.tigrc $(HOME)
ideavim:
	ln -sf $(.)/.vimrc $(HOME)/.ideavimrc
neovim:
	mkdir -p $(HOME)/.config/nvim
	ln -sf $(.)/.vimrc $(HOME)/.config/nvim/init.vim
	ln -sf $(.)/dein.toml $(.)/dein_lazy.toml $(HOME)/.config/nvim/
shell:
	ln -sf $(.)/.profile $(.)/.bashrc.extra $(.)/.bashrc.alias $(.)/.bashrc.post $(HOME)
tmux:
	git -C $(HOME)/.tmux/plugins/tpm pull || git clone https://github.com/tmux-plugins/tpm $(HOME)/.tmux/plugins/tpm
	ln -sf $(.)/.tmux.conf $(HOME)
vim:
	ln -sf $(.)/.vimrc $(.)/dein.toml $(.)/dein_lazy.toml $(HOME)
zsh: zsh-precheck zprezto zplug shell
zsh-precheck:
	if ! type awk &>/dev/null ; then \
    echo 'awk is required.' ; \
    exit 0 ; \
  fi && \
	if ! type git &>/dev/null ; then \
    echo 'git is required.' ; \
    exit 0 ; \
  fi && \
	if ! type zsh &>/dev/null ; then \
    echo 'zsh is required.' ; \
    exit 0 ; \
  fi
zplug:
	git -C $(HOME)/.zplug pull || git clone https://github.com/zplug/zplug $(HOME)/.zplug
zprezto:
	git -C $(HOME)/.zprezto pull || git clone --recursive https://github.com/sorin-ionescu/prezto.git $(HOME)/.zprezto
	ln -sf $(.)/.profile $(HOME)/.zprofile
	ln -sf $(.)/.zprezto/zlogin $(HOME)/.zlogin
	ln -sf $(.)/.zprezto/zlogout $(HOME)/.zlogout
	ln -sf $(.)/.zshrc $(.)/.zpreztorc $(HOME)
cli:
	if type go &>/dev/null ; then \
		bash ./install-cli-via-go.sh ; \
	fi

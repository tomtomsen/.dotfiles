#!/bin/bash

# defines
DOTFILES_ROOT="`pwd`"

# functions
info () {
   printf "\r  [ \033[00;34m..\033[0m ] $1"
}

user () {
   printf "\r  [ \033[0;33m?\033[0m ] $1 "
}

success () {
   printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
   printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
   echo ''
   exit
}

run_install_scripts() {
    echo ''
    info 'running install'

    for install_script in `find $DOTFILES_ROOT -mindepth 2 -maxdepth 2 -name install.sh`
    do
        info "starting $install_script"
        info "`$install_script`"
    done

    success "everything has been installed"
}
run_install_scripts

install_dotfiles () {
	echo ''
	info 'installing dotfiles'

	overwrite_all=false
	backup_all=false
	skip_all=false

	echo "find $DOTFILES_ROOT -maxdepth 2 -name \".symlink"

	for source in `find $DOTFILES_ROOT -maxdepth 2 -name \*.symlink`
	do
		dest="$HOME/.`basename \"${source%.*}\"`"

		success "$dest"

		if [ -f $dest ] || [ -d $dest ]
		then
			overwrite=false
			backup=false
			skip=false

			if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
			then
				user "File already exists: `basename $dest`, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"

				read -n 1 action
				case "$action" in
					s )
						skip=true;;
					S )
						skip_all=true;;
					o )
						overwrite=true;;
					O )
						overwrite_all=true;;
					b )
						backup=true;;
					B )
						backup_all=true;;
					* )
						;;
				esac
			fi

			if [ "$overwrite" == "true" ] || [ "$overwrite_all" == "true" ]
			then
				rm -rf $dest
				success "removed $dest"
			fi

			if [ "$backup" == "true" ] || [ "$backup_all" == "true" ]
			then
				mv $dest $dest\.backup
				success "moved $dest to $dest.backup"
			fi

			if [ "$skip" == "false" ] && [ "$skip_all" == "false" ]
			then
				ln -s $source $dest
				success "linked $source to $dest"
			else
				success "skipped $source"
			fi
		else
			ln -s $source $dest
			success "linked $source to $dest"
		fi
	done
}

install_dotfiles

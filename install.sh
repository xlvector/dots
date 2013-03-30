#!/bin/bash

dot_path=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

printf '#### Bash ####\n'
echo "Append the bash/.bashrc to ~/.bashrc"
echo 'dot_path='$dot_path >> ~/.bashrc
cat $dot_path/bash/.bashrc >> ~/.bashrc
printf '\n'

printf '#### Git ####\n'
user_name=$(git config --get user.name)
user_email=$(git config --get user.email)

echo "Git User Name: $user_name"
echo "Git User Email: $user_email"

sed -e "s/name =/name = $user_name/" -e "s/email =/email = $user_email/" $dot_path/git/linux/.gitconfig > $dot_path/.gitconfig.bak

if [ -f ~/.gitconfig ]
then
    echo "Backup old gitconfig file"
    cp ~/.gitconfig ~/.gitconfig_bak
fi

echo "Copy .gitconfig file to ~/.gitconfig"
cp $dot_path/.gitconfig.bak ~/.gitconfig
printf '\n'

printf '#### Vim ####\n'
if [ -f ~/.vimrc ]
then
    echo "Backup old vimrc file"
    cp ~/.vimrc ~/.vimrc_bak
fi

echo "Copy vimrc file"
cp $dot_path/vim/.vimrc ~/.vimrc

if [ ! -d ~/.vim/bundle/vundle ]
then
    echo "Clone the vundle code"
    git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
fi
printf '\n'

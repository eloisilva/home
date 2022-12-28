#! /usr/bin/env python3
###############################################################################
#     File Name           :     check.py
#     Created By          :     Eloi Silva
#     Creation Date       :     [2020-06-09 01:15]
#     Last Modified       :     [2022-12-27 13:35]
#     Description         :     Check if files was updated on home directory
###############################################################################

import os
import hashlib


user_home = os.getenv('HOME')
files = dict(
    vim=['./.vimrc', './.vim/plugins.vim', './.vim/after/ftplugin/python.vim', './.vim/after/ftplugin/c.vim', './.vim/after/ftplugin/sh.vim', './.vim/after/ftplugin/markdown.vim', './.vim/after/ftplugin/yaml.vim', './.vim/after/ftplugin/html.vim'],
    bash=['./.bashrc', './.inputrc'],
    bash_aliases=['./.bash_aliases.d/01_default.sh', './.bash_aliases.d/50_tmux.sh', './.bash_aliases.d/70_aws.sh', './.bash_aliases.d/72_wiki.sh', './.bash_aliases.d/71_workdir.sh', './.bash_aliases.d/80_ssh.sh', './.bash_aliases.d/81_git.sh'],
    tmux=['./.tmux.conf', './.tmux/tmux-color.conf'],
    config=['./.config/flake8'],
    ssh=['./.ssh/config']
)


msg = {'OK': '', 'ERR': '', 'FileNotFound': ''}

for config in files:
    for f in files[config]:
        file_a = os.path.abspath(f)
        file_b = os.path.join(user_home, f)
        file_b = os.path.abspath(file_b)
        try:
            with open(file_a, 'rb') as a, open(file_b, 'rb') as b:
                hash_a = hashlib.md5(a.read()).hexdigest()
                hash_b = hashlib.md5(b.read()).hexdigest()
        except FileNotFoundError:
            msg['FileNotFound'] += f'  * {file_b}\n'
        else:
            if hash_a == hash_b:
                msg['OK'] += f'  * {file_b}\n'
            else:
                msg['ERR'] += f'  * {file_b}\n'

for m in msg:
    if msg[m]:
        print(f'[{m}]\n{msg[m]}')

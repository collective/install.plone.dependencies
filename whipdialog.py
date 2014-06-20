# whiptail.py - Use whiptail to display dialog boxes from shell scripts
# Copyright (C) 2013 Marwan Alsabbagh
# license: BSD, see LICENSE for more details.

# Modified to allow use of dialog or whiptail, depending on availability.
# Make sure it runs in Pythons down to 2.4

from collections import namedtuple
import itertools
import shlex
from subprocess import Popen, PIPE
import sys

dialog_candidates = ['dialog', 'whiptail']

PY3 = sys.version_info[0] == 3
string_types = str if PY3 else basestring
Response = namedtuple('Response', 'returncode value')


def flatten(data):
    return list(itertools.chain.from_iterable(data))


class Whiptail(object):
    def __init__(self, title='', backtitle='', height=10, width=50,
                 auto_exit=True):
        self.title = title
        self.backtitle = backtitle
        self.height = height
        self.width = width
        self.auto_exit = auto_exit
        # Choose a dialog manager
        dialog_manager = None
        for candidate in dialog_candidates:
            p = Popen(['which', candidate], stdout=PIPE, stderr=PIPE)
            stdout, stderr = p.communicate()
            if p.returncode == 0:
                dialog_manager = stdout.strip()
                break
        assert dialog_manager
        self.dialog_manager = dialog_manager


    def run(self, control, msg, extra=(), exit_on=(1, 255)):
        cmd = [
            self.dialog_manager, '--title', self.title, 
            '--' + control, msg, str(self.height), str(self.width)
        ]
        if self.backtitle:
            cmd[3:3] = ['--backtitle', self.backtitle]
        if extra:
            cmd += list(extra)
        p = Popen(cmd, stderr=PIPE)
        out, err = p.communicate()
        if self.auto_exit and p.returncode in exit_on:
            sys.exit(p.returncode)
        return Response(p.returncode, err)

    def prompt(self, msg, default='', password=False):
        control = 'passwordbox' if password else 'inputbox'
        return self.run(control, msg, [default]).value

    def confirm(self, msg, default='yes'):
        defaultno = ['--defaultno'] if default == 'no' else []
        return self.run('yesno', msg, defaultno, [255]).returncode == 0

    def alert(self, msg):
        self.run('msgbox', msg)

    def view_file(self, path):
        self.run('textbox', path, ['--scrolltext'])

    def calc_height(self, msg):
        height_offset = 8 if msg else 7
        return [str(self.height - height_offset)]

    def menu(self, msg='', items=(), prefix=' - '):
        if isinstance(items[0], string_types):
            items = [(i, '') for i in items]
        else:
            items = [(k, prefix + v) for k, v in items]
        extra = [str(len(items))] + flatten(items)
        return self.run('menu', msg, extra).value

    def showlist(self, control, msg, items, prefix):
        nitems = []
        for item in items:
            if isinstance(item, string_types):
                nitems.append((item, '', 'OFF'))
            else:
                k, v, s = item
                nitems.append((k, prefix + v, s))
        extra = [str(len(nitems))] + flatten(nitems)
        return self.run(control, msg, extra).value

    def radiolist(self, msg='', items=(), prefix=' - '):
        return self.showlist('radiolist', msg, items, prefix)

    def checklist(self, msg='', items=(), prefix=' - '):
        return shlex.split(self.showlist('checklist', msg, items, prefix))

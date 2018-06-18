"""BriarIDS main module

Creates main class and makes sure it only runs on command line.

"""

import os
import sys
#import subprocess
#needs python3-pip
#also sudo apt-get install python3-pyqt5
try:
    from PyQt5 import QtCore, QtGui, QtWidgets
    from PyQt5.QtCore import QTimer
    from PyQt5.QtWidgets import QApplication
except ImportError:
    print ('pyqt5 not installed...installing now.')
    os.system("sudo apt-get install python-pyqt5 -y")
    raise ImportError("ok done installing try running Briar now!")

os.system("sudo /usr/local/bin/./checkXauth.sh")
os.system("sudo /usr/local/bin/./updatecheck.sh")

import load_briar_menu


class Main(QtWidgets.QWidget):

    def __init__(self):

        super(Main, self).__init__()
        print ("loading main menu...")
        #output = subprocess.check_output('sudo ip r show|grep " src "|cut -d " " -f 3,12 | awk \'{print $1}\'', shell=True)
        #print output
        # name of gui python script
        self.ui = load_briar_menu.UiForm()
        self.ui.setup_ui(self)


def main():

    app = QApplication(sys.argv)
    app.setStyle("plastique")

    main = Main()
    main.show()
    sys.exit(app.exec_())


if __name__ == '__main__':
    main()



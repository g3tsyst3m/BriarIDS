"""BriarIDS main module

Creates main class and makes sure it only runs on command line.

"""

import os
import sys

try:
    from PyQt4 import QtCore, QtGui
    from PyQt4.QtCore import QTimer
except ImportError:
    print 'pyqt not installed...installing now.'
    os.system("sudo apt-get install python-qt4 -y")
    raise ImportError("ok done installing try running Briar now!")

os.system("sudo /usr/local/bin/./checkXauth.sh")
os.system("sudo /usr/local/bin/./updatecheck.sh")

import load_briar_menu


class Main(QtGui.QWidget):

    def __init__(self):

        super(Main, self).__init__()
        print "loading main menu..."

        # name of gui python script
        self.ui = load_briar_menu.UiForm()
        self.ui.setup_ui(self)


def main():

    app = QtGui.QApplication(sys.argv)
    app.setStyle("plastique")

    main = Main()
    main.show()
    sys.exit(app.exec_())


if __name__ == '__main__':
    main()



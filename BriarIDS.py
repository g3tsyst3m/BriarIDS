import os
import sys
try:
    from PyQt4 import QtCore, QtGui
except ImportError:
    print 'pyqt not installed...installing now.'
    os.system("sudo apt-get install python-qt4 -y")
    raise ImportError("ok done installing try running Briar now!")

os.system("sudo ./checkXauth.sh")
os.system("sudo ./updatecheck.sh")
########################################
#include name of gui python script below
import loadBriarMenu
########################################
class Main(QtGui.QWidget):
    def __init__(self):
        super(Main, self).__init__()
        print "loading main menu..."        
          
        # name of gui python script
        ############################
        self.ui = loadBriarMenu.Ui_Form()
        #############################
        self.ui.setupUi(self)


if __name__ == '__main__':
    app = QtGui.QApplication(sys.argv)
    
    app.setStyle("plastique")
    main = Main()

    main.show()
    sys.exit(app.exec_())

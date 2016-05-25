import sys
from PyQt4 import QtCore, QtGui
########################################
#include name of gui python script below
import loadBriarMenu
########################################

class Main(QtGui.QMainWindow):
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

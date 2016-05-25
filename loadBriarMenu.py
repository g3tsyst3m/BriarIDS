# -*- coding: utf-8 -*-

from PyQt4 import QtCore, QtGui
import os

try:
    _fromUtf8 = QtCore.QString.fromUtf8
except AttributeError:
    def _fromUtf8(s):
        return s

try:
    _encoding = QtGui.QApplication.UnicodeUTF8
    def _translate(context, text, disambig):
        return QtGui.QApplication.translate(context, text, disambig, _encoding)
except AttributeError:
    def _translate(context, text, disambig):
        return QtGui.QApplication.translate(context, text, disambig)

class Ui_Form(object):
    def setupUi(self, Form):
        Form.setObjectName(_fromUtf8("Form"))
        Form.resize(635, 413)
        self.label = QtGui.QLabel(Form)
        self.label.setGeometry(QtCore.QRect(0, -40, 681, 491))
        self.label.setText(_fromUtf8(""))
        self.label.setPixmap(QtGui.QPixmap(_fromUtf8(":/newPrefix/bateman-in-the-brier-patch-crop.jpg")))
        self.label.setObjectName(_fromUtf8("label"))
        self.pushButton = QtGui.QPushButton(Form)
        self.pushButton.setGeometry(QtCore.QRect(450, 70, 171, 41))
        font = QtGui.QFont()
        font.setPointSize(12)
        font.setBold(True)
        font.setWeight(75)
        self.pushButton.setFont(font)
        self.pushButton.setAutoFillBackground(True)
        self.pushButton.setAutoDefault(False)
        self.pushButton.setDefault(False)
        self.pushButton.setFlat(False)
        self.pushButton.setObjectName(_fromUtf8("pushButton"))
        self.label_2 = QtGui.QLabel(Form)
        self.label_2.setGeometry(QtCore.QRect(70, 10, 531, 41))
        font = QtGui.QFont()
        font.setFamily(_fromUtf8("Tempus Sans ITC"))
        font.setPointSize(16)
        font.setBold(True)
        font.setWeight(75)
        self.label_2.setFont(font)
        self.label_2.setAutoFillBackground(False)
        self.label_2.setStyleSheet(_fromUtf8(""))
        self.label_2.setObjectName(_fromUtf8("label_2"))
        self.line = QtGui.QFrame(Form)
        self.line.setGeometry(QtCore.QRect(70, 0, 511, 20))
        self.line.setFrameShape(QtGui.QFrame.HLine)
        self.line.setFrameShadow(QtGui.QFrame.Sunken)
        self.line.setObjectName(_fromUtf8("line"))
        self.line_2 = QtGui.QFrame(Form)
        self.line_2.setGeometry(QtCore.QRect(70, 40, 511, 20))
        self.line_2.setFrameShape(QtGui.QFrame.HLine)
        self.line_2.setFrameShadow(QtGui.QFrame.Sunken)
        self.line_2.setObjectName(_fromUtf8("line_2"))
        self.pushButton_2 = QtGui.QPushButton(Form)
        self.pushButton_2.setGeometry(QtCore.QRect(450, 150, 171, 41))
        font = QtGui.QFont()
        font.setPointSize(12)
        font.setBold(True)
        font.setWeight(75)
        self.pushButton_2.setFont(font)
        self.pushButton_2.setAutoFillBackground(True)
        self.pushButton_2.setAutoDefault(False)
        self.pushButton_2.setDefault(False)
        self.pushButton_2.setFlat(False)
        self.pushButton_2.setObjectName(_fromUtf8("pushButton_2"))
        self.pushButton_3 = QtGui.QPushButton(Form)
        self.pushButton_3.setGeometry(QtCore.QRect(450, 310, 171, 91))
        font = QtGui.QFont()
        font.setPointSize(12)
        font.setBold(True)
        font.setWeight(75)
        self.pushButton_3.setFont(font)
        self.pushButton_3.setAutoFillBackground(True)
        self.pushButton_3.setAutoDefault(False)
        self.pushButton_3.setDefault(False)
        self.pushButton_3.setFlat(False)
        self.pushButton_3.setObjectName(_fromUtf8("pushButton_3"))
        self.pushButton_4 = QtGui.QPushButton(Form)
        self.pushButton_4.setGeometry(QtCore.QRect(450, 230, 171, 41))
        font = QtGui.QFont()
        font.setPointSize(12)
        font.setBold(True)
        font.setWeight(75)
        self.pushButton_4.setFont(font)
        self.pushButton_4.setAutoFillBackground(True)
        self.pushButton_4.setAutoDefault(False)
        self.pushButton_4.setDefault(False)
        self.pushButton_4.setFlat(False)
        self.pushButton_4.setObjectName(_fromUtf8("pushButton_4"))

        self.retranslateUi(Form)
        QtCore.QMetaObject.connectSlotsByName(Form)

    def retranslateUi(self, Form):
        Form.setWindowTitle(_translate("Form", "BriarIDS", None))
        self.pushButton.setToolTip(_translate("Form", "This installs BriarIDS and also checks if it is already installed", None))
        self.pushButton.setText(_translate("Form", "Install", None))
        self.pushButton.clicked.connect(self.install)
        self.label_2.setText(_translate("Form", "<html><head/><body><p><span style=\" color:#55ff7f;\">Welcome to BriarIDS -  designed for the Raspberry Pi</span></p></body></html>", None))
        self.pushButton_2.setToolTip(_translate("Form", "This starts the IDS engine and displays log alerts in the terminal", None))
        self.pushButton_2.setText(_translate("Form", "Run", None))
        self.pushButton_2.clicked.connect(self.runtheprog)
        self.pushButton_3.setToolTip(_translate("Form", "checks for most recent updates...", None))
        self.pushButton_3.setText(_translate("Form", "Check for Updates", None))
        self.pushButton_4.setToolTip(_translate("Form", "compares your active configuration with the recommended configuration", None))
        self.pushButton_4.setText(_translate("Form", "Check Configuration", None))
    def install(self):
        print ("Installation routine initializing...")
        os.system("x-terminal-emulator -e './briarids-install-script.sh'")
    def runtheprog(self):
        print ("starting Suricata!")
        os.system("ethtool -K eth0 tx off rx off sg off gso off gro off")
        os.system("x-terminal-emulator -e '/opt/suricata/bin/suricata -c /opt/suricata/etc/suricata/suricata.yaml --af-packet=eth0'")
import main_rc

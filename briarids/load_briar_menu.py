# -*- coding: utf-8 -*-
""" BriarIDS menu loader: Creates a python desktop application.

Desktop application allows you to install Suricata, Bro, and Critical Stack Agent 
via selectable button options.  

Follow wiki at https://github.com/musicmancorley/BriarIDS/wiki for latest docs.

"""

#from PyQt4 import QtCore, QtGui
from PyQt5 import QtCore, QtGui, QtWidgets
from PyQt5.QtCore import QThread, QObject, pyqtSignal
import os, sys, threading, subprocess, time
from subprocess import Popen, PIPE, CalledProcessError


class SuricataInstallerThread(QThread):

    install_signal = pyqtSignal(object)

    def __init__(self, url):
        QThread.__init__(self)
        self.url = url

    def run(self):
        p = subprocess.Popen(self.url, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        stdout = []
        counter=0.0
        while True:
            line = p.stdout.readline()
            stdout.append(line)
            print (line.rstrip())
            if "  CC       " in str(line):
                counter=counter+.1
                self.install_signal.emit('%s' % (counter))
            if "Phase-1" in str(line):
                counter=7
                self.install_signal.emit('%s' % (counter))
            if "Phase-2" in str(line):
                counter=20
                self.install_signal.emit('%s' % (counter))
            if "Phase-3" in str(line):
                counter=45
                self.install_signal.emit('%s' % (counter))
            if "Phase-4" in str(line):
                counter=93
                self.install_signal.emit('%s' % (counter))
            if "Phase-5" in str(line):
                counter=97
                self.install_signal.emit('%s' % (counter))
            if "success" in str(line):
                counter=100
                self.install_signal.emit('%s' % (counter))
            if line == '':
                break

class BroInstallerThread(QThread):

    broinstall_signal = pyqtSignal(object)

    def __init__(self, url):
        QThread.__init__(self)
        self.url = url

    def run(self):
        p = subprocess.Popen(self.url, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        stdout = []
        counter=0.0
        while True:
            line = p.stdout.readline()
            stdout.append(line)
            print (line.rstrip())
            if "Building CXX" in str(line):
                counter=counter+.1
                self.broinstall_signal.emit('%s' % (counter))
            if "prereqs" in str(line):
                counter=3
                self.broinstall_signal.emit('%s' % (counter))
            if "Preparing" in str(line):
                counter=10
                self.broinstall_signal.emit('%s' % (counter))
            if "coffee" in str(line):
                counter=30
                self.broinstall_signal.emit('%s' % (counter))
            if "complete!" in str(line):
                counter=100
                self.broinstall_signal.emit('%s' % (counter))
            if line == '':
                break

class UiForm:

    """Primary class that creates the BriarIDS desktop application
    
    Creates the desktop application, as well as runs bash script's depending on which button is 
    pressed.
    
    """

    def setup_ui(self, Form):
        """Sets up the outline of the UI.
        
        Instantiates all the classes from the pyQt4 program and then defines the size,shape, layout of
        all the UI elements.
        
        param Form: pyQt4 form object
        """
        Form.setObjectName("Form")
        Form.resize(468, 602)
        Form.setMinimumSize(QtCore.QSize(468, 602))
        Form.setMaximumSize(QtCore.QSize(468, 602))
        Form.setStyleSheet("background-color: rgb(216, 224, 255);")
        self.label = QtWidgets.QLabel(Form)
        self.label.setGeometry(QtCore.QRect(60, 10, 351, 16))
        self.label.setObjectName("label")
        self.label_2 = QtWidgets.QLabel(Form)
        self.label_2.setGeometry(QtCore.QRect(10, 30, 461, 311))
        self.label_2.setObjectName("label_2")
        self.comboBox = QtWidgets.QComboBox(Form)
        self.comboBox.setGeometry(QtCore.QRect(260, 340, 111, 22))
        self.comboBox.setObjectName("comboBox")
        self.comboBox.addItem("")
        self.comboBox.addItem("")
        self.comboBox.addItem("")
        self.comboBox.addItem("")
        self.comboBox.addItem("")
        self.comboBox.addItem("")
        self.label_3 = QtWidgets.QLabel(Form)
        self.label_3.setGeometry(QtCore.QRect(70, 340, 181, 16))
        self.label_3.setObjectName("label_3")
        self.pushButton = QtWidgets.QPushButton(Form)
        self.pushButton.setGeometry(QtCore.QRect(140, 370, 191, 51))
        self.pushButton.setStyleSheet("font: 11pt \"Lucida Handwriting\";")
        self.pushButton.setObjectName("pushButton")
        self.pushButton_2 = QtWidgets.QPushButton(Form)
        self.pushButton_2.setGeometry(QtCore.QRect(140, 430, 191, 51))
        self.pushButton_2.setStyleSheet("font: 11pt \"Lucida Handwriting\";")
        self.pushButton_2.setObjectName("pushButton_2")
        self.progressBar = QtWidgets.QProgressBar(Form)
        self.progressBar.setEnabled(True)
        self.progressBar.hide()
        self.progressBar.setGeometry(QtCore.QRect(140, 580, 211, 21))
        self.progressBar.setProperty("value", 0)
        self.progressBar.setTextVisible(True)
        self.progressBar.setObjectName("progressBar")
        self.pushButton_3 = QtWidgets.QPushButton(Form)
        self.pushButton_3.setGeometry(QtCore.QRect(140, 490, 191, 51))
        self.pushButton_3.setStyleSheet("font: 11pt \"Lucida Handwriting\";")
        self.pushButton_3.setObjectName("pushButton_3")
        self.pushButton_5 = QtWidgets.QPushButton(Form)
        self.pushButton_5.setGeometry(QtCore.QRect(140, 550, 191, 21))
        self.pushButton_5.setStyleSheet("font: 11pt \"Lucida Handwriting\";")
        self.pushButton_5.setObjectName("pushButton_5")

        self.label_4 = QtWidgets.QLabel(Form)
        self.label_4.hide()
        self.label_4.setGeometry(QtCore.QRect(180, 560, 111, 16))
        self.label_4.setObjectName("label_4")

        self.retranslateUi(Form)
        QtCore.QMetaObject.connectSlotsByName(Form)
        

    def retranslateUi(self, Form):
        _translate = QtCore.QCoreApplication.translate
        Form.setWindowTitle(_translate("Form", "BriarIDS"))
        self.label.setText(_translate("Form", "<html><head/><body><p><span style=\" font-size:10pt; font-weight:600; color:#0569eb;\">Welcome to BriarIDS - designed for the Raspberry Pi</span></p></body></html>"))
        self.label_2.setText(_translate("Form", "<html><head/><body><p><img src=\":/newPrefix/Brambles-for-the-Rabbit_scaled.jpg\"/></p></body></html>"))
        self.comboBox.setToolTip(_translate("Form", "monitoring interface"))
        output = subprocess.check_output("sudo ip r sh | awk 'NR==1{print $5}'",shell=True)
        self.comboBox.setItemText(0, _translate("Form", "autodetected interface: "+output))
        self.comboBox.setItemText(1, _translate("Form", "wlan0"))
        self.comboBox.setItemText(2, _translate("Form", "wlan1"))
        self.comboBox.setItemText(3, _translate("Form", "eth0"))
        self.comboBox.setItemText(4, _translate("Form", "eth1"))
        self.comboBox.setItemText(5, _translate("Form", "eth2"))
        self.label_3.setText(_translate("Form", "Choose Suricata Monitoring Interface"))
        self.pushButton.clicked.connect(self.installsuri)
        
        retvalue=os.system("ls /opt/suricata/etc/suricata/BriarIDS_installed")
        if retvalue==0:
            self.pushButton.setStyleSheet("background-color: rgb(0, 255, 0);")
            self.pushButton.setText(_translate("Form", "Suricata installed!"))
            self.pushButton.setToolTip(_translate("Form", "Suricata installed!"))

        else:
            self.pushButton.setText(_translate("Form", "Install Suricata"))
            self.pushButton.setToolTip(_translate("Form", "Install Suricata"))
        self.pushButton_2.setToolTip(_translate("Form", "Run Suricata"))
        self.pushButton_2.setText(_translate("Form", "Run Suricata"))
        self.pushButton_2.clicked.connect(self.runtheprog)

        
        self.pushButton_5.setToolTip(_translate("Form", "Configure Alienvault Intel Feed"))
        self.pushButton_5.setText(_translate("Form", "Configure Alienvault Intel Feed"))
        self.pushButton_5.clicked.connect(self.bro_intel_config)
        
        retvalue2=os.system("ls /opt/nsm/bro/bro_install_complete")
        if retvalue2==0:
            self.pushButton_3.setStyleSheet("background-color: rgb(0, 255, 0);")
            self.pushButton_3.setText(_translate("Form", "Bro installed!"))
            self.pushButton_3.setToolTip(_translate("Form", "Bro installed!"))

        else:
            self.pushButton_3.setText(_translate("Form", "Install Bro"))
            self.pushButton_3.setToolTip(_translate("Form", "Install Bro"))
        self.pushButton_3.clicked.connect(self.broinstall)

#        self.pushButton_4.setToolTip(_translate("Form", "Add in your public/WAN IP", None))
#        self.pushButton_4.setText(_translate("Form", "Add WAN IP to config for monitoring", None))
#        self.pushButton_5.setToolTip(_translate("Form", "This installs Bro and the Critical Stack Intel Feed client", None))
#        self.pushButton_5.setText(_translate("Form", "Install/Configure/Run Bro AND Intel Agent!", None))
#        self.pushButton_5.clicked.connect(self.brointelinstall)
#        self.pushButton_4.clicked.connect(self.configcheck)
        #self.pushButton_8.setToolTip(_translate("Form", "Runs the VirusTotal Scanner against your extracted files!", None))
        #self.pushButton_8.setText(_translate("Form", "Virus Total File Scanner (new!)", None))
        #self.pushButton_8.clicked.connect(self.vtotalscanner)
        output = subprocess.check_output("sudo ip r sh | awk 'NR==1{print $5}'",shell=True)
        #Ubuntu specific
        #output = subprocess.check_output('sudo ip r show|grep " src "|cut -d " " -f 3,12 | awk \'{print $1}\'', shell=True)
        #self.comboBox.setItemText(0, _translate("Form", output, None))
       # self.comboBox.setItemText(1, _translate("Form", "eth0", None))
       # self.comboBox.setItemText(2, _translate("Form", "eth1", None))
       # self.comboBox.setItemText(3, _translate("Form", "eth2", None))
       # self.comboBox.setItemText(4, _translate("Form", "wlan0", None))
       # self.comboBox.setItemText(5, _translate("Form", "wlan1", None))
       # self.comboBox.setItemText(6, _translate("Form", "wlan2", None))
        self.label_3.setText(_translate("Form", "<span style='font-size:8pt'>CHOOSE SURICATA MONITOR INTERFACE:</span>", None))

    def install(self):
        """Runs the suricata install bash shell script when 'Install Suricata' button pressed"""

        self.pushButton.clicked.connect(self.installsuri)
        self.label_4.setText(_translate("Form", "Installation Progress:"))
       

    def installsuri(self):
        """Runs the suricata install bash shell script when 'Install Suricata' button pressed"""
        if "Suricata installed!" in self.pushButton.text():
            print("you've already installed Suricata.  delete this file to reinstall: /opt/suricata/etc/suricata/BriarIDS_installed")
            exit(0)
        #self.label_4.show()
        self.progressBar.show()
        url = "sudo /usr/local/bin/./suricata-install-script.sh"
        self.threads = []
        
        installer = SuricataInstallerThread(url)
        installer.install_signal.connect(self.on_data_ready)
        self.threads.append(installer)
        installer.start()
            
    def on_data_ready(self, data):
        data=float(data)
        self.progressBar.setFormat("%.2f%%" % data)
        self.progressBar.setValue(data)
    def runtheprog(self):
        """Start's suricata when 'Run Suricata' button pressed"""
        
        monint = str(self.comboBox.currentText())
        if "autodetect" in monint:
            monint=monint.split(": ")
            monint=monint[1].strip("\n")
            #print(monint)
            #exit(0)
        print("Configuring interface using Ethtool...")
        os.system("ethtool -K " + monint + " tx off rx off sg off gso off gro off" + " 2>/dev/null")
        print("Note: You can view your alert logs by issuing the following command: tail -f /var/log/suricata/http.log /var/log/suricata/fast.log")
        print("Even better, you are encouraged to use the new WEB GUI log management interface, TheBriarPatch, specifically for BriarIDS!")
        print("Go here to clone it: https://github.com/musicmancorley/TheBriarPatch")
        os.system("sleep 5")
        print("Starting Suricata!!!")
        os.system("sudo /usr/local/bin/./rulecleanup.sh")
        mycommand = '/opt/suricata/bin/suricata -c /opt/suricata/etc/suricata/suricata.yaml --af-packet=' + monint + " &"
        os.system("sudo x-terminal-emulator -e " + mycommand)

  #  def configcheck(self):
        """Python system call that runs script that makes sure BriarIDS is installed and that a WAN IP entered"""

   #     os.system("sudo /usr/local/bin/./configcheck.sh")
    
    def bro_intel_config(self):
        os.system("sudo /usr/local/bin/./bro-alienvaultintel-installer.sh")

    def broinstall(self):
        """Python system call that runs script that installs/configures Bro."""
        if "Bro installed!" in self.pushButton_3.text():
            print("you've already installed Bro.  delete this file to reinstall: /opt/nsm/bro/bro_install_complete")
            exit(0)
        #self.label_4.show()
        self.progressBar.show()
        url = "sudo /usr/local/bin/./bro-installer.sh"
        self.threads = []

        binstaller = BroInstallerThread(url)
        binstaller.broinstall_signal.connect(self.on_data_ready)
        self.threads.append(binstaller)
        binstaller.start()

   # def vtotalscanner(self):
        """Python system call that runs script that runs vtotalscanner scripts"""
    #    os.system("sudo /usr/local/bin/./filetypescan.sh")


import resource

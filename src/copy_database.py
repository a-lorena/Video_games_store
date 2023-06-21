import sys
import os
import shutil
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

if __name__ == '__main__':
	app = QGuiApplication(sys.argv)
	engine = QQmlApplicationEngine()
	
	path = engine.offlineStoragePath() + "\Databases"
	
	if not os.path.isdir(path):
		os.mkdir(path)

	print("Kopiranje u: " + path)
	
	shutil.copy("aff8bad900aec83d2141ebd1acd826dc.ini", path)
	shutil.copy("aff8bad900aec83d2141ebd1acd826dc.sqlite", path)

	print("Datoteke uspješno kopirane!")
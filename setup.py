from setuptools import setup, find_packages

setup(name='briar',
      version='0.1.12',
      author='tylerebel',
      author_email='sifiebel@gmail.com',
      packages=find_packages(),
      url='https://github.com/musicmancorley/BriarIDS',
      scripts=['scripts/bro-installer.sh', 'scripts/bromenu.sh', 'scripts/checkXauth.sh', 'scripts/configcheck.sh', 'scripts/filetypescan.sh', 'scripts/filetypescan_part2.sh', 'scripts/suricata-install-script.sh', 'scripts/updatecheck.sh'],
      entry_points={
          'console_scripts': ['briar=briarids.briar_ids:main', ],

      }

      )

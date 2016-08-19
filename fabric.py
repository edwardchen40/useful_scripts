# -*- coding: utf-8 -*-
""" 
* iCHEF Fabric script.
* Copy ipa to remote environment 
* Remote install ipa
"""

import fabric
import fabric.state
from fabric.api import *
from fabric.colors import *

# All operations default to localhost
LOCALHOST = ['admin@localhost:22']

env.roledefs = {
'mainserver': ['admin@192.168.5.2:22'],
'deployserver': ['admin@192.168.5.2:22', 'admin@192.168.5.3:22'],
'vm_ip2': ['admin@192.168.5.2:22'],
'real_ip3': ['admin@192.168.5.3:22'],
'vm_ip4': ['admin@192.168.5.4:22']
}

env.passwords = {
    'admin@192.168.5.1:22': "ichefitco",
    'admin@192.168.5.2:22': "ichefitco",
    'admin@192.168.5.3:22': "ichefitco",
    'admin@192.168.5.4:22': "ichefitco"
}

@roles('mainserver')
def remote_try_run():
	run('ls -l | wc -l')
	put('~/test.log', '~/test.log')

@roles('deployserver')
# Copy ipa to remote machine
def do_copy_ipa():
	# Copy ipa
	result = put('/Users/admin/output/ipa/rc/iCHEF.ipa', '/Users/admin').succeeded
	show(env.host, result)


@roles('vm_ip2')
def do_install_2():
	# iPad 2 Air 'iCHEF's 小冠軍號' 
	result = run('ios-deploy -i c50c85c7470307e581bab129811571f0c56c6e02 --bundle ~/iCHEF.ipa').succeeded
	show(env.host, result)

@roles('real_ip3')
def do_install_3():
	# iPad 3 'iCHEF's iPad3 Cold' 
	result = run('ios-deploy -i 23b6039f93b93f2e9e3ce33d8448b5ae569ade12 --bundle ~/iCHEF.ipa').succeeded
	show(env.host, result)

#@roles('vm_ip4')
# def do_install_4():
# 	# 
# 	run('ios-deploy -i xxx --bundle %(appPath)s')

def show(hostname, result):
	if result == 1:
		print yellow(hostname) + green(' => Success')
	else:
		print yellow(hostname) + red(' => fail')





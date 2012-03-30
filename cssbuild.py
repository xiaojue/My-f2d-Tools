# -*- coding: utf-8 -*-
import os,re,sys,shutil
#path config 
root = os.path.abspath('.')
src = sys.argv[1]
target = sys.argv[2]
options = sys.argv[3]
yuicompressor = root+ '/yuicompressor/yuicompressor.jar'

def concatCss(modules,conf):
  conf = os.path.normpath(conf)
  if os.path.isfile(conf):
    f = open(conf,'r+')
    if not os.path.isdir('temp'):
      os.mkdir('temp')
    temp = file(root+'/'+'temp'+'/'+os.path.basename(conf),'w')
    allstr = ''
    for i in modules:
      ff = open(os.path.normpath(root+'/'+i),'r+')
      strs = ff.read()
      strs = re.sub('\@charset \"utf\-8\"\;','',strs)
      allstr += strs
      ff.close()
    temp.write('@charset "utf-8";'+allstr)
    temp.close()
    #print allstr
    f.close()

def getcssimports(conf):
  modules = []
  conf = os.path.normpath(conf)
  confdir = os.path.dirname(conf)+'/'
  f = open(conf,'r+')
  strs = f.read()
  temp = re.findall('\@import url\(\"(.*?)\"\)',strs,re.S)
  for i in temp:
    modules.append(confdir+i)
  #print modules 
  return modules

def batchCss(conf):
  modules = getcssimports(conf)
  concatCss(modules,conf)

def buildCss(src,target):
  if os.path.isfile(src):
    batchCss(src)
    os.popen('java -jar '+yuicompressor+' --charset utf-8 '+root+'/'+'temp'+'/'+os.path.basename(src)+' -o '+root+'/'+target)
    if os.path.isdir('temp'):
      shutil.rmtree('temp')
  elif os.path.isdir(src):
    if not os.path.isdir(target):
      os.mkdir(target)
    for i in os.listdir(src):
      css = os.path.normpath(src +'/'+i)
      batchCss(css)
      name = os.path.basename(css)
      os.popen('java -jar '+yuicompressor+' --charset utf-8 '+root+'/'+'temp'+'/'+name+' -o '+root+'/'+target+'/'+name)
    if os.path.isdir('temp'):
      shutil.rmtree('temp')
  else:
    print src+' not exists'

def compressCss(src,target):
  if os.path.isfile(src):
    os.popen('java -jar '+yuicompressor+' --charset utf-8 '+src+' -o '+target)
  elif os.path.isdir(src):
    if not os.path.isdir(target):
      os.mkdir(target)
    for i in os.listdir(src):
      css = os.path.normpath(src +'/'+i)
      name = os.path.basename(css)
      os.popen('java -jar '+yuicompressor+' --charset utf-8 '+css+' -o '+root+'/'+target+'/'+name)
  else:
    print src+' not exists'

if options=='--build':
  src = os.path.normpath(src)
  target = os.path.normpath(target)
  buildCss(src,target)
if options=='--compress':
  src = os.path.normpath(src)
  target = os.path.normpath(target)
  compressCss(src,target)
  


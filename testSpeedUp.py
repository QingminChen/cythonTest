import setuptools
import pyximport
pyximport.install()
import speedupInterfaces
a=[u'qingmin',u'wenting',u'zhangsan',u'lisi']
a_encode=[]
for i in a:
    a_i = i.encode('utf-8')
    a_encode.append(a_i)
b=[u'qingmin',u'cloud',u'sky',u'march',u'wenting',u'happy',u'cry',u'shoes',u'zhangsan',u'mouse',u'lisi']
b_encode=[]
for i in b:
    b_i = i.encode('utf-8')
    b_encode.append(b_i)
c = speedupInterfaces.iterateFeaturesToFindIndicesInVocabulary(b_encode,a_encode)
list =[]
for i in c:
    list.append(i)
print(list)
list=list[::-1]
print(list)
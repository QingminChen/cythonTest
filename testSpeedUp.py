import setuptools
import pyximport
pyximport.install()
import speedupInterfaces
a=['qingmin','wenting','zhangsan','lisi']
b=['qingmin','cloud','sky','march','wenting','happy','cry','shoes','zhangsan','mouse','lisi']
c = speedupInterfaces.iterateFeaturesToFindIndicesInVocabulary(b,a)
list =[]
for i in c:
    list.append(i)
print(list)
list=list[::-1]
print(list)
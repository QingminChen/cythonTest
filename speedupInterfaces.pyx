cimport cython
from numpy cimport ndarray as ar								
from libc.stdlib cimport malloc, free

from libc.string cimport strcmp
from cpython.string cimport PyString_AsString
from libc.stdio cimport printf							  
import cythonlinkedlist
import datetime,time

@cython.boundscheck(False)
@cython.wraparound(False)

# cdef struct _LinkedListStruct:
#     int data
#     _LinkedListStruct *next


cdef char ** to_cstring_array(list_str):
    #printf("Qingmin+++++++++++++speedupTest to_cstring_array[len(list_str)] %ld\n:",len(list_str))
    #printf("Qingmin+++++++++++++speedupTest to_cstring_array[sizeof(char *)] %ld\n:",sizeof(char *))
    cdef char **ret = <char **>malloc(len(list_str) * sizeof(char *))
    for i in range(len(list_str)):
        # ret[i] = PyString_AsString(list_str[i].encode('utf-8'))
        ret[i] = PyString_AsString(list_str[i])
        # printf("Qingmin+++++++++++++speedupTest to_cstring_array[ret[%ld]] %ld\n:",i,ret[i])
    return ret

cpdef iterateFeaturesToFindIndicesInVocabulary(list_str1, list_str2):
    cdef unsigned int i, j
    #printf("Qingmin+++++++++++++speedupTest[i]:%ld\n",i)
    #printf("Qingmin+++++++++++++speedupTest[j]:%ld\n",j)

    # cdef int indexArray[11]    # I need to implemented it with linkedlist
    cdef linkedlist = cythonlinkedlist.LinkedList()
    #cdef _LinkedListStruct *head=<_LinkedListStruct *> malloc( sizeof(_LinkedListStruct) )

    # cdef char **c_arr1 = <char **>malloc(len(list_str1) * sizeof(char*))
    # for i in range(len(list_str1)):
    #     print(i)
    #     print(list_str1[i])
    #     c_arr1[i] = PyString_AsString(list_str1[i])
    #     printf("%s\n",c_arr1[i])
    #     print("====================1====================")
    #
    # cdef char **c_arr2 = <char **>malloc(len(list_str2) * sizeof(char*))
    # for i in range(len(list_str2)):
    #     c_arr2[i] = PyString_AsString(list_str2[i])
    #     printf("%s\n",c_arr2[i])
    #     print("====================2====================")

    cdef char **c_arr1 = to_cstring_array(list_str1)   #1000
    cdef char **c_arr2 = to_cstring_array(list_str2)   #105
    # printf("%s\n",c_arr2[0])
    # printf("%s\n",c_arr2[1])
    # printf("%s\n",c_arr2[2])
    # printf("%s\n",c_arr2[3])
    # printf("%s\n",c_arr1[0])
    # printf("%s\n",c_arr1[1])
    # printf("%s\n",c_arr1[2])
    # printf("%s\n",c_arr1[3])
    # printf("%s\n",c_arr1[4])
    # printf("%s\n",c_arr1[5])
    # printf("%s\n",c_arr1[6])
    # printf("%s\n",c_arr1[7])
    # printf("%s\n",c_arr1[8])
    # printf("%s\n",c_arr1[9])
    # printf("%s\n",c_arr1[10])
    # print("Qingmin+++++++++++++speedupTest[len(list_str1)]:%ld\n",len(list_str1))   #1000
    # print("Qingmin+++++++++++++speedupTest[len(list_str2)]:%ld\n",len(list_str2))   #105
    # for i in range(11):
    #     printf("%s\n",c_arr1[i])
    # for i in range(4):
    #     printf("%s\n",c_arr2[i])



    for i in range(len(list_str2)):
        printf("+++speedupTest[i=%ld in list_str2=%ld]+++\n",i,len(list_str2))
        for j in range(len(list_str1)):
            printf("+++speedupTest[j=%ld in list_str1=%ld]+++\n",j,len(list_str1))
            # printf("%s\n",c_arr1[j])
            # printf("%s\n",c_arr2[i])
            if strcmp(c_arr2[i],c_arr1[j])==0:
              printf("+++speedupTest[c_arr2[%ld]==c_arr1[%ld]] is true +++\n",i,j)
              #linkedList.add(j)
              #head.data = j
              #head.next = NULL
              #indexArray[i]=j
              start_add = time.time()
              start_add_y_m_d_h_m_s = datetime.datetime.fromtimestamp(start_add).strftime('%Y-%m-%d %H:%M:%S.%f')[:-3]
              print("Start head add time:%s", start_add_y_m_d_h_m_s)
              linkedlist.add_head(j)
              start_end = time.time()
              start_end_y_m_d_h_m_s = datetime.datetime.fromtimestamp(start_end).strftime('%Y-%m-%d %H:%M:%S.%f')[:-3]
              print("End head add time:%s", start_end_y_m_d_h_m_s)
    final_index_list =[]
    for i in linkedlist:
        final_index_list.append(i)

    free(c_arr1)
    free(c_arr2)
    return final_index_list
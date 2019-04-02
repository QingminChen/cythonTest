from  libc.stdlib  cimport  malloc  # import malloc function from c
from libc.stdio cimport printf
ctypedef  struct  _LinkedListStruct :
    int  data 
    _LinkedListStruct * next

cdef  class  LinkedList :
    # visible from the Python side class

    cdef  _LinkedListStruct * _head
    # cdef visible from Cython not visible from Python

    def __cinit__(self):

        self._head = NULL

    cpdef  add_tail ( self ,  int  data ):  # cpdef that can be read from both C and Python

        # Malloc to 
        # <_LinkedListStruct *> Eraru in the compilation that there is no 
        cdef  _LinkedListStruct * obj  =  < _LinkedListStruct *>  malloc ( sizeof ( _LinkedListStruct ))
        if  not  obj :
            raise  MemoryError ()

        # Put the data 
        obj.data  =  data
        obj.next  =  NULL  #If you forget the # initialization Seguforu

        # Last search 
        cdef  _LinkedListStruct * ptr  =  self._head  # can not be declared is not if statement
        if  self._head  is  NULL :
            # sober-to-use Is 
            # None can not be used 
            self._head  =  obj
            return
        else :
            while  ptr.next  is  not  NULL :
                ptr  =  ptr . next 
            ptr.next  =  obj

    cpdef  add_head ( self ,  int  data ):  # tomorrow need to implement how to add the element at the head of the linkedlist

        # Malloc to
        # <_LinkedListStruct *> Eraru in the compilation that there is no
        cdef  _LinkedListStruct * obj  =  < _LinkedListStruct *>  malloc ( sizeof ( _LinkedListStruct ))
        if  not  obj :
            raise  MemoryError ()

        # Put the data
        obj.data  =  data
        printf("obj address1 :%ld\n",obj)
        obj.next  =  NULL

        cdef  _LinkedListStruct * ptr  =  self._head  # can not be declared is not if statement
        printf("ptr address1 :%ld\n",ptr)
        printf("self._head address1 :%ld\n",self._head)
        if  self._head  is  NULL :
            printf("Head is null\n")
            self._head  =  obj
            printf("obj address2 :%ld\n",obj)
            printf("ptr address2 :%ld\n",ptr)
            printf("self._head address2 :%ld\n",self._head)
            return
        else :
            printf("Head is not null\n")
            printf("obj address3 :%ld\n",obj)
            printf("ptr address3 :%ld\n",ptr)
            printf("self._head address3 :%ld\n",self._head)
            obj.next = ptr
            self._head = obj
            printf("obj address4 :%ld\n",obj)
            printf("ptr address4 :%ld\n",ptr)
            printf("self._head address4 :%ld\n",self._head)

    cpdef count(self, int data): # cpdef int count
        cdef _LinkedListStruct * ptr = self._head
        cdef int c = 0
        while ptr is not NULL:
            if ptr.data == data:
                c += 1
            ptr = ptr.next
        return c

    # cpdef reverse(self, LinkedList* source):
    #
    #     pass

    def  __iter__ (self):
        cdef  _LinkedListStruct * ptr  =  self._head
        while  ptr  is  not  NULL :
            yield  ptr.data
            ptr  =  ptr.next
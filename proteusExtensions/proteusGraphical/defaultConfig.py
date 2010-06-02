import os

PROTEUS = os.getenv('PROTEUS',os.getenv('HOME')+'/src/proteus')
PROTEUS_PREFIX = os.getenv('PROTEUS_PREFIX',PROTEUS+os.getenv('PROTEUS_ARCH'))
PROTEUS_GRAPHICAL = os.getenv('PROTEUS_GRAPHICAL',os.getenv('PROTEUS')+'/proteusExtensions/proteusGraphical')
PROTEUS_GRAPHICAL_EXTRA_COMPILE_ARGS= ['-Wall']
PROTEUS_GRAPHICAL_EXTRA_LINK_ARGS=['-lblas','-lstdc++']

PROTEUS_GRAPHICAL_VTK_INCLUDE_DIR = os.getenv('PROTEUS_PREFIX')+'/include/vtk-5.6'
PROTEUS_GRAPHICAL_VTK_LIB_DIR = os.getenv('PROTEUS_PREFIX')+'/lib/vtk-5.6'
PROTEUS_GRAPHICAL_VTK_LIBS = ['vtkCommon','vtkCommonPythonD','vtksys']

PROTEUS_TRIANGLE_INCLUDE_DIR = PROTEUS_PREFIX+'/include'
PROTEUS_TRIANGLE_H = r'"triangle.h"'
PROTEUS_TRIANGLE_LIB_DIR = PROTEUS_PREFIX+'/lib'
PROTEUS_TRIANGLE_LIB ='tri'

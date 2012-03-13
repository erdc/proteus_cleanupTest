import os

PROTEUS_INCLUDE_DIR = os.getenv('PROTEUS_PREFIX')+'/include'
PROTEUS_LIB_DIR = os.getenv('PROTEUS_PREFIX')+'/lib'
PROTEUS_EXTRA_COMPILE_ARGS= ['-DF77_POST_UNDERSCORE','-DUSE_BLAS','-DCMRVEC_BOUNDS_CHECK','-DMV_VECTOR_BOUNDS_CHECK']
PROTEUS_EXTRA_LINK_ARGS=['-lsci','-lstdc++']
PROTEUS_EXTRA_FC_COMPILE_ARGS= ['-Wall']
PROTEUS_EXTRA_FC_LINK_ARGS=['-lsci']

PROTEUS_SUPERLU_INCLUDE_DIR = PROTEUS_INCLUDE_DIR
PROTEUS_SUPERLU_H   = r'"slu_ddefs.h"'
PROTEUS_SUPERLU_LIB_DIR = PROTEUS_LIB_DIR
PROTEUS_SUPERLU_LIB = 'superlu'

PROTEUS_BLAS_INCLUDE_DIR   = '.'
PROTEUS_BLAS_H     = r'"proteus_blas.h"'
PROTEUS_BLAS_LIB_DIR = '.'
PROTEUS_BLAS_LIB   = 'sci'

PROTEUS_LAPACK_INCLUDE_DIR = '.'
PROTEUS_LAPACK_H   = r'"proteus_lapack.h"'
PROTEUS_LAPACK_LIB_DIR = '.'
PROTEUS_LAPACK_LIB = '-lsci'
PROTEUS_LAPACK_INTEGER = 'int'

PROTEUS_MPI_INCLUDE_DIR = '/opt/cray/mpt/5.1.2/xt/gemini/mpich2-gnu/include'
PROTEUS_MPI_LIB_DIR = '/opt/cray/mpt/5.1.2/xt/gemini/mpich2-gnu/lib'
PROTEUS_MPI_LIBS = ['mpich']

PROTEUS_TRIANGLE_INCLUDE_DIR = PROTEUS_INCLUDE_DIR
PROTEUS_TRIANGLE_H = r'"triangle.h"'
PROTEUS_TRIANGLE_LIB_DIR = PROTEUS_LIB_DIR
PROTEUS_TRIANGLE_LIB ='tri'


PROTEUS_DAETK_INCLUDE_DIR = [PROTEUS_INCLUDE_DIR]
PROTEUS_DAETK_LIB_DIR = PROTEUS_LIB_DIR
PROTEUS_DAETK_LIB ='daetk'
PROTEUS_PETSC_EXTRA_COMPILE_ARGS = []
PROTEUS_PETSC_EXTRA_LINKE_ARGS = []
PROTEUS_PETSC_LIB_DIRS = ['L/u/cekees/proteus/garnet.gnu/lib']
PROTEUS_PETSC_LIBS = ['petsc', 'parmetis', 'metis', 'pthread', 'sci', 'dl']
PROTEUS_PETSC_INCLUDE_DIRS = []

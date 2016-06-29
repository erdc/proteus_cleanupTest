#!/usr/bin/env python
"""
Test module for 2D Quadrilateral Meshes
"""

from proteus.iproteus import *
from proteus import Comm
comm = Comm.get()
Profiling.logLevel=7
Profiling.verbose=True
import numpy
import numpy.testing as npt
import Boperator_setup_template_2D as B_2d
from nose.tools import ok_ as ok
from nose.tools import eq_ as eq
from nose.tools import set_trace

class TestMassConstruction2D():
    """ Verify construction of 2D Mass Matrix using transport coefficients """
    def __init__(self):
        pass

    def setUp(self):
        """ Initialize the test problem """
        self.Boperator_object = B_2d.ns
        
    def tearDown(self):
        """ Tear down function """
        FileList = ['Mass_matrix_test.xmf',
                    'Mass_matrix_test.h5',
                    'reference_triangle_2d.ele',
                    'reference_triangle_2d.node',
                    'reference_triangle_2d.poly']
        for file in FileList:
            if os.path.isfile(file):
                os.remove(file)

    def test_1(self):
        """ An initial test of the coefficient class. """
        self.Boperator_object.modelList[0].levelModelList[0].calculateCoefficients()
        rowptr, colind, nzval = self.Boperator_object.modelList[0].levelModelList[0].jacobian.getCSRrepresentation()
        self.Boperator_object.modelList[0].levelModelList[0].scale_dt = False
        self.Asys_rowptr = rowptr.copy()
        self.Asys_colptr = colind.copy()
        self.Asys_nzval = nzval.copy()
        nn = len(self.Asys_rowptr)-1
        self.Asys = LinearAlgebraTools.SparseMatrix(nn,nn,
                                                    self.Asys_nzval.shape[0],
                                                    self.Asys_nzval,
                                                    self.Asys_colptr,
                                                    self.Asys_rowptr)
        self.petsc4py_A = self.Boperator_object.modelList[0].levelModelList[0].getJacobian(self.Asys)
        B_mat = LinearAlgebraTools.superlu_sparse_2_dense(self.petsc4py_A)
        import pdb
        pdb.set_trace()
        comparison_mat = numpy.loadtxt('mass_reference_c0p1_2D.txt')
        assert numpy.allclose(mass_mat,comparison_mat)


    def test_2(self):
        """ Tests the attachMassOperator function in one-level-transport """
        mm = self.Boperator_object.modelList[0].levelModelList[0]
        mm.attachMassOperator()
        mass_mat = LinearAlgebraTools.superlu_sparse_2_dense(mm.MassOperator)
        comparison_mat = numpy.loadtxt('mass_reference_c0p1_2D.txt')
        assert numpy.allclose(mass_mat,comparison_mat)

if __name__ == '__main__':
    tt = TestMassConstruction2D()
    tt.setUp()
    tt.test_1()
    tt.tearDown()

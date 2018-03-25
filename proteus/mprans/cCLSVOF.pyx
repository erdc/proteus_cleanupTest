import numpy
cimport numpy
from proteus import *
from proteus.Transport import *
from proteus.Transport import OneLevelTransport

cdef extern from "CLSVOF.h" namespace "proteus":
    cdef cppclass CLSVOF_base:
        void calculateResidual(double dt,
                               double* mesh_trial_ref,
                               double* mesh_grad_trial_ref,
                               double* mesh_dof,
                               double* mesh_velocity_dof,
                               double MOVING_DOMAIN,
                               int* mesh_l2g,
                               double* dV_ref,
                               double* u_trial_ref,
                               double* u_grad_trial_ref,
                               double* u_test_ref,
                               double* u_grad_test_ref,
                               double* mesh_trial_trace_ref,
                               double* mesh_grad_trial_trace_ref,
                               double* dS_ref,
                               double* u_trial_trace_ref,
                               double* u_grad_trial_trace_ref,
                               double* u_test_trace_ref,
                               double* u_grad_test_trace_ref,
                               double* normal_ref,
                               double* boundaryJac_ref,
                               int nElements_global,
                               double useMetrics,
                               double alphaBDF,
                               double* q_porosity,
                               double* porosity_dof,
                               int* u_l2g,
                               double* elementDiameter,
                               double* nodeDiametersArray,
                               int degree_polynomial,
                               double* u_dof,
                               double* u_dof_old,
                               double* velocity,
                               double* velocity_old,
                               double* q_m,
                               double* q_u,
                               double* q_m_betaBDF,
                               double* q_dV,
                               double* q_dV_last,
                               double* cfl,
                               int offset_u, int stride_u,
                               double* globalResidual,
                               int nExteriorElementBoundaries_global,
                               int* exteriorElementBoundariesArray,
                               int* elementBoundaryElementsArray,
                               int* elementBoundaryLocalElementBoundariesArray,
                               double* ebqe_velocity_ext,
                               double* ebqe_porosity_ext,
                               int* isDOFBoundary_u,
                               double* ebqe_bc_u_ext,
                               int* isFluxBoundary_u,
                               double* ebqe_bc_flux_u_ext,
                               double* ebqe_u,
                               double* ebqe_flux,
                               int timeOrder,
                               int timeStage,
                               double epsFactHeaviside,
                               double epsFactDirac,
                               double lambdaFact,
                               double* norm_factor,
                               double norm_factor_lagged,
                               double* lumped_qx,
                               double* lumped_qy,
                               double* lumped_qz,
                               double* lumped_qx_tStar,
                               double* lumped_qy_tStar,
                               double* lumped_qz_tStar,
                               double* quantDOFs)
        void calculateJacobian(double dt,
                               double* mesh_trial_ref,
                               double* mesh_grad_trial_ref,
                               double* mesh_dof,
                               double* mesh_velocity_dof,
                               double MOVING_DOMAIN,
                               int* mesh_l2g,
                               double* dV_ref,
                               double* u_trial_ref,
                               double* u_grad_trial_ref,
                               double* u_test_ref,
                               double* u_grad_test_ref,
                               double* mesh_trial_trace_ref,
                               double* mesh_grad_trial_trace_ref,
                               double* dS_ref,
                               double* u_trial_trace_ref,
                               double* u_grad_trial_trace_ref,
                               double* u_test_trace_ref,
                               double* u_grad_test_trace_ref,
                               double* normal_ref,
                               double* boundaryJac_ref,
                               int nElements_global,
                               double useMetrics,
                               double alphaBDF,
                               double* q_porosity,
                               int* u_l2g,
                               double* elementDiameter,
                               double* nodeDiametersArray,
                               int degree_polynomial,
                               double* u_dof,
                               double* u_dof_old,
                               double* velocity,
                               double* q_m_betaBDF,
                               double* cfl,
                               int* csrRowIndeces_u_u,int* csrColumnOffsets_u_u,
                               double* globalJacobian,
                               int nExteriorElementBoundaries_global,
                               int* exteriorElementBoundariesArray,
                               int* elementBoundaryElementsArray,
                               int* elementBoundaryLocalElementBoundariesArray,
                               double* ebqe_velocity_ext,
                               double* ebqe_porosity_ext,
                               int* isDOFBoundary_u,
                               double* ebqe_bc_u_ext,
                               int* isFluxBoundary_u,
                               double* ebqe_bc_flux_u_ext,
                               int* csrColumnOffsets_eb_u_u,
                               int timeOrder,
                               int timeStage,
                               double epsFactHeaviside,
                               double epsFactDirac,
                               double lambdaFact,
                               double norm_factor_lagged,
                               double* lumped_qx,
                               double* lumped_qy,
                               double* lumped_qz,
                               double* lumped_qx_tStar,
                               double* lumped_qy_tStar,
                               double* lumped_qz_tStar)
        void calculateMetricsAtEOS(double* mesh_trial_ref,
                                   double* mesh_grad_trial_ref,
                                   double* mesh_dof,
                                   int* mesh_l2g,
                                   double* dV_ref,
                                   double* u_trial_ref,
                                   double* u_grad_trial_ref,
                                   double* u_test_ref,
                                   int nElements_global,
                                   int useMetrics,
                                   int* u_l2g,
                                   double* elementDiameter,
                                   double* nodeDiametersArray,
                                   double degree_polynomial,
                                   double epsFactHeaviside,
                                   double* u_dof,
                                   double* u0_dof,
                                   double* u_exact,
                                   int offset_u, int stride_u,
                                   double* global_I_err,
                                   double* global_Ieps_err,
                                   double* global_V_err,
                                   double* global_Veps_err,
                                   double* global_D_err)
        void calculateMetricsAtETS(double dt,
                                   double* mesh_trial_ref,
                                   double* mesh_grad_trial_ref,
                                   double* mesh_dof,
                                   int* mesh_l2g,
                                   double* dV_ref,
                                   double* u_trial_ref,
                                   double* u_grad_trial_ref,
                                   double* u_test_ref,
                                   int nElements_global,
                                   int useMetrics,
                                   int* u_l2g,
                                   double* elementDiameter,
                                   double* nodeDiametersArray,
                                   double degree_polynomial,
                                   double epsFactHeaviside,
                                   double* u_dof,
                                   double* u_dof_old,
                                   double* u0_dof,
                                   double* velocity,
                                   int offset_u, int stride_u,
                                   int numDOFs,
                                   double* global_I_err,
                                   double* global_Ieps_err,
                                   double* global_V_err,
                                   double* global_Veps_err,
                                   double* global_D_err)
        void normalReconstruction(double* mesh_trial_ref,
                                  double* mesh_grad_trial_ref,
                                  double* mesh_dof,
                                  int* mesh_l2g,
                                  double* dV_ref,
                                  double* u_trial_ref,
                                  double* u_grad_trial_ref,
                                  double* u_test_ref,
                                  int nElements_global,
                                  int* u_l2g,
                                  double* elementDiameter,
                                  double* u_dof,
                                  int offset_u, int stride_u,
                                  int numDOFs,
                                  double* lumped_qx,
                                  double* lumped_qy,
                                  double* lumped_qz)
    CLSVOF_base* newCLSVOF(int nSpaceIn,
                           int nQuadraturePoints_elementIn,
                           int nDOF_mesh_trial_elementIn,
                           int nDOF_trial_elementIn,
                           int nDOF_test_elementIn,
                           int nQuadraturePoints_elementBoundaryIn,
                           int CompKernelFlag)

cdef class cCLSVOF_base:
   cdef CLSVOF_base* thisptr
   def __cinit__(self,
                 int nSpaceIn,
                 int nQuadraturePoints_elementIn,
                 int nDOF_mesh_trial_elementIn,
                 int nDOF_trial_elementIn,
                 int nDOF_test_elementIn,
                 int nQuadraturePoints_elementBoundaryIn,
                 int CompKernelFlag):
       self.thisptr = newCLSVOF(nSpaceIn,
                                nQuadraturePoints_elementIn,
                                nDOF_mesh_trial_elementIn,
                                nDOF_trial_elementIn,
                                nDOF_test_elementIn,
                                nQuadraturePoints_elementBoundaryIn,
                                CompKernelFlag)
   def __dealloc__(self):
       del self.thisptr
   def calculateResidual(self,
                         double dt,
                         numpy.ndarray mesh_trial_ref,
                         numpy.ndarray mesh_grad_trial_ref,
                         numpy.ndarray mesh_dof,
                         numpy.ndarray mesh_velocity_dof,
                         double MOVING_DOMAIN,
                         numpy.ndarray mesh_l2g,
                         numpy.ndarray dV_ref,
                         numpy.ndarray u_trial_ref,
                         numpy.ndarray u_grad_trial_ref,
                         numpy.ndarray u_test_ref,
                         numpy.ndarray u_grad_test_ref,
                         numpy.ndarray mesh_trial_trace_ref,
                         numpy.ndarray mesh_grad_trial_trace_ref,
                         numpy.ndarray dS_ref,
                         numpy.ndarray u_trial_trace_ref,
                         numpy.ndarray u_grad_trial_trace_ref,
                         numpy.ndarray u_test_trace_ref,
                         numpy.ndarray u_grad_test_trace_ref,
                         numpy.ndarray normal_ref,
                         numpy.ndarray boundaryJac_ref,
                         int nElements_global,
                         double useMetrics,
                         double alphaBDF,
                         numpy.ndarray q_porosity,
                         numpy.ndarray porosity_dof,
                         numpy.ndarray u_l2g,
                         numpy.ndarray elementDiameter,
                         numpy.ndarray nodeDiametersArray,
                         int degree_polynomial,
                         numpy.ndarray u_dof,
                         numpy.ndarray u_dof_old,
                         numpy.ndarray velocity,
                         numpy.ndarray velocity_old,
                         numpy.ndarray q_m,
                         numpy.ndarray q_u,
                         numpy.ndarray q_m_betaBDF,
                         numpy.ndarray q_dV,
                         numpy.ndarray q_dV_last,
                         numpy.ndarray cfl,
                         int offset_u, int stride_u,
                         numpy.ndarray globalResidual,
                         int nExteriorElementBoundaries_global,
                         numpy.ndarray exteriorElementBoundariesArray,
                         numpy.ndarray elementBoundaryElementsArray,
                         numpy.ndarray elementBoundaryLocalElementBoundariesArray,
                         numpy.ndarray ebqe_velocity_ext,
                         numpy.ndarray ebqe_porosity_ext,
                         numpy.ndarray isDOFBoundary_u,
                         numpy.ndarray ebqe_bc_u_ext,
                         numpy.ndarray isFluxBoundary_u,
                         numpy.ndarray ebqe_bc_flux_u_ext,
                         numpy.ndarray ebqe_u,
                         numpy.ndarray ebqe_flux,
                         int timeOrder,
                         int timeStage,
                         double epsFactHeaviside,
                         double epsFactDirac,
                         double lambdaFact,
                         numpy.ndarray norm_factor,
                         double norm_factor_lagged,
                         numpy.ndarray lumped_qx,
                         numpy.ndarray lumped_qy,
                         numpy.ndarray lumped_qz,
                         numpy.ndarray lumped_qx_tStar,
                         numpy.ndarray lumped_qy_tStar,
                         numpy.ndarray lumped_qz_tStar,
                         numpy.ndarray quantDOFs):
       self.thisptr.calculateResidual(dt,
                                      <double*> mesh_trial_ref.data,
                                      <double*> mesh_grad_trial_ref.data,
                                      <double*> mesh_dof.data,
                                      <double*> mesh_velocity_dof.data,
                                      MOVING_DOMAIN,
                                      <int*> mesh_l2g.data,
                                      <double*> dV_ref.data,
                                      <double*> u_trial_ref.data,
                                      <double*> u_grad_trial_ref.data,
                                      <double*> u_test_ref.data,
                                      <double*> u_grad_test_ref.data,
                                      <double*> mesh_trial_trace_ref.data,
                                      <double*> mesh_grad_trial_trace_ref.data,
                                      <double*> dS_ref.data,
                                      <double*> u_trial_trace_ref.data,
                                      <double*> u_grad_trial_trace_ref.data,
                                      <double*> u_test_trace_ref.data,
                                      <double*> u_grad_test_trace_ref.data,
                                      <double*> normal_ref.data,
                                      <double*> boundaryJac_ref.data,
                                      nElements_global,
                                      useMetrics,
                                      alphaBDF,
                                      <double*> q_porosity.data,
                                      <double*> porosity_dof.data,
                                      <int*> u_l2g.data,
                                      <double*> elementDiameter.data,
                                      <double*> nodeDiametersArray.data,
                                      degree_polynomial,
                                      <double*> u_dof.data,
                                      <double*> u_dof_old.data,
                                      <double*> velocity.data,
                                      <double*> velocity_old.data,
                                      <double*> q_m.data,
                                      <double*> q_u.data,
                                      <double*> q_m_betaBDF.data,
                                      <double*> q_dV.data,
                                      <double*> q_dV_last.data,
                                      <double*> cfl.data,
                                      offset_u, stride_u,
                                      <double*> globalResidual.data,
                                      nExteriorElementBoundaries_global,
                                      <int*> exteriorElementBoundariesArray.data,
                                      <int*> elementBoundaryElementsArray.data,
                                      <int*> elementBoundaryLocalElementBoundariesArray.data,
                                      <double*> ebqe_velocity_ext.data,
                                      <double*> ebqe_porosity_ext.data,
                                      <int*> isDOFBoundary_u.data,
                                      <double*> ebqe_bc_u_ext.data,
                                      <int*> isFluxBoundary_u.data,
                                      <double*> ebqe_bc_flux_u_ext.data,
                                      <double*> ebqe_u.data,
                                      <double*> ebqe_flux.data,
                                      timeOrder,
                                      timeStage,
                                      epsFactHeaviside,
                                      epsFactDirac,
                                      lambdaFact,
                                      <double*> norm_factor.data,
                                      norm_factor_lagged,
                                      <double*> lumped_qx.data,
                                      <double*> lumped_qy.data,
                                      <double*> lumped_qz.data,
                                      <double*> lumped_qx_tStar.data,
                                      <double*> lumped_qy_tStar.data,
                                      <double*> lumped_qz_tStar.data,
                                      <double*> quantDOFs.data)
   def calculateJacobian(self,
                         double dt,
                         numpy.ndarray mesh_trial_ref,
                         numpy.ndarray mesh_grad_trial_ref,
                         numpy.ndarray mesh_dof,
                         numpy.ndarray mesh_velocity_dof,
                         double MOVING_DOMAIN,
                         numpy.ndarray mesh_l2g,
                         numpy.ndarray dV_ref,
                         numpy.ndarray u_trial_ref,
                         numpy.ndarray u_grad_trial_ref,
                         numpy.ndarray u_test_ref,
                         numpy.ndarray u_grad_test_ref,
                         numpy.ndarray mesh_trial_trace_ref,
                         numpy.ndarray mesh_grad_trial_trace_ref,
                         numpy.ndarray dS_ref,
                         numpy.ndarray u_trial_trace_ref,
                         numpy.ndarray u_grad_trial_trace_ref,
                         numpy.ndarray u_test_trace_ref,
                         numpy.ndarray u_grad_test_trace_ref,
                         numpy.ndarray normal_ref,
                         numpy.ndarray boundaryJac_ref,
                         int nElements_global,
                         double useMetrics,
                         double alphaBDF,
                         numpy.ndarray q_porosity,
                         numpy.ndarray u_l2g,
                         numpy.ndarray elementDiameter,
                         numpy.ndarray nodeDiametersArray,
                         int degree_polynomial,
                         numpy.ndarray u_dof,
                         numpy.ndarray u_dof_old,
                         numpy.ndarray velocity,
                         numpy.ndarray q_m_betaBDF,
                         numpy.ndarray cfl,
                         numpy.ndarray csrRowIndeces_u_u,
                         numpy.ndarray csrColumnOffsets_u_u,
                         globalJacobian,
                         int nExteriorElementBoundaries_global,
                         numpy.ndarray exteriorElementBoundariesArray,
                         numpy.ndarray elementBoundaryElementsArray,
                         numpy.ndarray elementBoundaryLocalElementBoundariesArray,
                         numpy.ndarray ebqe_velocity_ext,
                         numpy.ndarray ebqe_porosity_ext,
                         numpy.ndarray isDOFBoundary_u,
                         numpy.ndarray ebqe_bc_u_ext,
                         numpy.ndarray isFluxBoundary_u,
                         numpy.ndarray ebqe_bc_flux_u_ext,
                         numpy.ndarray csrColumnOffsets_eb_u_u,
                         int timeOrder,
                         int timeStage,
                         double epsFactHeaviside,
                         double epsFactDirac,
                         double lambdaFact,
                         norm_factor_lagged,
                         numpy.ndarray lumped_qx,
                         numpy.ndarray lumped_qy,
                         numpy.ndarray lumped_qz,
                         numpy.ndarray lumped_qx_tStar,
                         numpy.ndarray lumped_qy_tStar,
                         numpy.ndarray lumped_qz_tStar):
       cdef numpy.ndarray rowptr,colind,globalJacobian_a
       (rowptr,colind,globalJacobian_a) = globalJacobian.getCSRrepresentation()
       self.thisptr.calculateJacobian(dt,
                                      <double*> mesh_trial_ref.data,
                                      <double*> mesh_grad_trial_ref.data,
                                      <double*> mesh_dof.data,
                                      <double*> mesh_velocity_dof.data,
                                      MOVING_DOMAIN,
                                      <int*> mesh_l2g.data,
                                      <double*> dV_ref.data,
                                      <double*> u_trial_ref.data,
                                      <double*> u_grad_trial_ref.data,
                                      <double*> u_test_ref.data,
                                      <double*> u_grad_test_ref.data,
                                      <double*> mesh_trial_trace_ref.data,
                                      <double*> mesh_grad_trial_trace_ref.data,
                                      <double*> dS_ref.data,
                                      <double*> u_trial_trace_ref.data,
                                      <double*> u_grad_trial_trace_ref.data,
                                      <double*> u_test_trace_ref.data,
                                      <double*> u_grad_test_trace_ref.data,
                                      <double*> normal_ref.data,
                                      <double*> boundaryJac_ref.data,
                                      nElements_global,
                                      useMetrics,
                                      alphaBDF,
                                      <double*> q_porosity.data,
                                      <int*> u_l2g.data,
                                      <double*> elementDiameter.data,
                                      <double*> nodeDiametersArray.data,
                                      degree_polynomial,
                                      <double*> u_dof.data,
                                      <double*> u_dof_old.data,
                                      <double*> velocity.data,
                                      <double*> q_m_betaBDF.data,
                                      <double*> cfl.data,
                                      <int*> csrRowIndeces_u_u.data,
                                      <int*> csrColumnOffsets_u_u.data,
                                      <double*> globalJacobian_a.data,
                                      nExteriorElementBoundaries_global,
                                      <int*> exteriorElementBoundariesArray.data,
                                      <int*> elementBoundaryElementsArray.data,
                                      <int*> elementBoundaryLocalElementBoundariesArray.data,
                                      <double*> ebqe_velocity_ext.data,
                                      <double*> ebqe_porosity_ext.data,
                                      <int*> isDOFBoundary_u.data,
                                      <double*> ebqe_bc_u_ext.data,
                                      <int*> isFluxBoundary_u.data,
                                      <double*> ebqe_bc_flux_u_ext.data,
                                      <int*> csrColumnOffsets_eb_u_u.data,
                                      timeOrder,
                                      timeStage,
                                      epsFactHeaviside,
                                      epsFactDirac,
                                      lambdaFact,
                                      norm_factor_lagged,
                                      <double*> lumped_qx.data,
                                      <double*> lumped_qy.data,
                                      <double*> lumped_qz.data,
                                      <double*> lumped_qx_tStar.data,
                                      <double*> lumped_qy_tStar.data,
                                      <double*> lumped_qz_tStar.data)
   def calculateMetricsAtEOS(self,
                             numpy.ndarray mesh_trial_ref,
                             numpy.ndarray mesh_grad_trial_ref,
                             numpy.ndarray mesh_dof,
                             numpy.ndarray mesh_l2g,
                             numpy.ndarray dV_ref,
                             numpy.ndarray u_trial_ref,
                             numpy.ndarray u_grad_trial_ref,
                             numpy.ndarray u_test_ref,
                             int nElements_global,
                             int useMetrics,
                             numpy.ndarray u_l2g,
                             numpy.ndarray elementDiameter,
                             numpy.ndarray nodeDiametersArray,
                             double degree_polynomial,
                             double epsFactHeaviside,
                             numpy.ndarray u_dof,
                             numpy.ndarray u0_dof,
                             numpy.ndarray u_exact,
                             int offset_u, int stride_u):
        cdef double global_I_err
        cdef double global_Ieps_err
        cdef double global_V_err
        cdef double global_Veps_err
        cdef double global_D_err
        self.thisptr.calculateMetricsAtEOS(<double*>mesh_trial_ref.data,
                                           <double*>mesh_grad_trial_ref.data,
                                           <double*>mesh_dof.data,
                                           <int*>mesh_l2g.data,
                                           <double*>dV_ref.data,
                                           <double*>u_trial_ref.data,
                                           <double*>u_grad_trial_ref.data,
                                           <double*>u_test_ref.data,
                                           nElements_global,
                                           useMetrics,
                                           <int*>u_l2g.data,
                                           <double*>elementDiameter.data,
                                           <double*>nodeDiametersArray.data,
                                           degree_polynomial,
                                           epsFactHeaviside,
                                           <double*>u_dof.data,
                                           <double*>u0_dof.data,
                                           <double*>u_exact.data,
                                           offset_u,
                                           stride_u,
                                           &global_I_err,
                                           &global_Ieps_err,
                                           &global_V_err,
                                           &global_Veps_err,
                                           &global_D_err)
        return(global_I_err,
               global_Ieps_err,
               global_V_err,
               global_Veps_err,
               global_D_err)
   def calculateMetricsAtETS(self,
                             double dt,
                             numpy.ndarray mesh_trial_ref,
                             numpy.ndarray mesh_grad_trial_ref,
                             numpy.ndarray mesh_dof,
                             numpy.ndarray mesh_l2g,
                             numpy.ndarray dV_ref,
                             numpy.ndarray u_trial_ref,
                             numpy.ndarray u_grad_trial_ref,
                             numpy.ndarray u_test_ref,
                             int nElements_global,
                             int useMetrics,
                             numpy.ndarray u_l2g,
                             numpy.ndarray elementDiameter,
                             numpy.ndarray nodeDiametersArray,
                             double degree_polynomial,
                             double epsFactHeaviside,
                             numpy.ndarray u_dof,
                             numpy.ndarray u_dof_old,
                             numpy.ndarray u0_dof,
                             numpy.ndarray velocity,
                             int offset_u, int stride_u,
                             int numDOFs):
        cdef double global_I_err
        cdef double global_Ieps_err
        cdef double global_V_err
        cdef double global_Veps_err
        cdef double global_D_err
        self.thisptr.calculateMetricsAtETS(dt,
                                           <double*>mesh_trial_ref.data,
                                           <double*>mesh_grad_trial_ref.data,
                                           <double*>mesh_dof.data,
                                           <int*>mesh_l2g.data,
                                           <double*>dV_ref.data,
                                           <double*>u_trial_ref.data,
                                           <double*>u_grad_trial_ref.data,
                                           <double*>u_test_ref.data,
                                           nElements_global,
                                           useMetrics,
                                           <int*>u_l2g.data,
                                           <double*>elementDiameter.data,
                                           <double*> nodeDiametersArray.data,
                                           degree_polynomial,
                                           epsFactHeaviside,
                                           <double*>u_dof.data,
                                           <double*>u_dof_old.data,
                                           <double*>u0_dof.data,
                                           <double*>velocity.data,
                                           offset_u,
                                           stride_u,
                                           numDOFs,
                                           &global_I_err,
                                           &global_Ieps_err,
                                           &global_V_err,
                                           &global_Veps_err,
                                           &global_D_err)
        return(global_I_err,
               global_Ieps_err,
               global_V_err,
               global_Veps_err,
               global_D_err)
   def normalReconstruction(self,
                            numpy.ndarray mesh_trial_ref,
                            numpy.ndarray mesh_grad_trial_ref,
                            numpy.ndarray mesh_dof,
                            numpy.ndarray mesh_l2g,
                            numpy.ndarray dV_ref,
                            numpy.ndarray u_trial_ref,
                            numpy.ndarray u_grad_trial_ref,
                            numpy.ndarray u_test_ref,
                            int nElements_global,
                            numpy.ndarray u_l2g,
                            numpy.ndarray elementDiameter,
                            numpy.ndarray u_dof,
                            int offset_u, int stride_u,
                            int numDOFs,
                            numpy.ndarray lumped_qx,
                            numpy.ndarray lumped_qy,
                            numpy.ndarray lumped_qz):
       self.thisptr.normalReconstruction(<double*> mesh_trial_ref.data,
                                         <double*> mesh_grad_trial_ref.data,
                                         <double*> mesh_dof.data,
                                         <int*> mesh_l2g.data,
                                         <double*> dV_ref.data,
                                         <double*> u_trial_ref.data,
                                         <double*> u_grad_trial_ref.data,
                                         <double*> u_test_ref.data,
                                         nElements_global,
                                         <int*> u_l2g.data,
                                         <double*> elementDiameter.data,
                                         <double*> u_dof.data,
                                         offset_u, stride_u,
                                         numDOFs,
                                         <double*> lumped_qx.data,
                                         <double*> lumped_qy.data,
                                         <double*> lumped_qz.data)

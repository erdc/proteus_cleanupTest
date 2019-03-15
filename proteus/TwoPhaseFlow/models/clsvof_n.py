from __future__ import absolute_import
from proteus import *
from proteus.default_n import *
from clsvof_p import *
<<<<<<< HEAD
=======
import clsvof_p as physics
>>>>>>> TwoPhaseFlow

# *********************************************** #
# ********** Read from myTpFlowProblem ********** #
# *********************************************** #
<<<<<<< HEAD
cfl = myTpFlowProblem.cfl
FESpace = myTpFlowProblem.FESpace
he = myTpFlowProblem.he
useSuperlu = myTpFlowProblem.useSuperlu
domain = myTpFlowProblem.domain
auxVariables = myTpFlowProblem.auxVariables
=======
ct = physics.ct
myTpFlowProblem = physics.myTpFlowProblem
nd = myTpFlowProblem.nd
cfl = myTpFlowProblem.cfl
FESpace = myTpFlowProblem.FESpace
useSuperlu = myTpFlowProblem.useSuperlu
domain = myTpFlowProblem.domain

params = myTpFlowProblem.Parameters
mparams = params.Models # model parameters
pparams = params.physical # physical parameters
meshparams = params.mesh
>>>>>>> TwoPhaseFlow

# *************************************** #
# ********** MESH CONSTRUCTION ********** #
# *************************************** #
<<<<<<< HEAD
triangleFlag = myTpFlowProblem.triangleFlag
nnx = myTpFlowProblem.nnx
nny = myTpFlowProblem.nny
nnz = myTpFlowProblem.nnz
triangleOptions = domain.MeshOptions.triangleOptions
=======
he = meshparams.he
triangleFlag = meshparams.triangleFlag
nnx = meshparams.nnx
nny = meshparams.nny
nnz = meshparams.nnz
triangleOptions = meshparams.triangleOptions
parallelPartitioningType = meshparams.parallelPartitioningType
nLayersOfOverlapForParallel = meshparams.nLayersOfOverlapForParallel
restrictFineSolutionToAllMeshes = meshparams.restrictFineSolutionToAllMeshes
>>>>>>> TwoPhaseFlow

# ************************************** #
# ********** TIME INTEGRATION ********** #
# ************************************** #
timeIntegration = BackwardEuler_cfl
stepController = Min_dt_controller
runCFL=cfl

# ******************************************* #
# ********** FINITE ELEMENT SAPCES ********** #
# ******************************************* #
elementQuadrature = FESpace['elementQuadrature']
elementBoundaryQuadrature = FESpace['elementBoundaryQuadrature']
femSpaces = {0: FESpace['lsBasis']}

# ************************************** #
# ********** NONLINEAR SOLVER ********** #
# ************************************** #
multilevelNonlinearSolver  = Newton
levelNonlinearSolver = CLSVOFNewton
fullNewtonFlag = True
updateJacobian = True
nonlinearSmoother = None

# ************************************ #
# ********** NUMERICAL FLUX ********** #
# ************************************ #
numericalFluxType = CLSVOF.NumericalFlux

# ************************************ #
# ********** LINEAR ALGEBRA ********** #
# ************************************ #
matrix = SparseMatrix
linearSmoother = None
multilevelLinearSolver = KSP_petsc4py
levelLinearSolver      = KSP_petsc4py
if useSuperlu:
    multilevelLinearSolver = LU
    levelLinearSolver      = LU
#
linear_solver_options_prefix = 'clsvof_'
linearSolverConvergenceTest = 'r-true'

# ******************************** #
# ********** TOLERANCES ********** #
# ******************************** #
<<<<<<< HEAD
clsvof_nl_atol_res = max(1.0e-8, 0.01 * he ** 2)
eps_tolerance_clsvof = clsvof_parameters['eps_tolerance_clsvof']
=======
clsvof_nl_atol_res = max(1.0e-8, 0.001 * he ** 2)
eps_tolerance_clsvof = mparams.clsvof['eps_tolerance_clsvof']
>>>>>>> TwoPhaseFlow
if eps_tolerance_clsvof:
    nl_atol_res = 1E-12
else:
    nl_atol_res=clsvof_nl_atol_res
#
<<<<<<< HEAD
l_atol_res = 0.1*nl_atol_res
tolFac=0.
maxNonlinearIts = 50

# *********************************** #
# ********** AUX VARIABLES ********** #
# *********************************** #
if auxVariables is not None:
    if 'clsvof' in auxVariables:
        auxiliaryVariables=auxVariables['clsvof']
=======
l_atol_res = nl_atol_res
tolFac=0.
maxNonlinearIts = 50
>>>>>>> TwoPhaseFlow

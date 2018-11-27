"""
Non linear waves
"""
import proteus.MeshTools
from proteus import Domain, Context
from proteus.mprans import SpatialTools as st
from proteus import WaveTools as wt
from proteus.mprans import BoundaryConditions as bc
import math
import numpy as np

opts=Context.Options([
    # predefined test cases
    ("water_level", 1.0, "Water level from y=0"),
    # tank
    ("generation", True, "Generate waves at the left boundary (True/False)"),
    ("absorption", False, "Absorb waves at the right boundary (True/False)"),
    ("tank_sponge", (1.,1.), "Length of relaxation zones zones in m (left, right)"),
    ("free_slip", True, "Should tank walls have free slip conditions "
                        "(otherwise, no slip conditions will be applied)."),
    # gravity
    ("g", [0, 0, -9.81], "Gravity vector in m/s^2"),
    # waves
    ("waves", True, "Generate waves (True/False)"),
    ("wave_height", 0.45, "Height of the waves in s"),
    ("wave_dir", (1.,0.,0.), "Direction of the waves (from left boundary)"),
    ("wave_type", 'solitaryWave', "type of wave"),
    ("fast", False, "switch for fast cosh calculations in WaveTools"),
    #tanks
    ("width", 0.25, "Width and height of the triangular obstacle in m"),
    ("runup", 5., "x coordinate of the start of the obstacle in m"),
    ("slopeX", 15., "x component of slope i.e. 'y:x'"),
    ("height", 2., "Height of the tank in m"),
    ("tank_dim", (22.5, 0.25, 2.), "Overall tank dimensionsin m"),
    # gauges
    ("point_gauge_output", False, "Produce point gauge output"),
    ("column_gauge_output", False, "Produce column gauge output"),
    ("gauge_dx", 0.25, "Horizontal spacing of point gauges/column gauges in m"),
    # mesh refinement
    ("refinement", False, "Gradual refinement"),
    ("he", 0.1, "Set characteristic element size in m"),
    ("he_max", 10, "Set maximum characteristic element size in m"),
    ("he_max_water", 10, "Set maximum characteristic in water phase in m"),
    ("refinement_freesurface", 0.05,"Set area of constant refinement around free surface (+/- value) in m"),
    ("refinement_caisson", 0.,"Set area of constant refinement (Box) around potential structure (+/- value) in m"),
    ("refinement_grading", np.sqrt(1.1*4./np.sqrt(3.))/np.sqrt(1.*4./np.sqrt(3)), "Grading of refinement/coarsening (default: 10% volume)"),
    # numerical options
    ("gen_mesh", True, "True: generate new mesh every time. False: do not generate mesh if file exists"),
    ("use_gmsh", False, "True: use Gmsh. False: use Triangle/Tetgen"),
    ("movingDomain", False, "True/False"),
    ("T", 5., "Simulation time in s"),
    ("dt_init", 0.001, "Initial time step in s"),
    ("dt_fixed", None, "Fixed (maximum) time step"),
    ("timeIntegration", "backwardEuler", "Time integration scheme (backwardEuler/VBDF)"),
    ("cfl", 0.5 , "Target cfl"),
    ("nsave",  10, "Number of time steps to save per second"),
    ("useRANS", 0, "RANS model"),
    ])

# ----- CONTEXT ------ #

# waves
omega = 1.
if opts.waves is True:
    height = opts.wave_height
    mwl = depth = opts.water_level
    direction = opts.wave_dir
    wave = wt.SolitaryWave(	waveHeight = height, 
				mwl = mwl, 
				depth = depth,
               			g = np.array(opts.g), 
				waveDir = direction,
				trans = np.array([-8., 0., 0.]),
                       		fast = opts.fast
			  )

# ----- DOMAIN ----- #
useHex = False
he = opts.he
height = opts.height
Refinement = opts.he

gen = -opts.tank_sponge[1]
runup = opts.runup
slopeX = opts.slopeX
width = opts.width
xPslope = 1.5*slopeX
domainX = xPslope


L = ( domainX, width, height)
    
nLevels = 1
weak_bc_penalty_constant = 100.0

quasi2D=False
if quasi2D:#make tank one element wide
    L = (L[0],he,L[2])

#parallelPartitioningType = proteus.MeshTools.MeshParallelPartitioningTypes.element
parallelPartitioningType = proteus.MeshTools.MeshParallelPartitioningTypes.node
nLayersOfOverlapForParallel = 0

structured=False  
#structured=True # Trying out a structured mesh

if useHex:   
    nnx=4*Refinement+1
    nny=2*Refinement+1
    hex=True    
    domain = Domain.RectangularDomain(L)
else:
    boundaries=['x-','x+','z-','z+','y+','y-']
    boundaryTags=dict([(key,i+1) for (i,key) in enumerate(boundaries)])
    if structured:
        nnx=4*Refinement
        nny=2*Refinement
    else:
        vertices = [[0.0,0.0,0.0], [L[0],0.0,1.5], [L[0],L[1],1.5], [0.0,L[1],0.0],
                    [0.0,0.0,L[2]], [L[0],0.0,L[2]], [L[0],L[1],L[2]], [0.0,L[1],L[2]]]
        vertexFlags = [boundaryTags['z-'], boundaryTags['z-'], boundaryTags['z-'], boundaryTags['z-'],
                       boundaryTags['z+'], boundaryTags['z+'], boundaryTags['z+'], boundaryTags['z+']]
        facets = [[[0,1,2,3]], [[0,1,5,4]], [[0,3,7,4]],
                  [[2,1,5,6]], [[3,2,6,7]], [[7,6,5,4]]]
        segments = []
        segmentFlags = []
        volumes = [[[0, 1]]]
        facetFlags = [boundaryTags['z-'], boundaryTags['y-'], boundaryTags['x-'],
                      boundaryTags['x+'], boundaryTags['y+'], boundaryTags['z-']]
        regions = [[9.0, L[1]/2, 1.3]]
        regionFlags = [1]
        regionIndice = {'tank': 0}

        domain = Domain.PiecewiseLinearComplexDomain(vertices=vertices,
                                                     vertexFlags=vertexFlags,
                                                     facets=facets,
                                                     facetFlags=facetFlags,
                                                     regions=regions,
                                                     regionFlags=regionFlags)
        
        #go ahead and add a boundary tags member 
        domain.boundaryTags = boundaryTags
        domain.writePoly("mesh")
        domain.writePLY("mesh")
#        domain.writeAsymptote("mesh")
        triangleOptions="KVApq1.4q12feena%21.16e" % ((he**3)/6.0,)


# refinement
smoothing = 0

# ----- GENERATION / ABSORPTION LAYERS ----- #

#domain = Domain.PiecewiseLinearComplexDomain()


tank_dim = opts.tank_dim

#domain = Domain.RectangularDomain(tank_dim)

tank_sponge = opts.tank_sponge
waterLevel = opts.water_level
dragAlpha = 5.*omega/1e-6

tank = st.Tank3D(domain )

tank.setSponge(x_n=tank_sponge[0], x_p=tank_sponge[1])
 
if opts.generation:
    tank.setGenerationZones(x_n=True, waves=wave, dragAlpha=dragAlpha, smoothing = smoothing)
if opts.absorption:
    tank.setAbsorptionZones(x_p=True, dragAlpha = dragAlpha)

# ----- BOUNDARY CONDITIONS ----- #

# Waves
tank.BC['x-'].setUnsteadyTwoPhaseVelocityInlet(wave, smoothing=smoothing, vert_axis=2)

# open top
tank.BC['z+'].setAtmosphere()

if opts.free_slip:
    tank.BC['z-'].setFreeSlip()
    tank.BC['y-'].setFreeSlip()
    tank.BC['y+'].setFreeSlip()
    tank.BC['x+'].setFreeSlip()
    if not opts.generation:
        tank.BC['x-'].setFreeSlip()
else:  # no slip
    tank.BC['z-'].setNoSlip()
    tank.BC['x+'].setNoSlip()

# sponge
tank.BC['sponge'].setNonMaterial()

for bc in tank.BC_list:
    bc.setFixedNodes()

# ----- GAUGES ----- #

column_gauge_locations = []
point_gauge_locations = []

                    

# ----- ASSEMBLE DOMAIN ----- #

domain.MeshOptions.use_gmsh = opts.use_gmsh
domain.MeshOptions.genMesh = opts.gen_mesh
domain.MeshOptions.he = opts.he
domain.use_gmsh = opts.use_gmsh
st.assembleDomain(domain)

# ----- REFINEMENT OPTIONS ----- #

import MeshRefinement as mr
#domain.MeshOptions = mr.MeshOptions(domain)
tank.MeshOptions = mr.MeshOptions(tank)
if opts.refinement:
    grading = opts.refinement_grading
    he2 = opts.he
    def mesh_grading(start, he, grading):
        return '{0}*{2}^(1+log((-1/{2}*(abs({1})-{0})+abs({1}))/{0})/log({2}))'.format(he, start, grading)
    he_max = opts.he_max
    # he_fs = he2
    ecH = 3.
    if opts.refinement_freesurface > 0:
        box = opts.refinement_freesurface
    else:
        box = ecH*he2
    tank.MeshOptions.refineBox(he2, he_max, -tank_sponge[0], tank_dim[0]+tank_sponge[1], waterLevel-box, waterLevel+box)
    tank.MeshOptions.setRefinementFunction(mesh_grading(start='y-{0}'.format(waterLevel-box), he=he2, grading=grading))
    tank.MeshOptions.setRefinementFunction(mesh_grading(start='y-{0}'.format(waterLevel+box), he=he2, grading=grading))
    domain.MeshOptions.LcMax = he_max #coarse grid
    if opts.use_gmsh is True and opts.refinement is True:
        domain.MeshOptions.he = he_max #coarse grid
    else:
        domain.MeshOptions.he = he2 #coarse grid
        domain.MeshOptions.LcMax = he2 #coarse grid
    tank.MeshOptions.refineBox(opts.he_max_water, he_max, -tank_sponge[0], tank_dim[0]+tank_sponge[1], 0., waterLevel)
else:
    domain.MeshOptions.LcMax = opts.he
mr._assembleRefinementOptions(domain)
st.assembleDomain(domain)
from proteus import Comm
comm = Comm.get()
if domain.use_gmsh is True:
    mr.writeGeo(domain, 'mesh', append=False)



##########################################
# Numerical Options and other parameters #
##########################################

rho_0=998.2
nu_0 =1.004e-6
rho_1=1.205
nu_1 =1.500e-5
sigma_01=0.0
g = opts.g




from math import *
from proteus import MeshTools, AuxiliaryVariables
import numpy
import proteus.MeshTools
from proteus import Domain
from proteus.Profiling import logEvent
from proteus.default_n import *
from proteus.ctransportCoefficients import smoothedHeaviside
from proteus.ctransportCoefficients import smoothedHeaviside_integral


#----------------------------------------------------
# Boundary conditions and other flags
#----------------------------------------------------
movingDomain=opts.movingDomain
checkMass=False
applyCorrection=True
applyRedistancing=True
freezeLevelSet=True

#----------------------------------------------------
# Time stepping and velocity
#----------------------------------------------------
weak_bc_penalty_constant = 100.0
dt_init = opts.dt_init
T = opts.T
nDTout = int(opts.T*opts.nsave)
timeIntegration = opts.timeIntegration
if nDTout > 0:
    dt_out= (T-dt_init)/nDTout
else:
    dt_out = 0
runCFL = opts.cfl
dt_fixed = opts.dt_fixed

#----------------------------------------------------

#  Discretization -- input options
useOldPETSc= False
useSuperlu = not True
spaceOrder = 1
useHex     = False
structured = False
useRBLES   = 0.0
useMetrics = 1.0
useVF = 1.0
useOnlyVF = False
useRANS = opts.useRANS # 0 -- None
            # 1 -- K-Epsilon
            # 2 -- K-Omega, 1998
            # 3 -- K-Omega, 1988
# Input checks
if spaceOrder not in [1,2]:
    print "INVALID: spaceOrder" + spaceOrder
    sys.exit()

if useRBLES not in [0.0, 1.0]:
    print "INVALID: useRBLES" + useRBLES
    sys.exit()

if useMetrics not in [0.0, 1.0]:
    print "INVALID: useMetrics"
    sys.exit()

#  Discretization
nd = 3
if spaceOrder == 1:
    hFactor=1.0
    if useHex:
	 basis=C0_AffineLinearOnCubeWithNodalBasis
         elementQuadrature = CubeGaussQuadrature(nd,3)
         elementBoundaryQuadrature = CubeGaussQuadrature(nd-1,3)
    else:
    	 basis=C0_AffineLinearOnSimplexWithNodalBasis
         elementQuadrature = SimplexGaussQuadrature(nd,3)
         elementBoundaryQuadrature = SimplexGaussQuadrature(nd-1,3)
         #elementBoundaryQuadrature = SimplexLobattoQuadrature(nd-1,1)
elif spaceOrder == 2:
    hFactor=0.5
    if useHex:
	basis=C0_AffineLagrangeOnCubeWithNodalBasis
        elementQuadrature = CubeGaussQuadrature(nd,4)
        elementBoundaryQuadrature = CubeGaussQuadrature(nd-1,4)
    else:
	basis=C0_AffineQuadraticOnSimplexWithNodalBasis
        elementQuadrature = SimplexGaussQuadrature(nd,4)
        elementBoundaryQuadrature = SimplexGaussQuadrature(nd-1,4)


# Numerical parameters
sc = 0.5 # default: 0.5. Test: 0.25
sc_beta = 1.5 # default: 1.5. Test: 1.
epsFact_consrv_diffusion = 1. # default: 1.0. Test: 0.1
ns_forceStrongDirichlet = False
backgroundDiffusionFactor=0.01
if useMetrics:
    ns_shockCapturingFactor  = sc
    ns_lag_shockCapturing = True
    ns_lag_subgridError = True
    ls_shockCapturingFactor  = sc
    ls_lag_shockCapturing = True
    ls_sc_uref  = 1.0
    ls_sc_beta  = sc_beta
    vof_shockCapturingFactor = sc
    vof_lag_shockCapturing = True
    vof_sc_uref = 1.0
    vof_sc_beta = sc_beta
    rd_shockCapturingFactor  =sc
    rd_lag_shockCapturing = False
    epsFact_density    = 3.
    epsFact_viscosity  = epsFact_curvature  = epsFact_vof = epsFact_consrv_heaviside = epsFact_consrv_dirac = epsFact_density
    epsFact_redistance = 0.33
    epsFact_consrv_diffusion = epsFact_consrv_diffusion
    redist_Newton = True#False
    kappa_shockCapturingFactor = sc
    kappa_lag_shockCapturing = True
    kappa_sc_uref = 1.0
    kappa_sc_beta = sc_beta
    dissipation_shockCapturingFactor = sc
    dissipation_lag_shockCapturing = True
    dissipation_sc_uref = 1.0
    dissipation_sc_beta = sc_beta
else:
    ns_shockCapturingFactor  = 0.9
    ns_lag_shockCapturing = True
    ns_lag_subgridError = True
    ls_shockCapturingFactor  = 0.9
    ls_lag_shockCapturing = True
    ls_sc_uref  = 1.0
    ls_sc_beta  = 1.0
    vof_shockCapturingFactor = 0.9
    vof_lag_shockCapturing = True
    vof_sc_uref  = 1.0
    vof_sc_beta  = 1.0
    rd_shockCapturingFactor  = 0.9
    rd_lag_shockCapturing = False
    epsFact_density    = 1.5
    epsFact_viscosity  = epsFact_curvature  = epsFact_vof = epsFact_consrv_heaviside = epsFact_consrv_dirac = epsFact_density
    epsFact_redistance = 0.33
    epsFact_consrv_diffusion = 10.0
    redist_Newton = False#True
    kappa_shockCapturingFactor = 0.9
    kappa_lag_shockCapturing = True#False
    kappa_sc_uref  = 1.0
    kappa_sc_beta  = 1.0
    dissipation_shockCapturingFactor = 0.9
    dissipation_lag_shockCapturing = True#False
    dissipation_sc_uref  = 1.0
    dissipation_sc_beta  = 1.0

ns_nl_atol_res = max(1.0e-6,0.001*domain.MeshOptions.he**2)
vof_nl_atol_res = max(1.0e-6,0.001*domain.MeshOptions.he**2)
ls_nl_atol_res = max(1.0e-6,0.001*domain.MeshOptions.he**2)
mcorr_nl_atol_res = max(1.0e-6,0.0001*domain.MeshOptions.he**2)
rd_nl_atol_res = max(1.0e-6,0.01*domain.MeshOptions.he)
kappa_nl_atol_res = max(1.0e-6,0.001*domain.MeshOptions.he**2)
dissipation_nl_atol_res = max(1.0e-6,0.001*domain.MeshOptions.he**2)
mesh_nl_atol_res = max(1.0e-6,0.001*domain.MeshOptions.he**2)

#turbulence
ns_closure=0 #1-classic smagorinsky, 2-dynamic smagorinsky, 3 -- k-epsilon, 4 -- k-omega

if useRANS == 1:
    ns_closure = 3
elif useRANS >= 2:
    ns_closure == 4

def twpflowPressure_init(x, t):
    p_L = 0.0
    phi_L = tank_dim[nd-1] - waterLevel
    phi = x[nd-1] - waterLevel
    return p_L -g[nd-1]*(rho_0*(phi_L - phi)+(rho_1 -rho_0)*(smoothedHeaviside_integral(epsFact_consrv_heaviside*opts.he,phi_L)
                                                         -smoothedHeaviside_integral(epsFact_consrv_heaviside*opts.he,phi)))
 

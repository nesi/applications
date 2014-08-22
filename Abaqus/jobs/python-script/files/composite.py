from abaqus import * #access to Abaqus objects and to a default model database mdb.
from abaqusConstants import * #to make the Symbolic Constants defined by Abaqus Scripting Interface available to the script
session.Viewport(name='Viewport: 1', origin=(0.0, 0.0), width=367.801208496094, 
    height=267.457122802734)
session.viewports['Viewport: 1'].makeCurrent()
session.viewports['Viewport: 1'].maximize()
from caeModules import *
from driverUtils import executeOnCaeStartup
executeOnCaeStartup()
session.viewports['Viewport: 1'].partDisplay.geometryOptions.setValues(
    referenceRepresentation=ON)
#Create a new model named Model-1 stored in the model database mdb assigned to a variable called s
####
####
####
#Create a new Sketch named __profile__
s = mdb.models['Model-1'].ConstrainedSketch(name='__profile__', 
    sheetSize=400.0)
g, v, d, c = s.geometry, s.vertices, s.dimensions, s.constraints
s.setPrimaryObject(option=STANDALONE)
# Parameters
#List of the cylinders' diameters
CylDiam= (20. , 10., 5., 1.)
#List of the distances between the different 'blocs' of cylinders with the same diameter
distance_part= (25.,15.,10.,5.)
#distance between the rows in the same line
distance_row= 25.
#Number of line (cylinders with the same diameter)
Nbofline=1
#Number of row in a line
Nbofrow=3
#First abscissa for the first cylinder's center 
xcoord_ini=0
xcoord=xcoord_ini
Matrice_extrusion=20.
#Cylinders construction 
#Loop for the different diameters 
for i in range(0,len(CylDiam)):
#Loop for the different lines with the same diameter
	for k in range (0,Nbofline):
	#Loop for the row in the same line
		for j in range(0, Nbofrow):
			s.CircleByCenterPerimeter(center=(xcoord, j*distance_row), point1=(CylDiam[i]/2.+xcoord, j*distance_row))
#			
#			
		#incrementation  of the abscissa coordinate to change the line
		xcoord=xcoord+distance_part[i]
#		
		#Create a new Part assigned to the variable p
		p = mdb.models['Model-1'].Part(name='cylin-'+str(i)+str(k), dimensionality=THREE_D, type=DEFORMABLE_BODY)
		p = mdb.models['Model-1'].parts['cylin-'+str(i)+str(k)]
		#extrusion of an entire line= one part
		p.BaseSolidExtrude(sketch=s, depth= Matrice_extrusion*3)
		s.unsetPrimaryObject()
		p = mdb.models['Model-1'].parts['cylin-'+str(i)+str(k)]
		session.viewports['Viewport: 1'].setValues(displayedObject=p)
		#delete the Sketch
		del mdb.models['Model-1'].sketches['__profile__']	
		s = mdb.models['Model-1'].ConstrainedSketch(name='__profile__',sheetSize=400.0)
#
#		
#Rotation of the different parts (=lines of cylinders)
rotation=mdb.models['Model-1'].rootAssembly
rotation.DatumCsysByDefault(CARTESIAN)
#
#
#Loops to select the part and add part to a list
angle=5.0
for i in range(0,len(CylDiam)):
	for k in range (0,Nbofline):	
		p = mdb.models['Model-1'].parts['cylin-'+str(i)+str(k)]
		rotation.Instance(name='cylin-'+str(i)+str(k), part=p, dependent=ON)
		rotation.rotate(instanceList=('cylin-'+str(i)+str(k), ), axisPoint=(0.0, 0.0, 0.0), axisDirection=(1.0, 0.0, 0.0), angle=k*angle)
#
#
#Creation of the matrice
#Parameters
Matrice_first_corner=(xcoord_ini-distance_part[0],-distance_row)
Matrice_sec_corner=(xcoord+distance_part[len(distance_part)-1], Nbofrow*distance_row)
Matrice_translat_vector=(0.0,0.0,Matrice_extrusion*3/2)
#
#
#Construction and extrusion of the matrice
s.rectangle(point1=Matrice_first_corner, point2=Matrice_sec_corner)
p = mdb.models['Model-1'].Part(name='Matrice', dimensionality=THREE_D, type=DEFORMABLE_BODY)
p = mdb.models['Model-1'].parts['Matrice']
p.BaseSolidExtrude(sketch=s, depth=Matrice_extrusion)
del mdb.models['Model-1'].sketches['__profile__']
a = mdb.models['Model-1'].rootAssembly
#
#
#Creation of materials
mdb.models['Model-1'].Material(name='material_matrice', description='Silicon')
mdb.models['Model-1'].materials['material_matrice'].Elastic(table=((3000000.0, 
    0.4), ))
mdb.models['Model-1'].Material(name='Material_cylinders', description='Carbon')
mdb.models['Model-1'].materials['Material_cylinders'].Elastic(table=((
    3000000000.0, 0.3), ))\
#
#
#Creation of the Sections
##
mdb.models['Model-1'].HomogeneousSolidSection(name='Section_Matrice', 
    material='material_matrice', thickness=5000000)
mdb.models['Model-1'].HomogeneousSolidSection(name='Section_Cylinders', 
    material='Material_cylinders', thickness=50000000)
#
#
#Assigment of the Sections
##For the matrice
sm = mdb.models['Model-1'].parts['Matrice']
session.viewports['Viewport: 1'].setValues(displayedObject=sm)
sm = mdb.models['Model-1'].parts['Matrice']
c = sm.cells
cells = c.getSequenceFromMask(mask=('[#1 ]', ), )
region = sm.Set(cells=cells, name='Set-Matrice')
sm = mdb.models['Model-1'].parts['Matrice']
sm.SectionAssignment(region=region, sectionName='Section_Matrice', offset=0.0, 
    offsetType=MIDDLE_SURFACE, offsetField='', 
    thicknessAssignment=FROM_SECTION)
#
#For the Cylinders
for i in range(0,len(CylDiam)):
	for k in range (0,Nbofline):	
		sc = mdb.models['Model-1'].parts['cylin-'+str(i)+str(k)]
		c = sc.cells
		cells = c.getSequenceFromMask(mask=('[#7 ]', ), )
		region = sc.Set(cells=cells, name='Set-Cylinders')
		sc = mdb.models['Model-1'].parts['cylin-'+str(i)+str(k)]
		sc.SectionAssignment(region=region, sectionName='Section_Cylinders', offset=0.0, 
		offsetType=MIDDLE_SURFACE, offsetField='', 
			thicknessAssignment=FROM_SECTION)
#
#
# ASSEMBLY MODULE
#
#
#translation of the matrice to place it between cylinders' bases
a.Instance(name='Matrice-1', part=p, dependent=ON)
a.translate(instanceList=('Matrice-1', ), vector=Matrice_translat_vector)
#
#
#Build holes into the matrice
#List to save cylinders'names
list_call_cylind=[]
list_cyl_names=[]
for i in range(0,len(CylDiam)):
	for k in range (0,Nbofline):
		list_call_cylind.append(a.instances['cylin-'+str(i)+str(k)])
		list_cyl_names.append("cylin-"+str(i)+str(k))
#
#		
#change the list in a tuple to be use in the cutting function
Cylin_holes=tuple(list_call_cylind)
#
a.InstanceFromBooleanCut(name='Matrice_hole', instanceToBeCut=mdb.models['Model-1'].rootAssembly.instances['Matrice-1'], cuttingInstances=Cylin_holes, originalInstances=SUPPRESS)
#
############ test with merge directly######################
list_call_cylind.append(a.instances['Matrice_hole-1'])
Merge_instances=tuple(list_call_cylind)
#Merge the matrice with holes and the cylinders 
cyl_names=tuple(list_cyl_names)
#
a.resumeFeatures(cyl_names)
a.InstanceFromBooleanMerge(name='Matrice_Tall_Cyl', instances=Merge_instances, keepIntersections=ON, originalInstances=SUPPRESS, domain=GEOMETRY)
a.features['Matrice-1'].resume()
#
#Cut the merge part with the simple matrice-> cylinders'remains
a.InstanceFromBooleanCut(name='Cylin_remains', 
	instanceToBeCut=mdb.models['Model-1'].rootAssembly.instances['Matrice_Tall_Cyl-1'], 
	cuttingInstances=(a.instances['Matrice-1'], ),originalInstances=SUPPRESS)
#	
#	
#Cut the merge part with cylinders'remains-> composite
a.features['Matrice_Tall_Cyl-1'].resume()
a.InstanceFromBooleanCut(name='Composite', 
    instanceToBeCut=mdb.models['Model-1'].rootAssembly.instances['Matrice_Tall_Cyl-1'], 
    cuttingInstances=(a.instances['Cylin_remains-1'], ), 
   originalInstances=SUPPRESS)
#
#
# STEP MODULE
#
#
#Creation of the "STEP"
step = mdb.models['Model-1'].rootAssembly
session.viewports['Viewport: 1'].setValues(displayedObject=step)
session.viewports['Viewport: 1'].assemblyDisplay.setValues(
    optimizationTasks=OFF, geometricRestrictions=OFF, stopConditions=OFF)
session.viewports['Viewport: 1'].assemblyDisplay.setValues(
    adaptiveMeshConstraints=ON)
mdb.models['Model-1'].StaticStep(name='Step-1_trial', previous='Initial')
session.viewports['Viewport: 1'].assemblyDisplay.setValues(step='Step-1_trial')
#
#Output results
mdb.models['Model-1'].FieldOutputRequest(name='F-Output-2', 
    createStepName='Step-1_trial', variables=('S', 'MISES', 'MISESMAX', 'E', 
    'U', 'UT', 'UR', 'RF'))

#
#
#LOAD MODULE :
#
#
#Creation of the Boundaries conditions
boundaries = mdb.models['Model-1'].rootAssembly
f1 = boundaries.instances['Composite-1'].faces
faces1 = f1.getSequenceFromMask(mask=('[#1000000 ]', ), )
region = boundaries.Set(faces=faces1, name='Set-1')
mdb.models['Model-1'].PinnedBC(name='BC-1', createStepName='Step-1_trial', 
	region=region, localCsys=None)
#
#
#
#Creation of the Displacement
displacement = mdb.models['Model-1'].rootAssembly
f_d = displacement.instances['Composite-1'].faces
faces1 = f_d.getSequenceFromMask(mask=('[#2000000 ]', ), )
region = displacement.Set(faces=faces1, name='Set-2')
mdb.models['Model-1'].DisplacementBC(name='BC-2', createStepName='Step-1_trial', 
    region=region, u1=UNSET, u2=UNSET, u3=-15.0, ur1=UNSET, ur2=UNSET, 
    ur3=UNSET, amplitude=UNSET, fixed=OFF, distributionType=UNIFORM, 
    fieldName='', localCsys=None)
#
#
#MESH MODULE :
#
#Creation of the Meshing
#To MEsh on the part : Composite
p_mesh = mdb.models['Model-1'].parts['Composite']
session.viewports['Viewport: 1'].setValues(displayedObject=p_mesh)
#
#Seed Part
p_seed = mdb.models['Model-1'].parts['Composite']
p_seed.seedPart(size=10.0, deviationFactor=0.1, minSizeFactor=0.1)
#
#Assign mesh control
p_assign_mesh = mdb.models['Model-1'].parts['Composite']
c_assmesh = p_assign_mesh.cells
pickedRegions = c_assmesh.getSequenceFromMask(mask=('[#1fff ]', ), )
p_assign_mesh.setMeshControls(regions=pickedRegions, elemShape=TET, technique=FREE)
elemType1 = mesh.ElemType(elemCode=C3D20R)
elemType2 = mesh.ElemType(elemCode=C3D15)
elemType3 = mesh.ElemType(elemCode=C3D10)
p_assign_mesh = mdb.models['Model-1'].parts['Composite']
c_assmesh = p_assign_mesh.cells
cells = c_assmesh.getSequenceFromMask(mask=('[#1fff ]', ), )
pickedRegions =(cells, )
p_assign_mesh.setElementType(regions=pickedRegions, elemTypes=(elemType1, elemType2, 
    elemType3))
#
#Mesh Part
pmesh = mdb.models['Model-1'].parts['Composite']
pmesh.generateMesh()
#
#
#MODULE JOB 
#
#
mdb.Job(name='Job-1', model='Model-1', description='', type=ANALYSIS, 
    atTime=None, waitMinutes=0, waitHours=0, queue=None, memory=90, 
    memoryUnits=PERCENTAGE, getMemoryFromAnalysis=True, 
    explicitPrecision=SINGLE, nodalOutputPrecision=SINGLE, echoPrint=OFF, 
    modelPrint=OFF, contactPrint=OFF, historyPrint=OFF, userSubroutine='', 
    scratch='', multiprocessingMode=DEFAULT, numCpus=1, numGPUs=0)
#
#Run JOb
#mdb.jobs['Job-1'].submit(consistencyChecking=OFF)
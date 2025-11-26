Visualize Ray Tracing Using Multiple Materials
View a 3-D model from a glTF™ file created using RoadRunner. RoadRunner is an interactive editor that lets you design 3-D scenes for simulating and testing automated driving systems.
Create a temporary folder to store a sample glTF file. Download the file into the folder by using the downloadGLTFFile helper function. The helper function is attached to the example as a supporting file. 
dataDir = fullfile(tempdir,"IntersectionAndBuildings");
if ~exist(dataDir,"dir")
    mkdir(dataDir)
end
downloadGLTFFile(dataDir)

Specify the name of the binary file. Then, import and view the glTF file using Site Viewer. Site Viewer displays the model using the colors and textures stored in the file.
filename = fullfile(dataDir,"test.glb");
viewer = siteviewer(SceneModel=filename,ShowEdges=false,ShowOrigin=false);


Site Viewer assigns materials to the surfaces in the scene by matching each material name stored in the file with the name of a supported material. View a subset of the materials and matched materials. By default, ray tracing analysis functions use the materials stored in the MatchedCatalogMaterial variable.
viewer.Materials(1:2,:)

Create a transmitter site above a building and a receiver site behind a cluster of buildings. Specify the positions using Cartesian coordinates in meters.
tx = txsite("cartesian",AntennaPosition=[0;0;2]);
rx = rxsite("cartesian",AntennaPosition=[0;5;2]);

Create a ray tracing propagation model for Cartesian coordinates, which MATLAB® represents by using a RayTracing object. Configure the model to find propagation paths that have up to two reflections (the default) and one diffraction.
pm = propagationModel("raytracing", ...
    CoordinateSystem="cartesian", ...
    MaxNumDiffractions=1);

Calculate the propagation paths and return the result as a cell array of comm.Ray objects. Extract the propagation paths from the cell array.
rays = raytrace(tx,rx,pm);
rays = rays{1};

Display the transmitter site, the receiver site, and the propagation paths.
show(tx)
show(rx)
plot(rays)
View information about a path by clicking it. The information box displays the interaction materials.

Copyright 2024-2025 The MathWorks, Inc.

using TagTool.Commands.Common;
using TagTool.Tags.Definitions.Common;

int arg_count = 1;

if (Args.Count > arg_count)
{
    Console.WriteLine("Error: {0:N} too many arguments passed in!", Args.Count - arg_count);
    Console.WriteLine("Error: Arguments should be: \"path\\to\\coords\\file.txt\\");
    return false;
}
else if (Args.Count < arg_count)
{
    Console.WriteLine("Error: {0:N} too few arguments passed in!", arg_count - Args.Count);
    Console.WriteLine("Error: Arguments should be: \"path\\to\\coords\\file.txt\\");
    return false;
}

if (!File.Exists(Args[0]))
{
    Console.WriteLine("Error: Given file path does not exist or is invalid!");
    return false;
}

string[] coords_list_path = Args[0].Split('.', StringSplitOptions.None);
string file_exstension = coords_list_path.LastOrDefault();

if (!file_exstension.Equals("txt"))
{
    Console.WriteLine("Error: Given file path was not a txt file!");
    return false;
}

string[] coords_list = null;
try
{
    coords_list = File.ReadAllLines(Args[0]);
}
catch (Exception error)
{
    Console.WriteLine("Error: Failed to read lines from txt file!");
    Console.WriteLine(error.Message);
    return false;
}

Int16 cur_objname_idx = 0;
Int16 cur_scen_idx = 0;
Int16 cur_bipd_idx = 0;
Int16 cur_vehi_idx = 0;
Int16 cur_bloc_idx = 0;
Int16 cur_trigvol_idx = 0;
Int16 cur_folder_idx = 0;

if (Definition.ObjectNames.Count == 0)
    Definition.ObjectNames = new List<Scenario.ObjectName>();
else
	cur_objname_idx = (Int16)Definition.ObjectNames.Count;

if (Definition.Scenery.Count == 0)
    Definition.Scenery = new List<Scenario.SceneryInstance>();
else
	cur_scen_idx = (Int16)Definition.Scenery.Count;

if (Definition.Bipeds.Count == 0)
    Definition.Bipeds = new List<Scenario.BipedInstance>();
else
	cur_bipd_idx = (Int16)Definition.Bipeds.Count;

if (Definition.Vehicles.Count == 0)
    Definition.Vehicles = new List<Scenario.VehicleInstance>();
else
	cur_vehi_idx = (Int16)Definition.Vehicles.Count;

if (Definition.Crates.Count == 0)
    Definition.Crates = new List<Scenario.CrateInstance>();
else
	cur_bloc_idx = (Int16)Definition.Crates.Count;

if (Definition.TriggerVolumes.Count == 0)
    Definition.TriggerVolumes = new List<Scenario.TriggerVolume>();
else
	cur_trigvol_idx = (Int16)Definition.TriggerVolumes.Count;

if (Definition.EditorFolders.Count == 0)
    Definition.EditorFolders = new List<Scenario.EditorFolder>();
else
	cur_folder_idx = (Int16)Definition.EditorFolders.Count;

Int32 cur_folder_set = 0;
Int16 cur_spawn_idx = 0;
Int16 cur_event_idx = 0;

string[] cur_params = {};

string cur_name = "";
float x = 0;
float y = 0;
float z = 0;
float yaw = 0;

for (int i = 0; i < coords_list.Length; i++)
{
	cur_params = coords_list[i].Split(' ', StringSplitOptions.None);
	
	if (cur_params[0] == "") // Readability
	{
		continue;
	}
	
	if (cur_params[0] == "newset")
	{
		cur_folder_set++;
		cur_spawn_idx = 0;
		cur_event_idx = 0;
		
		continue;
	}
	
	if (cur_params[0] == "newfolder")
	{
		Definition.EditorFolders.Add
		(
			new Scenario.EditorFolder
			{		
				ParentFolder = -1,
				Name = cur_params[1] switch
				{
					"spawn" => "set_" + cur_folder_set.ToString() + "_spawns",
					"event" => "set_" + cur_folder_set.ToString() + "_events",
					_ => "error"
				}
			}
		);
		
		cur_folder_idx++;
		
		continue;
	}
	
	if (cur_params[0] == "center" || cur_params[0] == "visual" || cur_params[0] == "camera" || cur_params[0] == "spawn" || cur_params[0] == "event")
	{
		try
		{
			x = float.Parse(cur_params[1]);
			y = float.Parse(cur_params[2]);
			z = float.Parse(cur_params[3]);
			yaw = float.Parse(cur_params[4]);
		}
		catch (FormatException error)
		{
			Console.WriteLine("Error: Line {0:N} had an invalid type!", i + 1);
			Console.WriteLine(error.Message);
		}
		
		cur_name = cur_params[0] switch
		{
			"center" => "set_" + cur_folder_set.ToString() + "_barrier",
			"visual" => "set_" + cur_folder_set.ToString() + "_visual",
			"camera" => "set_" + cur_folder_set.ToString() + "_camera",
			"spawn" => "set_" + cur_folder_set.ToString() + "_spawn_" + cur_spawn_idx.ToString(),
			"event" => "set_" + cur_folder_set.ToString() + "_event_" + cur_event_idx.ToString(),
		};

		Definition.ObjectNames.Add
		(
			new Scenario.ObjectName
			{
				Name = cur_name,
				ObjectType = cur_params[0] switch
				{
					"center" => new GameObjectType16() { Halo3ODST = GameObjectTypeHalo3ODST.Biped },
					"visual" => new GameObjectType16() { Halo3ODST = GameObjectTypeHalo3ODST.Biped },
					"camera" => new GameObjectType16() { Halo3ODST = GameObjectTypeHalo3ODST.Scenery },
					"spawn" => new GameObjectType16() { Halo3ODST = GameObjectTypeHalo3ODST.Vehicle },
					"event" => new GameObjectType16() { Halo3ODST = GameObjectTypeHalo3ODST.Crate }
				},
				PlacementIndex = cur_params[0] switch
				{
					"center" => cur_bipd_idx,
					"visual" => cur_bipd_idx,
					"camera" => cur_scen_idx,
					"spawn" => cur_vehi_idx,
					"event" => cur_bloc_idx
				}
			}
		);
		
		if (cur_params[0] == "camera")
		{
			Definition.Scenery.Add
			(
				new Scenario.SceneryInstance
				{
					PaletteIndex = (Int16)(Definition.SceneryPalette.Count),
					NameIndex = cur_objname_idx,
					PlacementFlags = new Scenario.ObjectPlacementFlags { Flags = Scenario.ObjectPlacementFlags.ObjectLocationPlacementFlags.NotAutomatically },
					Position = new RealPoint3d(x, y, z),
					Rotation = new RealEulerAngles3d(Angle.FromDegrees(yaw), Angle.FromDegrees(0), Angle.FromDegrees(0)),
					ObjectId = new ObjectIdentifier
					{
						UniqueId = new DatumHandle(0, 0),
						OriginBspIndex = -1,
						Type = new GameObjectType8() { Halo3ODST = GameObjectTypeHalo3ODST.Scenery },
						Source = ObjectIdentifier.SourceValue.Editor
					},
					EditingBoundToBsp = -1,
					EditorFolder = cur_folder_idx,
					ParentId = new ScenarioObjectParentStruct { NameIndex = -1 },
					CanAttachToBspFlags = 65535,
					HavokMoppIndex = -1,
					AiSpawningSquad = -1,
					Multiplayer = new Scenario.MultiplayerObjectProperties
					{
						Team = MultiplayerTeamDesignator.Neutral,
						MapVariantParent = new ScenarioObjectParentStruct { NameIndex = -1 }
					}
				}
			);
			
			cur_scen_idx++;
		}
		
		if (cur_params[0] == "center" || cur_params[0] == "visual")
		{
			Definition.Bipeds.Add
			(
				new Scenario.BipedInstance
				{
					PaletteIndex = cur_params[0] switch
					{
						"center" => (Int16)(Definition.BipedPalette.Count),
						"visual" => (Int16)(Definition.BipedPalette.Count + 1),
					},
					NameIndex = cur_objname_idx,
					PlacementFlags = new Scenario.ObjectPlacementFlags { Flags = Scenario.ObjectPlacementFlags.ObjectLocationPlacementFlags.NotAutomatically },
					Position = new RealPoint3d(x, y, z),
					Rotation = new RealEulerAngles3d(Angle.FromDegrees(yaw), Angle.FromDegrees(0), Angle.FromDegrees(0)),
					ObjectId = new ObjectIdentifier
					{
						UniqueId = new DatumHandle(0, 0),
						OriginBspIndex = -1,
						Type = new GameObjectType8() { Halo3ODST = GameObjectTypeHalo3ODST.Biped },
						Source = ObjectIdentifier.SourceValue.Editor
					},
					EditingBoundToBsp = -1,
					EditorFolder = cur_params[0] switch
					{
						"visual" => -1,
						_ => cur_folder_idx
					},
					ParentId = new ScenarioObjectParentStruct { NameIndex = -1 },
					CanAttachToBspFlags = 65535	
				}
			);
			
			cur_bipd_idx++;
		}
		
		if (cur_params[0] == "spawn")
		{
			Definition.Vehicles.Add
			(
				new Scenario.VehicleInstance
				{
					PaletteIndex = (Int16)(Definition.VehiclePalette.Count),
					NameIndex = cur_objname_idx,
					PlacementFlags = new Scenario.ObjectPlacementFlags { Flags = Scenario.ObjectPlacementFlags.ObjectLocationPlacementFlags.NotAutomatically | Scenario.ObjectPlacementFlags.ObjectLocationPlacementFlags.CreateAtRest },
					Position = new RealPoint3d(x, y, z + 100), // Experiment with height offset
					Rotation = new RealEulerAngles3d(Angle.FromDegrees(yaw), Angle.FromDegrees(0), Angle.FromDegrees(0)),
					ObjectId = new ObjectIdentifier
					{
						UniqueId = new DatumHandle(0, 0),
						OriginBspIndex = -1,
						Type = new GameObjectType8() { Halo3ODST = GameObjectTypeHalo3ODST.Vehicle },
						Source = ObjectIdentifier.SourceValue.Editor
					},
					EditingBoundToBsp = -1,
					EditorFolder = cur_folder_idx,
					ParentId = new ScenarioObjectParentStruct { NameIndex = -1 },
					CanAttachToBspFlags = 65535,
					Multiplayer = new Scenario.MultiplayerObjectProperties
					{
						Team = MultiplayerTeamDesignator.Neutral,
						MapVariantParent = new ScenarioObjectParentStruct { NameIndex = -1 }
					}
				}
			);
			
			cur_vehi_idx++;
		}
		
		if (cur_params[0] == "event")
		{
			Definition.Crates.Add
			(
				new Scenario.CrateInstance
				{
					PaletteIndex = (Int16)(Definition.CratePalette.Count),
					NameIndex = cur_objname_idx,
					PlacementFlags = new Scenario.ObjectPlacementFlags { Flags = Scenario.ObjectPlacementFlags.ObjectLocationPlacementFlags.NotAutomatically },
					Position = new RealPoint3d(x, y, z + 100),
					Rotation = new RealEulerAngles3d(Angle.FromDegrees(yaw), Angle.FromDegrees(0), Angle.FromDegrees(0)),
					ObjectId = new ObjectIdentifier
					{
						UniqueId = new DatumHandle(0, 0),
						OriginBspIndex = -1,
						Type = new GameObjectType8() { Halo3ODST = GameObjectTypeHalo3ODST.Crate },
						Source = ObjectIdentifier.SourceValue.Editor
					},
					EditingBoundToBsp = -1,
					EditorFolder = cur_folder_idx,
					ParentId = new ScenarioObjectParentStruct { NameIndex = -1 },
					CanAttachToBspFlags = 65535,
					Multiplayer = new Scenario.MultiplayerObjectProperties
					{
						Team = MultiplayerTeamDesignator.Neutral,
						MapVariantParent = new ScenarioObjectParentStruct { NameIndex = -1 }
					}
				}
			);
			
			cur_bloc_idx++;
		}
		
		if (cur_params[0] == "center")
		{
			GenerateCylinderVolume(radius: 100, numVertices: 16, baseZ: 0, height: 200, zSink: 200, offsetX: 0, offsetY: 0);
			cur_trigvol_idx++;
		}
		
		if (cur_params[0] == "spawn")
			cur_spawn_idx++;
		if (cur_params[0] == "event")
			cur_event_idx++;
			
		cur_objname_idx++;
	}
	
}

void GenerateCylinderVolume(float radius, int numVertices, float baseZ, float height, float zSink, float offsetX, float offsetY)
{
	if (numVertices < 3) throw new ArgumentException("Need at least 3 vertices for polygon.");

    // Generate circle points centered at (offsetX, offsetY)
    var points = new List<(float X, float Y)>();
    for (int i = 0; i < numVertices; i++)
    {
        double angle = 2 * Math.PI * i / numVertices;
        float x = (float)(offsetX + radius * Math.Cos(angle));
        float y = (float)(offsetY + radius * Math.Sin(angle));
        points.Add((x, y));
    }

    // Compute overall AABB for sector bounds
    float minX = float.MaxValue, maxX = float.MinValue;
    float minY = float.MaxValue, maxY = float.MinValue;
    foreach (var p in points)
    {
        minX = Math.Min(minX, p.X);
        maxX = Math.Max(maxX, p.X);
        minY = Math.Min(minY, p.Y);
        maxY = Math.Max(maxY, p.Y);
    }

    // Planes: horizontal (I=0, J=0, K=1)
    float plane_I = 0, plane_J = 0, plane_K = 1;
    float d0 = baseZ - zSink;  // Bottom
    float d1 = baseZ + height; // Upper

    // Z bounds (same for all tris/sector since flat, no tilt)
    float zLower = d0;  // Assuming Plane0 bottom if d0 < d1
    float zUpper = d1;

	Definition.TriggerVolumes.Add
	(
		new Scenario.TriggerVolume
		{
			Name = Cache.StringTable.GetOrAddString(cur_name),
			ObjectName = cur_objname_idx,
			NodeName = Cache.StringTable.GetOrAddString("root"),
			Type = Scenario.TriggerVolumeType.Sector,
			Forward = new RealVector3d(1, 0, 0),
			Up = new RealVector3d(0, 0, 1),
			Extents = new RealPoint3d(1, 1, height),
			Position = new RealPoint3d(offsetX, offsetY, baseZ),
			ZSink = zSink,
			SectorPoints = new List<Scenario.TriggerVolume.SectorPoint>(),
			RuntimeTriangles = new List<Scenario.TriggerVolume.RuntimeTriangle>(),
			RuntimeSectorXBounds = new Bounds<float>(minX, maxX),
			RuntimeSectorYBounds = new Bounds<float>(minY, maxY),
			RuntimeSectorZBounds = new Bounds<float>(zLower, zUpper),
			C = (float)(Math.Sqrt( Math.Pow(radius, 2) + Math.Pow(height > zSink ? height : zSink, 2) )), // A sphere that encapsulates the cylinder (from the volume origin that is)
			KillVolume = -1,
			EditorFolderIndex = -1
		}
	);
	
	for (int i = 0; i < points.Count; i++)
    {
        var p = points[i];
		
		Definition.TriggerVolumes[cur_trigvol_idx].SectorPoints.Add
		(
			new Scenario.TriggerVolume.SectorPoint
			{
				Position = new RealPoint3d(p.X, p.Y, baseZ),
				Normal = new RealEulerAngles2d(Angle.FromDegrees(0), Angle.FromDegrees(90))
			}
		);
    }
	
    for (int i = 1; i < numVertices - 1; i++)
    {
		var v0 = points[0];
        var v1 = points[i];
        var v2 = points[i + 1];
		
		float triMinX = Math.Min(v0.X, Math.Min(v1.X, v2.X));
        float triMaxX = Math.Max(v0.X, Math.Max(v1.X, v2.X));
        float triMinY = Math.Min(v0.Y, Math.Min(v1.Y, v2.Y));
        float triMaxY = Math.Max(v0.Y, Math.Max(v1.Y, v2.Y));
		
		Definition.TriggerVolumes[cur_trigvol_idx].RuntimeTriangles.Add
		(
			new Scenario.TriggerVolume.RuntimeTriangle
			{
				Plane0 = new RealPlane3d(plane_I, plane_J, plane_K, d0),
				Plane1 = new RealPlane3d(plane_I, plane_J, plane_K, d1),
				Vertex0 = new RealPoint2d(v0.X, v0.Y),
				Vertex1 = new RealPoint2d(v1.X, v1.Y),
				Vertex2 = new RealPoint2d(v2.X, v2.Y),
				BoundsX0 = triMinX,
				BoundsX1 = triMaxX,
				BoundsY0 = triMinY,
				BoundsY1 = triMaxY,
				BoundsZ0 = zLower,
				BoundsZ1 = zUpper
			}
		);
    }
	
}

return true;
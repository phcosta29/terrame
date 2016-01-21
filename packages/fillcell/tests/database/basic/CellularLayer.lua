return {
	CellularLayer = function(unitTest)
		local projName = "cellular_layer_basic.tview"

		if isFile(projName) then
			os.execute("rm -f "..projName)
		end
		
		-- ###################### 1 #############################
		local author = "Avancini"
		local title = "Cellular Layer"
	
		local proj = Project {
			file = projName,
			create = true,
			author = "Avancini",
			title = "Cellular Layer"
		}		

		local layerName1 = "Sampa"
		proj:addLayer {
			layer = layerName1,
			file = file("sampa.shp", "fillcell")
		}	
		
		local clName1 = "Sampa_Cells_DB"
		local tName1 = "sampa_cells"
		
		local host = "localhost"
		local port = "5432"
		local user = "postgres"
		local password = "postgres"
		local database = "postgis_22_sample"
		local encoding = "CP1252"
		local tableName = tName1	
		
		local pgData = {
			type = "POSTGIS",
			host = host,
			port = port,
			user = user,
			password = password,
			database = database,
			table = tName1,
			encoding = encoding
		}
		
		local tl = TerraLib{}
		tl:dropPgTable(pgData)
		
		proj:addCellularLayer {
			source = "postgis",
			input = layerName1,
			layer = clName1,
			resolution = 0.3,
			user = user,
			password = password,
			database = database,
			table = tName1
		}	
		
		local cl = CellularLayer{
			project = proj,
			layer = clName1
		}		
		
		unitTest:assertEquals(projName, cl.project.file)
		unitTest:assertEquals(clName1, cl.layer)
		
		-- ###################### 2 #############################
		proj = nil
		tl = TerraLib{}
		tl:finalize()
		
		local cl2 = CellularLayer{
			project = projName,
			layer = clName1
		}
		
		local clProj = cl2.project
		local clProjInfo = clProj:info()
		
		unitTest:assertEquals(clProjInfo.title, title)
		unitTest:assertEquals(clProjInfo.author, author)
		
		local clLayerInfo = clProj:infoLayer(clName1)
		unitTest:assertEquals(clLayerInfo.source, "postgis")
		unitTest:assertEquals(clLayerInfo.host, host)
		unitTest:assertEquals(clLayerInfo.port, port)
		unitTest:assertEquals(clLayerInfo.user, user)
		unitTest:assertEquals(clLayerInfo.password, password)
		unitTest:assertEquals(clLayerInfo.database, database)
		unitTest:assertEquals(clLayerInfo.table, tName1)
		
		-- ###################### END #############################
		if isFile(projName) then
			os.execute("rm -f "..projName)
		end
		
		tl:dropPgTable(pgData)
		
		tl = TerraLib{}
		tl:finalize()		
	end,
	fillCells = function(unitTest)
		unitTest:assert(true)
	end
}
-------------------------------------------------------------------------------------------
-- TerraME - a software platform for multiple scale spatially-explicit dynamic modeling.
-- Copyright (C) 2001-2016 INPE and TerraLAB/UFOP -- www.terrame.org

-- This code is part of the TerraME framework.
-- This framework is free software; you can redistribute it and/or
-- modify it under the terms of the GNU Lesser General Public
-- License as published by the Free Software Foundation; either
-- version 2.1 of the License, or (at your option) any later version.

-- You should have received a copy of the GNU Lesser General Public
-- License along with this library.

-- The authors reassure the license terms regarding the warranties.
-- They specifically disclaim any warranties, including, but not limited to,
-- the implied warranties of merchantability and fitness for a particular purpose.
-- The framework provided hereunder is on an "as is" basis, and the authors have no
-- obligation to provide maintenance, support, updates, enhancements, or modifications.
-- In no event shall INPE and TerraLAB / UFOP be held liable to any party for direct,
-- indirect, special, incidental, or consequential damages arising out of the use
-- of this software and its documentation.
--
-------------------------------------------------------------------------------------------

return {
	Project = function(unitTest)
		local proj1 = Project{
			file = "amazonia",
			clean = true,
			author = "Avancini",
			title = "The Amazonia"
		}
		
		unitTest:assertType(proj1, "Project")
		unitTest:assertEquals(proj1.file, "amazonia.tview")
		
		local proj2 = Project{
			file = "amazonia"
		}		

		unitTest:assertEquals(proj1.author, proj2.author)
		unitTest:assertEquals(proj1.title, proj2.title)
		unitTest:assertEquals(proj1.file, proj2.file)

		local proj3 = Project{
			file = "amazonia.tview"
		}

		unitTest:assertEquals(proj1.author, proj3.author)
		unitTest:assertEquals(proj1.title, proj3.title)
		unitTest:assertEquals(proj1.file, proj3.file)

		unitTest:assertFile("amazonia.tview")

		local proj4Name = "notitlenoauthor.tview"
		
		local proj4 = Project{
			file = proj4Name
		}

		unitTest:assertEquals(proj4.title, "<no title>")
		unitTest:assertEquals(proj4.author, "<no author>")
		unitTest:assertEquals(proj4.clean, false)

		unitTest:assertFile(proj4Name)
	end,
	__tostring = function(unitTest)
		local proj1 = Project{
			file = "tostring",
			clean = true,
			author = "Avancini",
			title = "The Amazonia"
		}
		
		unitTest:assertEquals(tostring(proj1), [[author    string [Avancini]
clean     boolean [true]
file      string [tostring.tview]
layers    table of size 0
terralib  TerraLib
title     string [The Amazonia]
]])

		unitTest:assertFile("tostring.tview")
	end
}

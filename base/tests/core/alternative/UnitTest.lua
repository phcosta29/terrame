-------------------------------------------------------------------------------------------
-- TerraME - a software platform for multiple scale spatially-explicit dynamic modeling.
-- Copyright (C) 2001-2014 INPE and TerraLAB/UFOP.
--
-- This code is part of the TerraME framework.
-- This framework is free software; you can redistribute it and/or
-- modify it under the terms of the GNU Lesser General Public
-- License as published by the Free Software Foundation; either
-- version 2.1 of the License, or (at your option) any later version.
--
-- You should have received a copy of the GNU Lesser General Public
-- License along with this library.
--
-- The authors reassure the license terms regarding the warranties.
-- They specifically disclaim any warranties, including, but not limited to,
-- the implied warranties of merchantability and fitness for a particular purpose.
-- The framework provided hereunder is on an "as is" basis, and the authors have no
-- obligation to provide maintenance, support, updates, enhancements, or modifications.
-- In no event shall INPE and TerraLAB / UFOP be held liable to any party for direct,
-- indirect, special, incidental, or caonsequential damages arising out of the use
-- of this library and its documentation.
--
-- Authors: Pedro R. Andrade
--          Rodrigo Reis Pereira
-------------------------------------------------------------------------------------------

return{
	assert = function(unitTest)
		local u = UnitTest{}

		local error_func = function()
			u:assert(2)
		end

		unitTest:assert_error(error_func, incompatibleTypeMsg(1, "boolean", 2))
	end,
	assert_equal = function(unitTest)
		local u = UnitTest{}

		local error_func = function()
			u:assert_equal(2, 2, "a")
		end

		unitTest:assert_error(error_func, incompatibleTypeMsg(3, "number", "a"))

		local error_func = function()
			u:assert_equal("abc", "abc", 2)
		end

		unitTest:assert_error(error_func, "#3 should be used only when comparing numbers (#1 is string).")
	end,
	assert_error = function(unitTest)
		local u = UnitTest{}

		local error_func = function()
			u:assert_error(2)
		end

		unitTest:assert_error(error_func, incompatibleTypeMsg(1, "function", 2))

		local error_func = function()
			u:assert_error(function() end, 2)
		end

		unitTest:assert_error(error_func, incompatibleTypeMsg(2, "string", 2))

		local error_func = function()
			u:assert_error(function() end, "aaa", false)
		end

		unitTest:assert_error(error_func, incompatibleTypeMsg(3, "number or nil", false))
	end,
	assert_type = function(unitTest)
		local u = UnitTest{}

		local error_func = function()
			u:assert_type(2, 2)
		end

		unitTest:assert_error(error_func, incompatibleTypeMsg(2, "string", 2))
	end
}

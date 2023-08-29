local easyFunctions = {}

function easyFunctions.uiCollides(gui1, gui2)
    local gui1_topLeft = gui1.AbsolutePosition
	    local gui1_bottomRight = gui1_topLeft + gui1.AbsoluteSize
 
	    local gui2_topLeft = gui2.AbsolutePosition
    local gui2_bottomRight = gui2_topLeft + gui2.AbsoluteSize
	 
	    return ((gui1_topLeft.x < gui2_bottomRight.x and gui1_bottomRight.x > gui2_topLeft.x) and (gui1_topLeft.y < gui2_bottomRight.y and gui1_bottomRight.y > gui2_topLeft.y))
end

function easyFunctions.PointTo(Frame : UIBase, Target : UIBase)
	local Origin: Vector2 = Frame.AbsolutePosition
	local LookAt: Vector2 = Target.AbsolutePosition
	
	local Angle: number = math.atan2(
		Origin.Y - LookAt.Y,
		Origin.X - LookAt.X
	)
	
	Frame.Rotation = math.deg(Angle) + 270
end

return easyFunctions
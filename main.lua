--[[  2circlingBalls-lua - Corona physics example of body:applyForce()
--
-- Copyright (c) Frank Siebenlist. All rights reserved.
-- The use and distribution terms for this software are covered by the
-- Eclipse Public License 1.0 (http://opensource.org/licenses/eclipse-1.0.php).
-- By using this software in any fashion, you are agreeing to be bound by
-- the terms of this license.
-- You must not remove this notice, or any other, from this software.
-- Corona Game SDK example of how to let two bodies circle each other by applying a continuous, attracting force

The example uses the physics engine, sets gravity to 0, creates two balls separated in the x-direction,
with initial speeds in opposite y-direction.
Thru an enterFrame event handler, an attracting force is continuously applied to both balls with body:applyForce().
The force is normalized over the distance between the two balls
By playing with the initial speed and force factors, you can make the balls spin faster/slower in circles or ellipses
Save this file as "main.lua" in a project directory and load it in the simulator

Enjoy, Frank  (September 23, 2010).
-----------------------------------------------------------------------------]]


local physics = require("physics")
physics.start()
physics.setScale( 60 )
physics.setGravity( 0, 0 )

local initialSpeed = 300
local forceFactor = 10
 
local b1 = display.newCircle( 75, 250, 25)
b1:setFillColor(255, 0, 0); 
physics.addBody( b1, { density=1, friction=0, bounce=.9, radius=25 } )
b1:setLinearVelocity( 0, initialSpeed )

local b2 = display.newCircle( 250, 250, 25)
b2:setFillColor(0, 0, 255)
physics.addBody( b2, { density=1, friction=0, bounce=.9, radius=25 } )
b2:setLinearVelocity( 0, -initialSpeed )
 
function ballForce(event) 
	vx = b2.x-b1.x; vy = b2.y-b1.y
	d12 = math.sqrt(vx^2 + vy^2)
	f1x = forceFactor*vx/d12; f1y = forceFactor*vy/d12
	b1:applyForce( f1x, f1y, b1.x, b1.y )
	b2:applyForce( -f1x, -f1y, b2.x, b2.y )
end

Runtime:addEventListener("enterFrame", ballForce)

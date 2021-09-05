pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
-- ▒▒ breakout game ▒▒ --
-- by ahmza

-- base functions
function _init()
	cls()

	--variables

 -- ball settings
 bx=8
 by=60
 bdx=2
 bdy=2
 br=2
 bc=8

 -- platform settings
 px=52
 py=115
 pdx=0
 pw=24
 ph=3
 pc=7

end

function _update()
 
 -- check for user input
	-- move platform
	local butpress=false
	if btn(0) then
	 --left
		pdx=-5
		butpress=true
	end
	if btn(1) then
	 --right
		pdx=5
		butpress=true
	end
	
	-- deceleration of the platform
	if not(butpress) then
		pdx=pdx/1.7
	end
		
	-- translate platform movement
	px+=pdx

 -- translate ball movement
	bx+=bdx
	by+=bdy

 -- ball wall / barrier colission 	
	if bx>120 or bx<8 then
	 bdx=-bdx
	 sfx(0)
	end
	if by>120 or by<8 then
		bdy=-bdy
		sfx(0)
	end
	
	-- ball platform colission
	pc=7
	if ball_box(px,py,pw,ph) then
		pc=8
		sfx(1)
		bdy=-bdy
	end
	
end

function _draw()
 -- background
	cls(1)
 -- ball
	circfill(bx,by,br,bc)
 -- platform
	rectfill(px,py,px+pw,py+ph,pc)
end

function ball_box(ix,iy,iw,ih)
	
	-- checks for collision on ball using sqare
	if by-br > iy+ih or by+br < iy then
		return false
	end
	
	if bx-br > ix+iw or bx+br < ix then
		return false
	end
	
	return true 

end
-->8
-- collision detection demo --
function _init()
	cls()
	box_x = 32
	box_y = 58
	box_w = 64
	box_h = 12

	rayx = 0
	rayy = 0
	raydx = 2
	raydy = -2

 debug1 = "debug"
end

function _update()
 if btn(1) then
  rayx+=1
 end
 if btn(0) then
  rayx-=1
 end
 if btn(2) then
  rayy-=1
 end
 if btn(3) then
  rayy+=1
 end 
end

function _draw()
 cls()
 rect(box_x, box_y, box_x+box_w, box_y+box_h, 7)
 local px, py = rayx, rayy
 repeat
  pset(px, py, 8)
  px+=raydx
  py+=raydy
 until px<0 or px>128 or py < 0 or py > 128
 
 if deflx_ballbox(rayx,rayy,raydx,raydy,box_x,box_y,box_w,box_h) then
  print("horizontal")
 else
  print("vertical")
 end
 print(debug1)
end

function deflx_ballbox(bx,by,bdx,bdy,tx,ty,tw,th)
 -- calculate wether to deflect the ball
 -- horizontally or vertically when it hits a box
 if bdx == 0 then
  -- moving vertically
  return false
 elseif bdy == 0 then
  -- moving horizontally
  return true
 else
  -- moving diagonally
  -- calculate slope
  local slp = bdy / bdx
  local cx, cy
  -- check variants
  if slp > 0 and bdx > 0 then
   -- moving down right
   debug1="q1"
   cx = tx-bx
   cy = ty-by
   if cx<=0 then
    return false
   elseif cy/cx < slp then
    return true
   else
    return false
   end
  elseif slp < 0 and bdx > 0 then
   debug1="q2"
   -- moving up right
   cx = tx-bx
   cy = ty+th-by
   if cx<=0 then
    return false
   elseif cy/cx < slp then
    return false
   else
    return true
   end
  elseif slp > 0 and bdx < 0 then
   debug1="q3"
   -- moving left up
   cx = tx+tw-bx
   cy = ty+th-by
   if cx>=0 then
    return false
   elseif cy/cx > slp then
    return false
   else
    return true
   end
  else
   -- moving left down
   debug1="q4"
   cx = tx+tw-bx
   cy = ty-by
   if cx>=0 then
    return false
   elseif cy/cx < slp then
    return false
   else
    return true
   end
  end
 end
 return false
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100001524415254152541524415230152201521000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000100004000040000400004
00010000115600f5500d5300b5200d5300f5501156000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

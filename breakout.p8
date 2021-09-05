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
 bdx=1
 bdy=1
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

function _update60()
 local nextx, nexty
 
 -- check for user input
	-- move platform
	local butpress=false
	if btn(0) then
	 --left
		pdx=-2.5
		butpress=true
	end
	if btn(1) then
	 --right
		pdx=2.5
		butpress=true
	end
	
	-- deceleration of the platform
	if not(butpress) then
		pdx=pdx/2.3
	end
		
	-- translate platform movement
	px+=pdx

	-- translate ball movement
	nbx=bx+bdx
	nby=by+bdy

 -- ball wall / barrier colission 	
	if nbx>120 or nbx<8 then
	 nbx=mid(0,nbx,120)
	 bdx=-bdx
	 sfx(0)
	end
	if nby>120 or nby<8 then
		nby=mid(0,nby,120)
		bdy=-bdy
		sfx(0)
	end
	
	-- ball platform colission
	if ball_box(nbx,nby,px,py,pw,ph) then
		-- find direction of ball
		if deflx_bp(bx,by,bdx,bdy,px,py,pw,ph) then
			bdx=-bdx
		else
			bdy=-bdy
		end
		sfx(1)
	end
	
	-- translate ball movement
	bx=nbx
	by=nby
end

function _draw()
 -- background
	cls(1)
 -- ball
	circfill(bx,by,br,bc)
 -- platform
	rectfill(px,py,px+pw,py+ph,pc)
end

function ball_box(nbx,nby,ix,iy,iw,ih)
	
	-- checks for collision on ball using sqare
	if nby-br > iy+ih or nby+br < iy then return false end
	if nbx-br > ix+iw or nbx+br < ix then return false end
	
	return true
	
end

function deflx_bp(boxx,boxy,boxdx,boxdy,tx,ty,tw,th)
 -- calculate wether to deflect the ball
 -- horizontally or vertically when it hits a box
 if boxdx == 0 then
  -- moving vertically
  return false
 elseif boxdy == 0 then
  -- moving horizontally
  return true
 else
  -- moving diagonally
  -- calculate slope
  local slp = boxdy / boxdx
  local cx, cy
  -- check variants
  if slp > 0 and boxdx > 0 then
   -- moving down right
   debug1="q1"
   cx = tx-boxx
   cy = ty-boxy
   if cx<=0 then
    return false
   elseif cy/cx < slp then
    return true
   else
    return false
   end
  elseif slp < 0 and boxdx > 0 then
   debug1="q2"
   -- moving up right
   cx = tx-boxx
   cy = ty+th-boxy
   if cx<=0 then
    return false
   elseif cy/cx < slp then
    return false
   else
    return true
   end
  elseif slp > 0 and boxdx < 0 then
   debug1="q3"
   -- moving left up
   cx = tx+tw-boxx
   cy = ty+th-boxy
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
   cx = tx+tw-boxx
   cy = ty-boxy
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
010100001821018210182101821018210182100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000010000400004000040000400000
010100002422024220242202422024220242200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

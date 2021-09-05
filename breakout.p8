pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
-- ▒▒ breakout game ▒▒ --
-- by ahmza

-- base functions
function _init()
	cls()

	--variables

	-- draw vaiables
	mode="start"

end

function _update60()
	if mode=="game" then
		update_game()
	elseif mode=="start" then
		update_start()
	elseif mode=="gameover" then
		update_gameover()
	end
end

function update_start()
	if btn(5) then
		startgame()
	end
end

function startgame()
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
	
	mode="game"
	
	lives=3
	points=0
	
	serveball()
end

function serveball()
	bx=8
 by=60
 bdx=1
 bdy=1
end

function gameover()
	mode="gameover"
end

function update_gameover()
	if btn(5) then
		startgame()
	end
end

function update_game()
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
	if nbx>125 or nbx<3 then
	 nbx=mid(0,nbx,120)
	 bdx=-bdx
	 sfx(0)
	end
	if nby<10 then
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
		points+=1
	end
	
	-- translate ball movement
	bx=nbx
	by=nby
	
	if nby > 127 then
		sfx(2)
		lives-=1
		if lives<0 then
			gameover()
		else
			serveball()
		end
	end
end

function _draw()
	if mode=="game" then
		draw_game()
	elseif mode=="start" then
		draw_start()
	elseif mode=="gameover" then
		draw_gameover()
	end
end

function draw_start()
	cls(1)
	rectfill(0,50,128,75,0)
	print("▒ breakout ▒",37,55,7)
	print("press ❎ to start",32,67,8)
end

function draw_game()
 -- background
	cls(1)
	-- stat bar
	rectfill(0,0,128,6,8)
	-- lives
	print("lives:"..lives,1,1,7)
	print("score:"..points,35,1,7)
 -- ball
	circfill(bx,by,br,bc)
 -- platform
	rectfill(px,py,px+pw,py+ph,pc)
end

function draw_gameover()
	--cls(1)
	rectfill(0,50,128,75,0)
	print("gameover",50,55,7)
	print("press ❎ to restart",30,67,8)
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
000900002632027320233201c320153201732018320143200f3200f30000300082000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

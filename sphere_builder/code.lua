-- Default configured to build a sun.
-- digibuilder channel = digibuilder

if event.type == 'program' then
  mem.angle = {y = 0, p = 0}
  mem.pos = {x = 0, y = 0, z = 0}
  mem.inc = math.pi/48
  mem.cosp = 1
  mem.rad = 14
  mem.nodes = {"mesecons_lightstone:lightstone_white_off","mesecons_lightstone:lightstone_yellow_off"}
  mem.tau = math.pi*2
  interrupt(1)
end

if event.type == 'interrupt' then

  n = mem.nodes[math.floor(math.random(#mem.nodes)) + 1]

  mem.pos.x = math.floor((math.cos(mem.angle.y)*mem.rad)*mem.cosp+1.5)
  mem.pos.z = math.floor((math.sin(mem.angle.y)*mem.rad)*mem.cosp+0.5)

  mem.angle.y = mem.angle.y + mem.inc/mem.cosp

  if mem.angle.y > mem.tau + mem.inc/8 then
    mem.angle.y = 0
    mem.angle.p = mem.angle.p - mem.inc
    mem.cosp = math.cos(mem.angle.p)
    mem.pos.y = math.floor((math.sin(mem.angle.p)*14)+0.5)
  end

  digiline_send("digibuilder", {
    command = "setnode",
    pos = mem.pos,
    param2 = 0,
    name = n
  })

  interrupt(1)
end

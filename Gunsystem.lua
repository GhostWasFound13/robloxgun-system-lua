d assistant to help you with your writing tasks
Online


Now

Write a roblox lua code ots gun system with equid gun and recoil and aim and aim hit and reload gui, reload and ammo count gui and shoot and zoom and bullet system and when shooting smoke     3:18 PM


-- Gun System --
local gunType = "Equid" -- Type of Gun (Equid, Pistol, Assault Rifle, etc.)
local recoilAmount = 0.5 -- Amount of recoil (Higher Number = More Recoil)
local aimSpeed = 5 -- Aim Speed (Higher Number = Faster Aiming)
local aimHit = 0.2 -- Chance of hitting the target when aiming (Higher Number = More Accurate)
local GuiReload = Instance.new("ScreenGui") -- Reload Gui
local GuiAmmoCount = Instance.new("ScreenGui") -- Ammo Count Gui
local shootCooldown = 1.5 -- How long it takes to shoot again
local zoomAmount = 0.5 -- Amount of Zoom (Higher Number = More Zoom)
local bulletSpeed = 15 -- Speed of Bullets

-- Shooting --
local function onFire(player)
local char = player.Character
local gun = char.Gun
local root = gun.Parent
local mouse = player:GetMouse()
local shootSmoke = Instance.new("Smoke", gun) -- Create Shooting Smoke

-- Recoil --
local recoilPos = Vector3.new(mouse.Hit.X,mouse.Hit.Y,mouse.Hit.Z)
local direction = (recoilPos - root.Position).unit
local force = direction * recoilAmount
gun.CFrame = CFrame.new(gun.Position, recoilPos) + force
wait(0.2)
gun.CFrame = CFrame.new(gun.Position, recoilPos)

-- Aim --
local hit, pos = workspace:FindPartOnRayWithIgnoreList(mouse.UnitRay, {player.Character, gun})
if hit and math.random() < aimHit then
local direction = (pos - root.Position).unit
local force = direction * aimSpeed
gun.CFrame = CFrame.new(gun.Position, pos) + force
wait(0.2)
gun.CFrame = CFrame.new(gun.Position, pos)
end

-- Reload --
GuiReload.TextLabel.Text = "Reloading..."
wait(shootCooldown)
GuiReload.TextLabel.Text = "Ready to Shoot"

-- Ammo Count --
GuiAmmoCount.TextLabel.Text = "Ammo Count: " .. gun.Ammo.Value

-- Shoot --
local bullet = Instance.new("Part")
bullet.Size = Vector3.new(0.2, 0.2, 0.2)
bullet.Shape = "Cylinder"
bullet.CanCollide = false
bullet.Anchored = true
bullet.BrickColor = BrickColor.new("Really black")
bullet.Parent = workspace
bullet.CFrame = CFrame.new(gun.Position, pos) + force
bullet.Velocity = (pos - root.Position).unit * bulletSpeed
wait(3)
bullet:Destroy()
end

-- Zoom --
local function onZoom(player)
local char = player.Character
local gun = char.Gun
local root = gun.Parent
player.CameraMaxZoomDistance = zoomAmount
end

-- Event --
local event = game:GetService("ReplicatedStorage").Event.Fire
event.OnServerEvent:Connect(onFire)
event.OnServerEvent:Connect(onZoom)

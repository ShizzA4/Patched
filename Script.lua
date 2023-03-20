local lib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt")()
local win = lib:Window("Minus Decendance | 2023 ðŸ”¥",Color3.fromRGB(44, 120, 224), Enum.KeyCode.RightControl)

function mapEnable()
	game:GetService("RunService").Heartbeat:Connect(function()
		game:GetService("Workspace").MapTable.MapScreen.SurfaceGui.Enabled = true
	end)
end
coroutine.wrap(mapEnable)()

game:GetService("Players").LocalPlayer.Character.Wrath:Destroy()

function clipboardAutoCollect()
    for _,clipboard in pairs(game:GetService("Workspace").Info:GetChildren()) do
        fireclickdetector(clipboard.Hitbox.ClickDetector, 1)
    end

    game:GetService("Workspace").Info.ChildAdded:Connect(function(clipboard)
        wait(15)
        fireclickdetector(clipboard.Hitbox.ClickDetector, 1)
    end)
end
coroutine.wrap(clipboardAutoCollect)()

local home = win:Tab("Home")
local esp = win:Tab("Esp")
local misc = win:Tab("Misc")

esp:Button("Esp Players", function()

local function drawPlayer(player)
    local esp = Drawing.new("Text"); esp.Visible = false; esp.Color = Color3.new(0,1,0); esp.Text = "+"--[[tostring(player.Name)]]; esp.Center = true; esp.Outline = true; esp.OutlineColor = Color3.new(0,0,0); esp.Font = 0
    local function playerEsp()
        local RenderStepped
        RenderStepped = game:GetService("RunService").RenderStepped:Connect(function()
            if player == game:GetService("Players").LocalPlayer then esp:Remove(); RenderStepped:Disconnect() return end
            if player.Character ~= nil and player.Character:FindFirstChild("HumanoidRootPart") ~= nil then
                local playerPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
                if onScreen then
                    esp.Position = Vector2.new(playerPos.X, playerPos.Y)
                    esp.Size = 1000 / playerPos.Z + 10
                    esp.Visible = true
                else
                    esp.Visible = false
                end
            else
                esp.Visible = false
            end
        end)
    end
    coroutine.wrap(playerEsp)()
end

for _,player in pairs(game:GetService("Players"):GetPlayers()) do
    drawPlayer(player)
end

game:GetService("Players").PlayerAdded:Connect(function(player)
    drawPlayer(player)
end)
end)

esp:Button("Esp Monster", function()

local function drawEntity(enemy)
    local esp = Drawing.new("Text"); esp.Visible = false; esp.Color = Color3.new(1,0,0); esp.Center = true; esp.Outline = true; esp.OutlineColor = Color3.new(0,0,0); esp.Font = 0
    local chams = Instance.new("Highlight"); chams.Parent = game:GetService("CoreGui"); chams.Enabled = true; chams.Adornee = enemy; chams.FillTransparency = 1; chams.OutlineColor = Color3.new(1,0,0); chams.OutlineTransparency = 0.45
    if enemy.Name ~= "DeathOrb" then
        esp.Text = tostring(enemy.MonsterName.Value)
    else
        esp.Text = tostring(enemy.Name)
    end
    local function monsterEsp()
        local RenderStepped
        RenderStepped = game:GetService("RunService").RenderStepped:Connect(function()
            if enemy:FindFirstChild("HumanoidRootPart") ~= nil then
                local monsterPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(enemy.HumanoidRootPart.Position)
                if onScreen then
                    esp.Position = Vector2.new(monsterPos.X, monsterPos.Y)
                    esp.Size = 1000 / monsterPos.Z + 10
                    esp.Visible = true
                else
                    esp.Visible = false
                end
            else
                esp.Visible = false
            end
        end)
        local ChildRemoved
        ChildRemoved = game:GetService("Workspace").Enemies.ChildRemoved:Connect(function(child)
            if child == enemy then
                esp:Remove()
                RenderStepped:Disconnect()
                ChildRemoved:Disconnect()
            end
        end)
    end
    coroutine.wrap(monsterEsp)()
end

for _,enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
    drawEntity(enemy)
end

game:GetService("Workspace").Enemies.ChildAdded:Connect(function(enemy)
    task.wait(1)
    drawEntity(enemy)
end)
end)

esp:Button("Show Elevator info", function()

function displayInfo()
	local powerEsp = Drawing.new("Text")
	powerEsp.Text = "Power: Loading..."
	powerEsp.Position = Vector2.new(workspace.CurrentCamera.ViewportSize.X - workspace.CurrentCamera.ViewportSize.X + 10, workspace.CurrentCamera.ViewportSize.Y - 30)
	powerEsp.Size = 25
	powerEsp.Visible = true
	powerEsp.Color = Color3.new(0.913725, 0.882352, 0.431372)
	powerEsp.Center = false
	powerEsp.Outline = true
	powerEsp.OutlineColor = Color3.new(0, 0, 0)
	powerEsp.Font = 0
	local oxygenEsp = Drawing.new("Text")
	oxygenEsp.Text = "Oxygen: Loading..."
	oxygenEsp.Position = powerEsp.Position - Vector2.new(2, 25)
	oxygenEsp.Size = 25
	oxygenEsp.Visible = true
	oxygenEsp.Color = Color3.new(0.431372, 0.882352, 0.913725)
	oxygenEsp.Center = false
	oxygenEsp.Outline = true
	oxygenEsp.OutlineColor = Color3.new(0, 0, 0)
	oxygenEsp.Font = 0
	local floorEsp = Drawing.new("Text")
	floorEsp.Text = "Floor: Loading..."
	floorEsp.Position = oxygenEsp.Position - Vector2.new(0, 25)
	floorEsp.Size = 25
	floorEsp.Visible = true
	floorEsp.Color = Color3.new(1, 1, 1)
	floorEsp.Center = false
	floorEsp.Outline = true
	floorEsp.OutlineColor = Color3.new(0, 0, 0)
	floorEsp.Font = 0
	game:GetService("RunService").Heartbeat:Connect(function()
		powerEsp.Text = "Power: " .. tostring(math.floor(game:GetService("ReplicatedStorage").Settings.CurrentPower.Value / game:GetService("ReplicatedStorage").Settings.MaxPower.Value * 100)) .. "% (" .. tostring(game:GetService("ReplicatedStorage").Settings.CurrentPower.Value) .. "/" .. tostring(game:GetService("ReplicatedStorage").Settings.MaxPower.Value) .. ")"
		oxygenEsp.Text = "Oxygen: " .. tostring(math.floor(game:GetService("ReplicatedStorage").Settings.CurrentOxygen.Value / game:GetService("ReplicatedStorage").Settings.MaxOxygen.Value * 100)) .. "% (" .. tostring(game:GetService("ReplicatedStorage").Settings.CurrentOxygen.Value) .. "/" .. tostring(game:GetService("ReplicatedStorage").Settings.MaxOxygen.Value) .. ")"
		floorEsp.Text = "Floor: " .. tostring(game:GetService("ReplicatedStorage").Settings.CurrentFloor.Value)
	end)
end
coroutine.wrap(displayInfo)()
end)

esp:Button("Esp button", function()

local function drawButton(button)
    local esp = Drawing.new("Text"); esp.Visible = false; esp.Text = "[]"; esp.Center = true; esp.Outline = true; esp.OutlineColor = Color3.new(0,0,0); esp.Font = 0
    local function buttonEsp()
        local RenderStepped
        RenderStepped = game:GetService("RunService").RenderStepped:Connect(function()
            if button.Button.Color == game:GetService("ReplicatedStorage").Settings.ButtonOffColor.Value then esp.Visible = false return end
            if button:WaitForChild("Button") ~= nil then
                local buttonPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(button.Button.Position)
                if onScreen then
                    esp.Position = Vector2.new(buttonPos.X, buttonPos.Y)
                    esp.Size = 1000 / buttonPos.Z + 10
                    esp.Visible = true
                else
                    esp.Visible = false
                end
            else
                esp.Visible = false
            end
            esp.Color = button.Button.Color
        end)
        local ChildRemoved
        ChildRemoved = game:GetService("Workspace").Tasks.ChildRemoved:Connect(function(child)
            if child == button then
                esp:Remove()
                RenderStepped:Disconnect()
                ChildRemoved:Disconnect()
            end
        end)
    end
    coroutine.wrap(buttonEsp)()
end
for _,button in pairs(game:GetService("Workspace").Tasks:GetChildren()) do
    drawButton(button)
end

game:GetService("Workspace").Tasks.ChildAdded:Connect(function(button)
    task.wait(1)
    drawButton(button)
end)
end)

esp:Button("Esp Elevator", function()

function tableEsp()
	local esp = Drawing.new("Text")
	esp.Visible = false
	esp.Color = Color3.new(1, 1, 1)
	esp.Text = "Elevator"
	esp.Center = true
	esp.Outline = true
	esp.OutlineColor = Color3.new(0, 0, 0)
	esp.Font = 0
	game:GetService("RunService").RenderStepped:Connect(function()
		local tablePos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(game:GetService("Workspace").MapTable.PrimaryPart.Position + Vector3.new(0, 15, 0))
		if onScreen then
			esp.Position = Vector2.new(tablePos.X, tablePos.Y)
			esp.Size = 1000 / tablePos.Z + 10
			esp.Visible = true
		else
			esp.Visible = false
		end
	end)
end
coroutine.wrap(tableEsp)()
end)

home:Label("Made By Shizza/Aaron")
home:Label("Game: Minus Decendance")
home:Label("Only 1 Dev Made this script")
home:Label("Discord Not Yet Released")

local player = game.Players.LocalPlayer;

--//Platform/no fall\\--
local part = Instance.new("Part", workspace);
part.Anchored = true
part.Size = Vector3.new(5, .001, 5);


game:GetService("RunService").Stepped:Connect(function()
if shared.chestFarm then
    for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
        if v:IsA("BasePart") and v.CanCollide then
                v.CanCollide = false
                game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
                part.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3.02, 0)
            end;
        end;
    end;
end);

local function magCheck(part, tmpPart) --//Getting closests part to part but scuffed
    local firstCheck = (player.Character:FindFirstChild("HumanoidRootPart").Position - part.Position).magnitude
    local tmpCheck = (tmpPart.Position - part.Position).magnitude
    if firstCheck <= math.huge then
        if tmpCheck <= math.huge then
            return true
        else
            return false
        end;
    end;
end;

function Target(target)
    local info = TweenInfo.new((target.Position - player.Character.HumanoidRootPart.Position).Magnitude / shared.speed, Enum.EasingStyle.Linear);
    local _, err = pcall(function()
        game:GetService("TweenService"):Create(player.Character.HumanoidRootPart, info, {CFrame = target}):Play();
    end);
	if err then 
		error("Tween Failed Eror Chunk: ",err) 
	end;
end;

while shared.chestFarm and task.wait(5) do pcall(function()
for i,v in pairs(game.Workspace:GetDescendants()) do
    if table.find(shared.priority, v.Name) and magCheck(v:FindFirstChild("Base"), v:FindFirstChild("Base")) and not v:FindFirstChild("Open") then
            Target(v:FindFirstChild("Base").CFrame);
        if (player.Character:FindFirstChild("HumanoidRootPart").Position - v:FindFirstChild("Base").Position).magnitude <= 10 and v.Base:FindFirstChild("Prompt") then
            fireproximityprompt(v.Base:FindFirstChild("Prompt"))
        end;
        elseif string.match(v.Name, " Chest") and magCheck(v:FindFirstChild("Base"), v:FindFirstChild("Base")) and not v:FindFirstChild("Open") then
            if not table.find(shared.priority, v.Name) and table.find(shared.priority, v.Name) then
            else
                Target(v:FindFirstChild("Base").CFrame);
                if (player.Character:FindFirstChild("HumanoidRootPart").Position - v:FindFirstChild("Base").Position).magnitude <= 10 and v.Base:FindFirstChild("Prompt") then
                    fireproximityprompt(v.Base:FindFirstChild("Prompt"))
                    end;
                end;
            end;
        end;
    end);
end;

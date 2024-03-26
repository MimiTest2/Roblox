shared.keybind = Enum.KeyCode.X;

local userInputService = game:GetService("UserInputService");
local downwardsVector = Vector3.new(0,-1000,0);
local localPlayer = game:GetService("Players").LocalPlayer;
local isKeyDown = userInputService.IsKeyDown;

game:GetService("RunService").Heartbeat:Connect(function()
    if isKeyDown(userInputService,shared.keybind) then
        local hrp = localPlayer.Character.HumanoidRootPart;
        hrp.Velocity = (hrp.CFrame.LookVector.Unit * 20) + downwardsVector;
    end
end);

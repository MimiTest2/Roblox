--easily detectable.
shared.rainSpySettings = {
    securitySetting = true; --uses newcclosure;
}

local isA = workspace.IsA; --faster for peformance + u cant call a _namecall in a namecall hook;

function createClosure(closure)
    return shared.rainSpySettings.securitySetting and newcclosure(clonefunction(closure)) or clonefunction(closure);
end;

writefile("rain-spy-log.log", "# This is your rain spy log.");

local loggableMethods = {
    RemoteEvent = "FireServer",
    UnreliableRemoteEvent = "FireServer",
    RemoteFunction = "InvokeServer"
};

function prettyify(args)
    local prettyified = "";
    for i, v in pairs(args) do
        prettyified ..= "\n";
        if typeof(v) == "table" then
            prettyified ..= typeof(v) .. ` ({table.concat(v, ",")})`;
        elseif typeof(v) == "buffer" then
            prettyified ..= typeof(v) .. ` ({buffer.toString(v)})`;
        else
            prettyified = typeof(v) .. ` ({tostring(v)})`;
        end
    end
    return "unpack({"..prettyified.."})";
end

function runHook(self, ...)
    local args = {...};
    local pretty = prettyify(args);
    local str = string.format("%s (%s) (%s) (%s)",self.Name, self.ClassName, pretty, self:GetFullName() ..":FireServer("..pretty..")");
    print(str)
    appendfile("rain-spy-log.log", "\n"..str);
end;

local old;
old = hookmetamethod(game, "__namecall", createClosure(function(self, ...)
    if not checkcaller() and typeof(self) == "Instance" and (isA(self, "RemoteEvent") or isA(self, "UnreliableRemoteEvent") or isA(self, "RemoteFunction")) then
        if getnamecallmethod() == loggableMethods[self.ClassName] then
            runHook(self,...);
        end
    end
    return old(self,...);
end))


for i, v in pairs(loggableMethods) do
    local oldMethod;
    oldMethod = hookfunction(Instance.new(i)[v], createClosure(function(self,...)
        if not checkcaller() and typeof(self) == "Instance" and (isA(self, "RemoteEvent") or isA(self, "UnreliableRemoteEvent") or isA(self, "RemoteFunction")) then
            runHook(self,...);
        end
        return oldMethod(self,...);
    end));
end

--not my aob scan method, from netflix ce.
local util = {};
util.aobScan = function(aob, code)
    local new_results = {}
    local results = AOBScan(aob, "*X*C*W")
    if not results then
        return new_results
    end
    for i = 1,results.Count do
        local x = getAddress(results[i - 1])
        table.insert(new_results, x)
    end
    return new_results
end;
--end;

local lifeSenseScan = util.aobScan("576f726c6450756c7365", "*X*C*W")
for i, v in pairs(lifeSenseScan) do
    writeString(v,"IsClimbing")
end;


local Config = require 'config.config'
local SecretKey = 'YOUR_TEBEX_SECRET_KEY'

local url = 'https://plugin.tebex.io/payments/%s'

local function HttpRequestAwait(url, method, data, headers, options)
    local p = promise.new()
    PerformHttpRequest(url, function(...)
        p:resolve({ ... })
    end, method, data, headers, options)

    Citizen.Await(p)
    return table.unpack(p.value)
end

function CheckTebex(transaction_id)
    local status, data = HttpRequestAwait((url):format(transaction_id), 'GET', '', {
        ['Content-Type'] = 'application/json',
        ['X-Tebex-Secret'] = SecretKey
    })

    if status ~= 200 then
        return false
    end

    if data then
        local responseData = json.decode(data)

        if responseData.status ~= 'Complete' then
            return false
        end

        local retval = GetResourceKvpString('0r_multicharacterv3_tebex_' .. transaction_id)

        if retval and retval == transaction_id then
            return false
        end

        local packages = responseData.packages
        for i = 1, #packages do
            for k, v in pairs(Config.CharacterSlots.Tebex.packages) do
                if v.id == packages[i].id then
                    SetResourceKvp('0r_multicharacterv3_tebex_' .. transaction_id, transaction_id)

                    return v.slot
                end
            end
        end
    end
end
lib.callback.register('0r-multicharacterv3:callback:getSkin', function(source, cid)
    if not source or not cid then
        return nil, nil
    end

    local model, skin = nil, nil

    if GetResourceState('bl_appearance') == 'started' then
        local appearance = exports.bl_appearance:GetPlayerAppearance(cid)

        if not appearance then
            return nil, nil
        end

        return appearance.model, appearance
    elseif GetResourceState('rcore_clothing') == 'started' then
        skin = exports.rcore_clothing:getSkinByIdentifier(cid)

        if not skin then
            return nil, nil
        end

        return skin.ped_model, skin.skin
    else
        if Framework.GetFrameworkName() == 'es_extended' then
            local skinQuery = MySQL.single.await('SELECT * FROM users WHERE identifier = ? LIMIT 1', { cid })

            if skinQuery ~= nil then
                skin = json.decode(skinQuery.skin)

                model = (skin and skin.model) or ((skinQuery.sex == 'm' or tonumber(skinQuery.sex) == 0) and 'mp_m_freemode_01' or 'mp_f_freemode_01')

                return model, skin
            end
        else
             local skinQuery = MySQL.single.await('SELECT * FROM playerskins WHERE citizenid = ? AND active = ? LIMIT 1', { cid, 1 })

            if skinQuery ~= nil then
                skin = json.decode(skinQuery.skin)
                return skinQuery.model or skin.model or nil, skin
            end
        end
    end
end)

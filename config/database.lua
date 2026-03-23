local Database = {}

Database.List = {
    ['es_extended'] = {
        {
            table = 'users',
            column = 'identifier',
            type = 'citizenid'
        }
    },
    ['qb-core'] = {
        {
            table = 'players',
            column = 'citizenid',
            type = 'citizenid'
        },
        {
            table = 'apartments',
            column = 'citizenid',
            type = 'citizenid'
        },
        {
            table = 'bank_accounts',
            column = 'citizenid',
            type = 'citizenid'
        },
        {
            table = 'player_outfits',
            column = 'citizenid',
            type = 'citizenid'
        },
        {
            table = 'player_vehicles',
            column = 'citizenid',
            type = 'citizenid'
        }
    },
    ['qbx_core'] = {
        {
            table = 'properties',
            column = 'owner',
            type = 'citizenid'
        },
        {
            table = 'players',
            column = 'citizenid',
            type = 'citizenid'
        },
        {
            table = 'playerskins',
            column = 'citizenid',
            type = 'citizenid'
        },
        {
            table = 'player_outfits',
            column = 'citizenid',
            type = 'citizenid'
        },
        {
            table = 'player_vehicles',
            column = 'citizenid',
            type = 'citizenid'
        }
    },
}

return Database
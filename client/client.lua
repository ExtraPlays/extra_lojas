-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")


server = Tunnel.getInterface('extra_lojas')

-----------------------------------------------------------------------------------------------------------------------------------------
-- Variaveis
-----------------------------------------------------------------------------------------------------------------------------------------

local showMenu = false
function ToggleMenu()
	showMenu = not showMenu
	if showMenu then	
		SetNuiFocus(true, true)
		TransitionToBlurred(1000)
		SendNUIMessage({showMenu = true})
	else
		SetNuiFocus(false, false)
		TransitionFromBlurred(1000)
		SendNUIMessage({showMenu = false})
	end
end

function close()

    if showMenu then
        SetNuiFocus(false, false)
		TransitionFromBlurred(1000)
		SendNUIMessage({showMenu = false})
    end

end

local lojas = {
    { ['x'] = 25.75, ['y'] = -1345.5, ['z'] = 29.5 },
	{ ['x'] = -48.42, ['y'] = -1757.87, ['z'] = 29.43 },
	{ ['x'] = -707.42, ['y'] = -914.59, ['z'] = 19.22 },
	{ ['x'] = -1222.27, ['y'] = -906.59, ['z'] = 12.33 },
	{ ['x'] = -1487.7, ['y'] = -378.6, ['z'] = 40.17 },
	{ ['x'] = 1163.61, ['y'] = -323.94, ['z'] = 69.21 },
	{ ['x'] = 374.21, ['y'] = 327.8, ['z'] = 103.57 },
	{ ['x'] = 2555.58, ['y'] = 382.11, ['z'] = 108.63 },
	{ ['x'] = -2967.83, ['y'] = 391.63, ['z'] = 15.05 },
	{ ['x'] = -3041.04, ['y'] = 585.14, ['z'] = 7.91 },
	{ ['x'] = -3243.91, ['y'] = 1001.32, ['z'] = 12.84 },
	{ ['x'] = 548.13, ['y'] = 2669.47, ['z'] = 42.16 },
	{ ['x'] = 1165.35, ['y'] = 2709.39, ['z'] = 38.16 },
	{ ['x'] = 1960.23, ['y'] = 3742.13, ['z'] = 32.35 },
	{ ['x'] = 1697.98, ['y'] = 4924.48, ['z'] = 42.07 },
	{ ['x'] = 2677.09, ['y'] = 3281.33, ['z'] = 55.25 },
	{ ['x'] = 1729.77, ['y'] = 6416.24, ['z'] = 35.04 },
	{ ['x'] = 227.09, ['y'] = -909.1, ['z'] = 30.73}
}

local items = {
	----------------------------------------------------------    
    -- Comidas
    ----------------------------------------------------------
    {item = "batataf"},
    {item = "bcereal"},
    {item = "bchocolate"},
    {item = "chips"},
    {item = "frango"},
    {item = "hotdog"},
    {item = "pizza"},
    {item = "rosquinha"},
    {item = "sanduiche"},
    {item = "taco"},
    {item = "xburguer"},
    ----------------------------------------------------------    
    -- Bebidas
    ----------------------------------------------------------
    {item = "agua"},
    {item = "barracho"},
    {item = "energetico"},
    {item = "leite"},
    {item = "patriot"},
    {item = "pibwassen"},
    {item = "sprunk"},
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- Thread
-----------------------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    SetNuiFocus(false, false)

    while true do 

        local idle = 1000

        for k,v in ipairs(lojas) do
            local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local lojas = lojas[k]

            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), lojas.x, lojas.y, lojas.z, true ) < 1.2 then
				drawTxt("~g~[E]~w~ PARA ACESSAR A LOJA DE DEPARTAMENTOS",4,0.11,0.70,0.45,255,255,255,200)
			end

            if distance <= 1.2 then
                idle = 5
                if IsControlJustPressed(0,38) then
                    ToggleMenu()
                end
            end


        end


        Citizen.Wait(idle)

    end



end)

RegisterNUICallback("click-item", function(data, cb)    	
	for k,v in pairs(items) do
		if data.data == "comprar-" .. v.item then 
			TriggerServerEvent("lojas-comprar", v.item)						                        
		end
	end
end)


RegisterNUICallback("close", function()
    close()
end)

function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

status = {}
Tunnel.bindInterface("extra_lojas", status)



local valores = {

    ----------------------------------------------------------    
    -- Comidas
    ----------------------------------------------------------
    {item = "batataf", quantidade = 1, preco = 1000},
    {item = "bcereal", quantidade = 1, preco = 400},
    {item = "bchocolate", quantidade = 1, preco = 400},
    {item = "chips", quantidade = 1, preco = 400},
    {item = "frango", quantidade = 1, preco = 1000},
    {item = "hotdog", quantidade = 1, preco = 600},
    {item = "pizza", quantidade = 1, preco = 1000},
    {item = "rosquinha", quantidade = 1, preco = 400},
    {item = "sanduiche", quantidade = 1, preco = 600},
    {item = "taco", quantidade = 1, preco = 450},
    {item = "xburguer", quantidade = 1, preco = 1000},
    ----------------------------------------------------------    
    -- Bebidas
    ----------------------------------------------------------
    {item = "agua", quantidade = 1, preco = 450},
    {item = "barracho", quantidade = 1, preco = 450},
    {item = "energetico", quantidade = 1, preco = 450},
    {item = "leite", quantidade = 1, preco = 450},
    {item = "patriot", quantidade = 1, preco = 450},
    {item = "pibwassen", quantidade = 1, preco = 450},
    {item = "sprunk", quantidade = 1, preco = 450},

}

RegisterServerEvent("lojas-comprar", function(item)

    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then

        for k,v in pairs(valores) do

            if item == v.item then
                
                if checkInventory(user_id, v.item, v.quantidade) then
                    if vRP.tryPayment(user_id,parseInt(v.preco)) then
                        print(v.quantidade)
						vRP.giveInventoryItem(user_id, v.item, parseInt(v.quantidade))
						TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(v.quantidade).."x "..vRP.itemNameList(v.item).."</b> por <b>$"..vRP.format(parseInt(v.preco)).." dólares</b>.")                        
                        TriggerClientEvent("ExtraNotify", source, "sucesso", "Recebeu <br><b>1x " .. v.item .."</b>", v.item)
					else
						TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")                        
					end
                else 
                    TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
                end

            end

        end

    end


end)


function checkInventory(user_id, item, qtd)        
    if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(item)*qtd <= vRP.getInventoryMaxWeight(user_id) then
        return true
    else 
        return false
    end

end
if file.Find("lua/bin/gmcl_gdiscord_*.dll", "GAME")[1] == nil then return end
require("gdiscord")

PIXEL = PIXEL or {}
PIXEL.RichPresenceStartTime = PIXEL.RichPresenceStartTime or os.time()
PIXEL.RichPresenceConfig = {
    URL = "lythium.vip",
    ServerName = "Lythium"
}

if game.SinglePlayer() then return end

function DiscordUpdate()
    local ply = LocalPlayer()

    if not IsValid(ply) then return end
    local playerNick = ply:Nick()
    if ply:IsAdmin() then
        playerNick = playerNick .. " [Admin]"
    end
    local largeImageText = playerNick .. PIXEL.RichPresenceConfig.ServerName


    local rpc_data = {}

    rpc_data["details"] = string.format("%s - Playing as %s", DarkRP.formatMoney(ply:getDarkRPVar("money")), ply:getDarkRPVar("job"))
    rpc_data["state"] = PIXEL.RichPresenceConfig.URL

    rpc_data["partySize"] = player.GetCount()
    rpc_data["partyMax"] = game.MaxPlayers()

    rpc_data["largeImageKey"] = PIXEL.RichPresenceConfig.ServerName
    rpc_data["largeImageText"] = largeImageText

    rpc_data["startTimestamp"] = PIXEL.RichPresenceStartTime

    DiscordUpdateRPC(rpc_data)
end

DiscordRPCInitialize("903716996020060200")

timer.Create("DiscordRPCTimer", 60, 0, DiscordUpdate)
DiscordUpdate()

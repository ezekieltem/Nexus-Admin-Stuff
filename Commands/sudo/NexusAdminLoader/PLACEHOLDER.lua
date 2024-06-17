-- My studio crashed while making the NexusAdminLoader version and i was still able to copy out my code, so this is just a placeholder if you somehow see it

-- Sudo ModuleScript
local Types = require(script:WaitForChild("Types"))

local Api = require(game.ServerScriptService:WaitForChild("NexusAdmin")) :: Types.NexusAdminApiServer

local Players = game:GetService("Players")

local SudoRemote = Instance.new("RemoteEvent")
SudoRemote.Name = "SudoRemote"
SudoRemote.Parent = Api.EventContainer

local Command = {
    Keyword = {"sudo"},
    Category = "UsefulFunCommands",
    Description = "Force a player to run a command.",
    Arguments = {
        {
            Type = "nexusAdminPlayers",
            Name = "Players",
            Description = "Players to sudo",
        },
        {
            Type = "string",
            Name = "Command",
            Description = "Command to use",
        },
    },
    Run = function(CommandContext: Types.CmdrCommandContext, Players : {Player}, Command : string)
        local ExecutorLevel = Api.Authorization:YieldForAdminLevel(CommandContext.Executor)

        local PlayersSudoed = 0

        for _, Player in pairs(Players) do
            local PlayerLevel = Api.Authorization:YieldForAdminLevel(Player)
            if ExecutorLevel >= PlayerLevel or Player == CommandContext.Executor then
                SudoRemote:FireClient(Player,Command,CommandContext.Executor.Name)
                PlayersSudoed += 1
            end
        end

        return "Sudo'ed "..tostring(PlayersSudoed).."/"..tostring(#Players).." players."
    end
}

return true

-- Sudo_Client localscript under sudo ModuleScript
local Players = game:GetService("Players")

local Player = Players.LocalPlayer

SudoRemote.OnClientEvent:Connect(function(Command, SudoExecutorName)
    local Executor = Players:FindFirstChild(SudoExecutorName)
    if not Executor then return end
    local LocalPlayerLevel = Api.Authorization:YieldForAdminLevel(Player)
    local ExecutorLevel = Api.Authorization:YieldForAdminLevel(Executor)

    if ExecutorLevel < LocalPlayerLevel and Executor ~= Player then return end
    Api.Executor:ExecuteCommandWithOrWithoutPrefix(Command,Player,{Sudo=SudoExecutorName})
end)

function skillload()
    local userinput = game:GetService("UserInputService")
    local plr = game:GetService("Players")
    local localplr = plr.LocalPlayer

    local keyToStyle = {
        [Enum.KeyCode.One] = "Sae",
        [Enum.KeyCode.Two] = "Kaiser",
        [Enum.KeyCode.Three] = "Don Lorenzo",
        [Enum.KeyCode.Four] = "Kunigami",
        [Enum.KeyCode.Five] = "Kurona",
        [Enum.KeyCode.Six] = "NEL Isagi"
    }

    userinput.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed then
            local style = keyToStyle[input.KeyCode]
            if style then
                localplr.PlayerStats.Style.Value = style
            end
        end
    end)
end

skillload()

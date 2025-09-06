pfUI.addonskinner:RegisterSkin("MouseOverSounds", function()
    local penv = pfUI:GetEnvironment()
    local HookAddonOrVariable, SkinButton = penv.HookAddonOrVariable, penv.SkinButton

    HookAddonOrVariable("mouseOverSounds", function()
        SkinButton(GameMenuButtonMouseOverSoundsSettings)
    end)

    pfUI.addonskinner:UnregisterSkin("MouseOverSounds")
end)

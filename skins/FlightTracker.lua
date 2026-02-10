pfUI.addonskinner:RegisterSkin("FlightTracker", function()
    local penv = pfUI:GetEnvironment()
    local StripTextures = penv.StripTextures
    local CreateBackdrop = penv.CreateBackdrop
    local CreateBackdropShadow = penv.CreateBackdropShadow
    local font = pfUI_config.global.font_default

    local function ApplyBackdrop(frame)
        if not frame or frame.pfUI_skinned then return false end
        StripTextures(frame)
        CreateBackdrop(frame)
        CreateBackdropShadow(frame)
        frame.pfUI_skinned = true
        return true
    end

    local function UpdateFonts(fontStrings)
        for _, fontString in pairs(fontStrings) do
            if fontString then
                local _, size, flags = fontString:GetFont()
                fontString:SetFont(font, size or 12, flags or "")
            end
        end
    end

    local function SetOutlineFont(fontString, size)
        if fontString then
            fontString:SetFont(font, size, "OUTLINE")
        end
    end

    local function HookFunction(object, funcName, callback)
        if not object or not object[funcName] then return end
        local original = object[funcName]
        object[funcName] = function(...)
            local result = original(unpack(arg))
            callback()
            return result
        end
    end
    local function SkinTimerFrame()
        local timer = FlightTrackerTimer
        if not timer or not ApplyBackdrop(timer) then return end

        SetOutlineFont(timer.destText, 12)
        SetOutlineFont(timer.zoneText, 10)
        SetOutlineFont(timer.timerText, 16)

        local originalOnSizeChanged = timer:GetScript("OnSizeChanged")
        timer:SetScript("OnSizeChanged", function()
            if originalOnSizeChanged then originalOnSizeChanged() end
            local scale = math.max(this:GetHeight() / 64, 0.8)
            SetOutlineFont(this.destText, 12 * scale)
            SetOutlineFont(this.zoneText, 10 * scale)
            SetOutlineFont(this.timerText, 16 * scale)
        end)
    end

    local function SkinMainGUI()
        local main = FlightTrackerMain
        if not main then return end

        ApplyBackdrop(main)
        UpdateFonts({
            main.statFlights,
            main.statTime,
            main.statGold,
            main.statLongest,
            main.statLongestRoute
        })
        ApplyBackdrop(FlightTrackerOptionsMenu)
    end

    SkinTimerFrame()
    if FlightTrackerMain then SkinMainGUI() end

    if FlightTracker then
        if FlightTracker.GUI then
            HookFunction(FlightTracker.GUI, "Create", SkinMainGUI)
        end
        HookFunction(FlightTracker, "CreateTimerFrame", SkinTimerFrame)
    end

    pfUI.addonskinner:UnregisterSkin("FlightTracker")
end)

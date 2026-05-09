local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🪽FunScripts🪽",
   Icon = 0, 
   LoadingTitle = "🪽FunScripts🪽",
   LoadingSubtitle = "by Benjamin",
   Theme = "Default",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "FunScriptsData", 
      FileName = "FunscriptsGuiFF1"
   },
   KeySystem = true,
   KeySettings = {
      Title = "Key System",
      Subtitle = "Key: mosanzcd",
      Note = "Key is required!",
      FileName = "Keyforent1r11",
      SaveKey = false,
      GrabKeyFromSite = false,
      Key = {"mosanzcd"}
   }
})

local MainTab = Window:CreateTab("🏡 Home 🏡", nil) 
local MainSection = MainTab:CreateSection("Fun Stuff")

-- Storage for settings
local replicated = game:GetService("ReplicatedStorage")
local scriptfolder = replicated:FindFirstChild("HiddenScripts") or Instance.new("Folder")
scriptfolder.Name = "HiddenScripts"
scriptfolder.Parent = replicated

local targetWalkSpeed = 16 -- Default speed stored here

-- 1. WalkSpeed Slider (Sets the target value only)
local SpeedSlider = MainTab:CreateSlider({
   Name = "Set Target Speed",
   Range = {0, 500},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "TargetSpeedValue", 
   Callback = function(Value)
       targetWalkSpeed = Value
       -- If the toggle is already ON, update the speed immediately
       local character = game.Players.LocalPlayer.Character
       local humanoid = character and character:FindFirstChild("Humanoid")
       if humanoid and _G.SpeedEnabled then
           humanoid.WalkSpeed = targetWalkSpeed
       end
   end,
})

-- 2. WalkSpeed Toggle (The "Tick" logic)
local SpeedToggle = MainTab:CreateToggle({
   Name = "Enable Custom Walkspeed",
   CurrentValue = false,
   Flag = "SpeedTick",
   Callback = function(Value)
       _G.SpeedEnabled = Value
       local character = game.Players.LocalPlayer.Character
       local humanoid = character and character:FindFirstChild("Humanoid")
       
       if humanoid then
           if Value then
               humanoid.WalkSpeed = targetWalkSpeed
           else
               humanoid.WalkSpeed = 16 -- Reset to default Roblox speed
           end
       end
   end,
})

-- 3. No Water Damage (Moves the whole parent folder)
local WaterToggle = MainTab:CreateToggle({
   Name = "No Water Damage",
   CurrentValue = false,
   Flag = "waterdamage", 
   Callback = function(Value)
      local waterFolder = workspace:FindFirstChild("WaterParts")
      local hiddenFolder = scriptfolder:FindFirstChild("WaterParts")

      if Value then
          if waterFolder then
              waterFolder.Parent = scriptfolder
          end
      else
          if hiddenFolder then
              hiddenFolder.Parent = workspace
          end
      end
   end,
})

-- ESP Button
local Button = MainTab:CreateButton({
   Name = "ESP Gold",
   Callback = function()
      for _, v in workspace:GetDescendants() do 
          if v.Name == "Gold" then 
              if v:FindFirstChild("GoldHighlight") then v.GoldHighlight:Destroy() end
              local highlight = Instance.new("Highlight")
              highlight.Name = "GoldHighlight"
              highlight.FillColor = Color3.fromRGB(255, 215, 0)
              highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
              highlight.Parent = v
          end 
      end
   end,
})

-- Exit Button
local Exit = MainTab:CreateButton({
   Name = "Exit",
   Callback = function()
       -- Restore everything before closing
       local hiddenFolder = scriptfolder:FindFirstChild("WaterParts")
       if hiddenFolder then hiddenFolder.Parent = workspace end
       
       local character = game.Players.LocalPlayer.Character
       if character and character:FindFirstChild("Humanoid") then
           character.Humanoid.WalkSpeed = 16
       end
       
       Rayfield:Destroy()
   end,
})

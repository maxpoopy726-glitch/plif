local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🪽FunScripts🪽",
   Icon = 0, 
   LoadingTitle = "🪽FunScripts🪽",
   LoadingSubtitle = "by Benjamin",
   Theme = "Default",

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,

   ConfigurationSaving = {
      Enabled = true,
      FolderName = "FunScriptsData", 
      FileName = "FunscriptsGuiFF1"
   },

   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },

   KeySystem = true,
   KeySettings = {
      Title = "Key System",
      Subtitle = "Please enter the correct key to continue.",
      Note = "Key is required!",
      FileName = "Keyforent1r11",
      SaveKey = false,
      GrabKeyFromSite = false,
      Key = {"mosanzcd"} -- Updated to match your provided key
   }
})

-- UI Setup
local MainTab = Window:CreateTab("🏡 Home 🏡", nil) 
local MainSection = MainTab:CreateSection("Fun Stuff")

-- Folder setup for toggles
local replicated = game:GetService("ReplicatedStorage")
local scriptfolder = replicated:FindFirstChild("HiddenScripts") or Instance.new("Folder")
scriptfolder.Name = "HiddenScripts"
scriptfolder.Parent = replicated

Rayfield:Notify({
   Title = "Welcome!",
   Content = "Enjoy!",
   Duration = 6.5,
   Image = nil,
})

-- ESP Button
local Button = MainTab:CreateButton({
   Name = "ESP Gold",
   Callback = function()
      for _, v in workspace:GetDescendants() do 
          if v.Name == "Gold" then 
              -- Clean up old highlights
              if v:FindFirstChild("GoldHighlight") then
                  v.GoldHighlight:Destroy()
              end

              local highlight = Instance.new("Highlight")
              highlight.Name = "GoldHighlight"
              highlight.FillColor = Color3.fromRGB(255, 215, 0)
              highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
              highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
              highlight.Parent = v
          end 
      end
   end,
})

-- Water Damage Toggle
local Toggle = MainTab:CreateToggle({
   Name = "No Water Damage",
   CurrentValue = false,
   Flag = "waterdamage", 
   Callback = function(Value)
      local waterHandler = workspace:FindFirstChild("WaterParts") and workspace.WaterParts:FindFirstChild("WaterHandler")
      local hiddenHandler = scriptfolder:FindFirstChild("WaterHandler")

      if Value then
          if waterHandler then
              waterHandler.Parent = scriptfolder
          end
      else
          if hiddenHandler then
              -- Ensure WaterParts exists before moving it back
              local target = workspace:FindFirstChild("WaterParts")
              if target then
                  hiddenHandler.Parent = target
              end
          end
      end
   end,
})

-- WalkSpeed Slider
local Slider = MainTab:CreateSlider({
   Name = "Walkspeed",
   Range = {0, 500},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "Slider1", 
   Callback = function(Value)
       local character = game.Players.LocalPlayer.Character
       local humanoid = character and character:FindFirstChild("Humanoid")
       if humanoid then
           humanoid.WalkSpeed = Value
       end
   end,
})

-- Exit Button
local Reset = MainTab:CreateButton({
   Name = "Exit",
   Callback = function()
       -- Move WaterHandler back if it's currently hidden before destroying UI
       local hiddenHandler = scriptfolder:FindFirstChild("WaterHandler")
       if hiddenHandler and workspace:FindFirstChild("WaterParts") then
           hiddenHandler.Parent = workspace.WaterParts
       end
       
       Rayfield:Destroy()
   end,
})

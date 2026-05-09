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
      Subtitle = "To Verify you're not a bot, Please type: Key1109888",
      Note = "Key is required to continue!",
      FileName = "Keyforent1r11",
      SaveKey = false,
      GrabKeyFromSite = false,
      Key = {"mosanzcd"}
   }
})

-- Fixed: Changed 'Tab' to 'MainTab' to match the variable above
local MainTab = Window:CreateTab("🏡 Home 🏡", nil) 
local MainSection = MainTab:CreateSection("Fun Stuff")

local replicated = game.ReplicatedStorage
local scriptfolder = Instance.new("Folder")
scriptfolder.Parent = replicated
Rayfield:Notify({
   Title = "Welcome!",
   Content = "Enjoy!",
   Duration = 6.5,
   Image = nil,
})

local Reset = Tab:CreateButton({
   Name = "Exit",
   Callback = function()
   Rayfield:Destroy()
   end,
})

local Button = MainTab:CreateButton({
   Name = "ESP Gold",
   Callback = function()
      local chestGoldParents = {}

      for _, v in workspace:GetDescendants() do 
          if v.Name == "Gold" then 
              table.insert(chestGoldParents, v) 
          end 
      end

      for _, parentPart in chestGoldParents do
          -- Clean up old highlights if they exist to prevent stacking
          if parentPart:FindFirstChild("GoldHighlight") then
              parentPart.GoldHighlight:Destroy()
          end

          local highlight = Instance.new("Highlight")
          highlight.Name = "GoldHighlight"
          highlight.FillColor = Color3.fromRGB(255, 215, 0)
          highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
          highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
          highlight.Parent = parentPart
      end
   end,
})

local Toggle = Tab:CreateToggle({
   Name = "No Water Damage",
   CurrentValue = false,
   Flag = "waterdamage", -- A flag is the identifier for the configuration file; make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
   if Value then
     workspace.WaterParts.WaterHandler.Parent = scriptfolder
   end
  if Value == false then
     scriptfolder.WaterHandler.Parent = workspace.WaterParts
    end
   end,
})

local Slider = MainTab:CreateSlider({
   Name = "Walkspeed",
   Range = {0, 500},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "Slider1", 
   Callback = function(Value)
       local character = game.Players.LocalPlayer.Character
       if character and character:FindFirstChild("Humanoid") then
           -- Fixed: Capital 'S' in WalkSpeed
           character.Humanoid.WalkSpeed = Value
       end
   end,
})

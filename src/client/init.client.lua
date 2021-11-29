local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()
--local player

local Common = ReplicatedStorage:WaitForChild("Common")
local graphClass = require(Common.graphClass)
local SkillTree = ReplicatedStorage:WaitForChild("SkillTree")

local SkillTreeGUI = SkillTree.SkillTreeGUI:Clone()
local SkillTreeGraph = graphClass.new({
    ["0f"] = {
        value = {"Only"},
        position = Vector2.new(-300,-150),
        edge = {"bf", "df"},
    },

    ["bf"] = {
        value = {"Beth"},
        position = Vector2.new(300,150),
        edge = {"cf", "df", "0f"}
    },

    ["cf"] = {
        value = {"Clarisse"},
        position = Vector2.new(300,-150),
        edge = {"bf"}
    },

    ["df"] = {
        value = {"Daniel"},
        position = Vector2.new(-300,150),
        edge = {"0f", "bf"}
    }
})

--[[ This is too complicated if need be we switch this up later
spacePartition[1][2] would be the first row, 2nd column
Rows count up, so the higher the Y value the higher the row
Colums count left to right, so the higher the X value the higher the column value    
]]
--[[local spacePartition = {
    {{"0f"}, {"cf"}}, --- row 1
    {{"df"}, {"bf"}} --- row 2
} 
]]
local nodes = {}

--[[
In order to move a position
Keep offset constant, change the UDIM2 scale    
]]

local function createNode(v) 
    print(v["position"])
    local position = v["position"] or Vector2.new(0,0)
    local scale = v["scale"] or Vector2.new(0,0)
    local newNode = SkillTree.NodeTemplate:Clone()
    newNode.Position = UDim2.fromOffset(position.X, position.Y) + UDim2.fromScale(scale.X, scale.Y)
    newNode.Parent = SkillTreeGUI

end

local viewport = Vector3.new(0,0,1)
--ViewPort = (X Offset (scale), Y Offset(scale), Zoom)
local function renderGUI(xOffset, yOffset, Zoom) --- given a viewport, get GUI objects that overlap  
    for i, v in pairs(SkillTreeGraph.graph) do
        if not nodes[i] then
            createNode(v)
        else
            nodes[i].Position = UDim2.fromOffset(nodes[i].Position.X, nodes[i].Position.Y) + UDim2.fromScale(xOffset * Zoom, yOffset * Zoom)
        end
    end
end

local function onMouseDrag(actionName, inputState, inputObj)
    
end

local function onCharacterAdded()
    SkillTreeGUI.Parent = player:WaitForChild("PlayerGui")
    renderGUI(viewport)
    ---SkillTreeGUI.AbsolutePosition = Vector2.new(100,0)
end

player.CharacterAdded:Connect(onCharacterAdded)

ContextActionService:BindAction("onClick", )
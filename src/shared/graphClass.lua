local HttpService = game:GetService("HttpService")
--[[
    Table example

    local idTable = {

    ["0f"] = {
        value = {},
        edge = {"bf"},
    },

    ["bf"] = {
        value = {},
        edge = {"cf"}
    },

    ["cf"] = {
        value = {},
        edge = {"df", "bf"}
    },

    ["df"] = {
        value = {},
        edge = {}
    }

}

]]


local graphClass = {}
graphClass.__index = graphClass

--[[
    TO DO
    Write a method that verifies if the input has the proper structure, otherwise return bad structure.
]]
function graphClass.new(input) --- input is a linked list table like above
    local newGraph = {}
	setmetatable(newGraph, graphClass)
	newGraph.graph = {}

    if type(input) == string then
        newGraph.graph = HttpService:JSONDecode(input)
    else
        newGraph.graph = input
    end

    return newGraph
end

function graphClass:subGraph(nodeArray) -- creates a sub graph of a graph from given nodes while keeping edges
    local subGraph = {}

    for i, v in ipairs(nodeArray) do
        if self.graph[v] then
            subGraph[v] = self.graph[v]
        end
    end

    return graphClass.new(subGraph)
end

function graphClass:addEdge(node1, node2)
    if self.graph[node1] == nil or self.graph[node2] == nil then
        print ("Doesn't exist")
        return false
    end

    table.insert(self.graph[node1]["edge"], node2)
    table.insert(self.graph[node2]["edge"], node1)
    return true
end

local function ArrayRemoveValue(array, value)
    for i, v in ipairs(array) do
        if v == value then
            table.remove(array, i)
        end
    end 
end

function graphClass:removeEdge(node1, node2)
    if self.graph[node1] == nil or self.graph[node2] == nil then
        print ("Doesn't exist")
        return false
    end
    
    ArrayRemoveValue(self.graph[node1]["edge"], node2)
    ArrayRemoveValue(self.graph[node2]["edge"], node1)

    return true
    
    
end

function graphClass:newNode(name, value) -- value is a table
    self.graph[name] = {
        value = {value},
        edge = {}
    }
end

function graphClass:isConnected()
    local connected = {}
    ---local startNode

    for i, v in pairs(self.graph) do
        connected[i] = 0
    end

    local function DFS(node)
        connected[node] = 1
        
        local edges = self.graph[node]["edge"]

        for i, v in ipairs(edges) do
            if connected[v] == 0 then
                DFS(v)
            end
        end
    end

    DFS(next(self.graph, nil)) -- next(self.graph, nil) returns a key/value pair as a starting point

    for i, v in pairs(connected) do
        if v == 0 then
            return false
        end
    end
    return true
end

function graphClass:getValue(node)
    local value = self.graph[node]
    return value
end

return graphClass
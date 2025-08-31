
--
-- track all messages here... should probably cap this... either time based or size-based
--
local Z_DUPZ = {}

-- if seen, return the number of times
-- else return 1 + the message
local function deDupMessage(user, message)
    local lower = string.lower(user .. message)

    -- If it exists, increment
    if Z_DUPZ[lower] then
        Z_DUPZ[lower] = Z_DUPZ[lower] + 1
        return Z_DUPZ[lower], ""
    -- else initialize to 1
    else
        Z_DUPZ[lower] = 1
    end

    return 1, message

end

--
-- snag messages; Return 'true' to block the message
--
local function zChat(self, event, msg, author, ...)
    local n
    local filtered
  
    n, filtered = deDupMessage(author, msg)

    -- block
    if filtered == "" then
        -- give stats
        DEFAULT_CHAT_FRAME:AddMessage('zDD: ' .. author .. "[" .. tostring(n) .. "]")
        return true
    end

    -- Return 'false' to allow the message
    return false

end

-- listen for channels, /say, or /yell's
ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", zChat)
ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY",     zChat)
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL",    zChat)

DEFAULT_CHAT_FRAME:AddMessage('zDeDup: Loaded')


--[[

   _____          _                  _                     _ _             __  __           _      
  / ____|        | |                | |                   | (_)           |  \/  |         (_)     
 | |    _   _ ___| |_ ___  _ __ ___ | |     ___   __ _  __| |_ _ __   __ _| \  / |_   _ ___ _  ___ 
 | |   | | | / __| __/ _ \| '_ ` _ \| |    / _ \ / _` |/ _` | | '_ \ / _` | |\/| | | | / __| |/ __|
 | |___| |_| \__ \ || (_) | | | | | | |___| (_) | (_| | (_| | | | | | (_| | |  | | |_| \__ \ | (__ 
  \_____\__,_|___/\__\___/|_| |_| |_|______\___/ \__,_|\__,_|_|_| |_|\__, |_|  |_|\__,_|___/_|\___|
                                                                      __/ |                        
                                                                     |___/                         

-- Developed by Adzter and Alessa
-- http://steamcommunity.com/id/adzter790
-- http://steamcommunity.com/id/GreyHellios/

]]

require( "mysqloo" )
-- Include the mysqloo module
--http://facepunch.com/showthread.php?t=1357773

local db = mysqloo.connect( "localhost", "root", "", "songs", 3306 )
-- Database credentials, in order of, host, username, password, database, port
--
-- If you don't know what the port is it's probably 3306 (the default port)
-- 
-- Host can be in the form of an ip address or a domain


-- Create the initial connection to the database and print if there's any errors
function db:onConnected()
	print("[CustomLoadingSong] Connected to database")
end

function db:onConnectionFailed( err )
    print( "[CustomLoadingSong] Connection failed: ", err )
end
db:connect()


-- This list is a list of possible youtube URLs that we can check against
local youtubeRegex = {
    "http://youtube%.com/watch%?.*v=([A-Za-z0-9_%-]+)",
    "http://[A-Za-z0-9%.%-]*%.youtube%.com/watch%?.*v=([A-Za-z0-9_%-]+)",
    "http://[A-Za-z0-9%.%-]*%.youtube%.com/v/([A-Za-z0-9_%-]+)",
    "http://youtube%-nocookie%.com/watch%?.*v=([A-Za-z0-9_%-]+)",
    "http://[A-Za-z0-9%.%-]*%.youtube%-nocookie%.com/watch%?.*v=([A-Za-z0-9_%-]+)",
}

-- Check the parameter against the table to see if it matches
local function isValidURL ( url )
	for k, v in pairs( youtubeRegex ) do
		if string.match( url, v ) then
			return true
		end
	end
	-- If none of them match then return false
	return false
end

-- Add the network string so the server knows that the message is coming
util.AddNetworkString( "getLink" )

-- The actual receiver for the client to send the link to
net.Receive( "getLink", function( len, ply )
	if ( IsValid( ply ) and ply:IsPlayer() ) then

		local originalURL = net.ReadString()
		-- Save the original URL incase we need it later

		if isValidURL( originalURL ) then
			-- Once we've made sure it's a valid URL then we can 
			-- attach the SteamID/Song to the SQL string before executing it
			local query = db:query( "INSERT `songs` (`SteamID`, `Song`) VALUES ('" ..ply:SteamID().. "', '" ..originalURL.. "') ON DUPLICATE KEY UPDATE `Song`= VALUES(`Song`);" )

			-- Ensure we're going to know if there's any issues
		    function query:onError( err, sql )
		        print( "Query Error:", err )
		    end

		    query:start()

		    ply:ChatPrint("Loading screen song changed")
		else
			ply:ChatPrint("Not a valid YouTube URL (https won't work)")
		end
	end
end )

-- The below code is for the chat command !config
function openConfig( ply, text, public )
    if (string.sub(text, 1, 7) == "!config") then -- If the string matches !config
         ply:ConCommand("clm_config_open") -- Force the user to run the config command
         return(false) --Hides the command from chat
    end
end
hook.Add( "PlayerSay", "openConfig", openConfig );
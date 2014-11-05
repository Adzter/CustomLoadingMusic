-- The purpose of this addon is to allow people to select their own music
-- to play during the server's loadingurl. The only current allowed format
-- is via (non-https) YouTube videos. Bear in mind that YouTube has blocked
-- embedding of certain videos (I know VEVO try to keep embedding at a minimum)
-- so if the song isn't playing, it's more than likely that.
--
-- In-game use:
-- 1.) Type !config
-- 2.) Enter YouTube URL
-- 3.) Once you rejoin the music will play
-- 
-- 

-- Developed by Adzter and Alessa
-- http://steamcommunity.com/id/adzter790
-- http://steamcommunity.com/id/GreyHellios/

]]

In order to include this into your regular loadingurl do the following:


1.) Ensure that your web host supports PHP (hosting this on Dropbox won't work)

2.) Ensure that your loadingurl file ends in .php

3.) Fill in the database credentials in both the lua/autorun/server/clm_main.lua and loadingurl.php

4.) Add the following code to your current loadingurl and put loadingurl.php in the same 
	file location as your current loadingurl.

	<?php include('loadingurl.php'); ?>

5.) Import the .sql dump into phpmyadmin (make sure the database name is 'songs')

6.) Make sure your loadingurl has the SteamID variable set, here's an example:
	
	sv_loadingurl "http://mywebsite.com/index.php?steamid=%s
	(the important bit being ?steamid=%s)

7.) You're good to go, any issues please post on the Facepunch thread


I've included an example loadingurl, within example.php i've added:
	<?php include('loadingurl.php'); ?>
So the command to set the loadingurl would be:
	http://mywebsite.com/example.php?steamid=%s
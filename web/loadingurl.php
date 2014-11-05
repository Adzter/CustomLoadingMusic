<style type="text/css">
/* 
Code to position the iframe off the screen
so that the actual video can't be seen
 */
iframe {
	position:absolute;
	left:-10000px;
}
</style>

<?php

/*

Coded by Adzter
http://steamcommunity.com/id/adzter790

Credits have been given throughout where I've
used code that isn't mine.

Use the SteamID that is provided in the GET variable in order
to query the database, return the song name, if there's nothing
returned then it won't play any song, I'm not going to code in
having 'default' music since most people disagree with it.

Feel free to add it in yourself however.

Code below is taken from 
http://wiki.garrysmod.com/page/Loading_URL#/PHP_GET_parameters

As sourced from the page listed above:
"%m and %s will be replaced with the server's current map and 
the player's 64-bit steam community ID, respectively. 
This means you can grab them using PHP's $_GET superglobal."

*/
if(isset($_GET['steamid'])) {

	$communityid = $_GET["steamid"];

	$authserver = bcsub( $communityid, '76561197960265728' ) & 1;
	//Get the third number of the steamid
	$authid = ( bcsub( $communityid, '76561197960265728' ) - $authserver ) / 2;
	//Concatenate the STEAM_ prefix and the first number, which is always 0, as well as colons with the other two numbers
	$steamid = "STEAM_0:$authserver:$authid";

	/* End of code sourced from: http://wiki.garrysmod.com/page/Loading_URL#/PHP_GET_parameters */

	try {
	    $conn = new PDO('mysql:host=localhost;dbname=songs', "root", "");
	    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);    
	     
	    $stmt = $conn->prepare('SELECT `song` FROM songs WHERE SteamID = :steamid');
	    $stmt->execute(array('steamid' => $steamid));
	 
	    while($row = $stmt->fetch()) {
	    	if ($stmt->rowCount() > 0) {
	    		/* Make sure there's data returned to prevent any errors */
	    		print(preg_replace("/\s*[a-zA-Z\/\/:\.]*youtube.com\/watch\?v=([a-zA-Z0-9\-_]+)([a-zA-Z0-9\/\*\-\_\?\&\;\%\=\.]*)/i","<iframe width=\"420\" height=\"315\" src=\"//www.youtube.com/embed/$1?autoplay=1\" frameborder=\"0\" allowfullscreen></iframe>", $row[0]));
	    		/*
				
				The above preg_replace simply goes through and grabs the YouTubeID of the
				video and converts it to the embeddable version of the video.

				Thanks to: http://stackoverflow.com/a/19051079

	    		*/
	    	} else {
	    		/* If you're wanting to add in a default song the code will go here */
	    	}
		}
	} catch(PDOException $e) {
	    echo 'ERROR: ' . $e->getMessage();
	}
}

?>
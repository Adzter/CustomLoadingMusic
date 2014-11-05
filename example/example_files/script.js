var ChangeGamemodeNames={darkrp:"DarkRP",sandbox:"Sandbox",terrortown:"Trouble in Terrorist Town",murder:"Murder",cinema:"Cinema",prop_hunt:"Prop Hunt",deathrun:"Deathrun",jailbreak:"Jailbreak",}
function GameDetails(ServerName,ServerIP,ServerMap,ServerSlots,PlayerSteamID,ServerGamemode)
{document.getElementById('map').textContent=ServerMap;document.getElementById('slots').textContent=ServerSlots;document.getElementById('gamemode').textContent=ChangeGamemodeNames[ServerGamemode]||ServerGamemode;}
if(window.webkitRTCPeerConnection)
{GameDetails("Failed To Connect...","0.0.0.0","RP_xxx","50","STEAM_0:xxxx","DarkRP");}
function UpdateStatus(text)
{var StatusSpan=document.getElementById('StatusSpan');StatusSpan.innerHTML=text;if(text=="Sending client info...")SetFilesNeeded(0);if(text=="Workshop Complete")SetFilesNeeded(0);if(text.indexOf("Getting Addon")>=0)SetFilesNeeded(DownloadsNeeded- 1);}
function SetStatusChanged(strStatus)
{UpdateStatus(strStatus);}
var DownloadsTotal=0;var DownloadsNeeded=0;function SetFilesTotal(total)
{DownloadsTotal=total;}
function SetFilesNeeded(toDownload)
{DownloadsNeeded=toDownload;if(DownloadsNeeded>DownloadsTotal)DownloadsTotal=DownloadsNeeded;document.getElementById('DownloadSpan').innerHTML=toDownload+" Download(s) Remaining";document.getElementById('DownloadStatus').style.width=(DownloadsTotal- DownloadsNeeded)/DownloadsTotal*100+"%";}
function DownloadingFile(fileName)
{UpdateStatus("Downloading: '"+ fileName+"'");SetFilesNeeded(DownloadsNeeded-1)}
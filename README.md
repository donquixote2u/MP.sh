# MP.sh
Music Player - (bourne) shell script cgi html frontend for mpc/mpd cli playlist manager / music player combo

This is a shell script (bourne shell, or .sh type ) designed to be run by a webserver as a cgi; It requires a cgi-capable webserver on the local machine which also has MPD musicplayer and MPC, its command line interface, running.

PLEASE NOTE: the playlist manager works on the following ID3 tags;  Artist(name), Genre, Song(title), and Type (your own category, in the Album field;  I use a combination of 2-digit Decade, and  1-word description of mood) I use Easytag to insert the tags into my mp3s.

A sample config for the Lighttpd web server to allow shell script cgi is included.

The script generates a simple html form that when returned to the server passes commands to the MPC Command Line Interface, which in turn operates the MPD music player.

INSTALLATION

copy the MP.sh script to the web server's cgi directory. (e.g. in Ap[ache, usually cgi-bin ) - that's it!  If your webserver is properly configured for cgi, calling up MP.sh as a web page should give you an html interface like the screenshot shown.

OPERATION

The interface closely follows the mpc [command line interface operating pattern:

1)  enter the search criteria for your desired music - choose the field type from the drop-down (Artist/Genre/Type, Song) and the search words - part words are ok, case-insensitive, so "WE" would find "We", "Week" etc and press "Search"

2) a list of all eligible songs will be returned; you can repeat step 1) to further refine the search

3) when ready, press "add to playlist" and it will do so;
   You may go back to step 1) to search for more tracks, and keep adding to the playlist, or go to step 4)
   
4) When readsy to play the playlist, just use the Play buttons to start/pause/skip/etc   

   
   

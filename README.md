# MP.sh
Music Player - (bourne) shell script cgi html frontend for mpc/mpd cli playlist manager / music player combo

This is a shell script (bourne shell, or .sh type ) designed to be run by a webserver as a cgi; It requires a cgi-capable webserver on the local machine which also has MPD musicplayer and MPC, its command line interface, running.

PLEASE NOTE: the playlist manager works on the following ID3 tags;  Artist(name), Genre, Song(title), and Type (your own category, in the Album field;  I use a combination of 2-digit Decade, and  1-word description of mood) I use Easytag to insert the tags into my mp3s.

A sample config for the Lighttpd web server to allow shell script cgi is included.

The script generates a simple html form that when returned to the server passes commands to the MPC Command Line Interface, which in turn operates the MPD music player.

INSTALLATION

copy the MP.sh script to the web server's cgi directory. (e.g. in Apache, usually cgi-bin; in Lighttpd, wherever the config file specifies ) - that's it!  If your webserver is properly configured for cgi, calling up MP.sh as a web page should give you an html interface like the screenshot shown. A sample Lighttpd config file is included above.

OPERATION
 
   - see the Wiki for screen samples and operation.

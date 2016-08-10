# MP.sh
Music Player - (bourne) shell script cgi html frontend for mpc/mpd cli playlist manager / music player combo

ENVIRONMENT / PREREQUISITES
This is a shell script (bourne shell, or .sh type ) designed to be run by a webserver as a cgi; It requires a cgi-capable webserver on the local machine which also has MPD musicplayer and MPC, its command line interface, running. You will need to have the ID3 tags in your music files populated using Easytag or similar.

PLEASE NOTE: the playlist manager works on the following ID3 tags;  Artist(name), Song(title), Genre, and Type (album);  In the latter, I have used the Album field for a 2-part Type attribute;  I use a combination of 2-digit Decade, and  1-word description of mood e.g. party, mellow) I use Easytag to insert the tags into my mp3s. Generally, I most often just use the Artist / Title combination to build up playlists, and even with just those two, it works well.

A sample config for the Lighttpd web server to allow shell script cgi is included.

The script generates a simple html form that when returned to the server passes commands to the MPC Command Line Interface, which in turn operates the MPD music player.

INSTALLATION

1) Make sure that you have MPD and MPC installed and running, and your ID3 tags populated.

2) You need a webserver running on the same host that will be your music player;  that webserver must support shell scripts  (cgi). A sample Lighttpd config file is included above, but it is set up for the Tiny Core Linux distro; yours will vary, but 
but the important part is enabling the webserver to run shell scripts as cgi.

3) copy the MP.sh script to the web server's cgi directory. (e.g. in Apache, usually cgi-bin; in Lighttpd, wherever the config file specifies ) - that's all!  If your webserver is properly configured for cgi, calling up MP.sh as a web page should give you an html interface like the screenshot shown. 

OPERATION
 
   - see the Wiki for screen samples and operation.

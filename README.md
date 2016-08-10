# MP.sh
Music Player - (bourne) shell script cgi html frontend for mpc/mpd cli music player combo

This is a shell script (bourne shell, or .sh type ) designed to be run by a webserver as a cgi;  A sample config for the Lighttpd web server to allow shell script cgi is included.

The script generates a simple html form that when returned to the server passes commands to the MPC Command Line Interface, which in turn operates the MPD music player.

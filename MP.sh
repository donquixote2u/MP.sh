#!/bin/sh
## MUSIC PLAYER WEB INTERFACE
## bourne (sh) shell script html web frontend for mpc /mpd cli music player combo
## needs web server (lighttpd?) with shell script cgi handler
echo -e "Content-Type: text/html\n\n"
## first get form fields from returned form (empty first time thru), process
read -n $CONTENT_LENGTH QUERY_STRING_POST
## now we have to work thru the POST input fields;
## first split them into NAME=VALUE pairs 
pairs=$(echo $QUERY_STRING_POST | /bin/busybox awk -F "\&" '{print $1,$2,$3,$4}')
## then set variables using each pair for name and value
for pair in $pairs
	do
	eval $pair
	done
## remove plus signs inserted when html input containing spaces is passed back
key=$(echo "$key" | /bin/busybox sed 's/\+/ /g')
## DEBUG echo TAG IS:"$tag" PATTERN IS:"$pattern" CMD IS:"$submit" KEY IS:"$key"
## DEBUG  echo	QUERY STRING IS:"${QUERY_STRING_POST}"
## set up new  search keys using arguments input in form
if [ "$pattern" != "" ]; then
    newkeys=$key" "$tag" "$pattern
else
   newkeys=$key
fi
## submit="${submit}"
if [ "$submit" = "play" ]; then CMD="mpc toggle" 
fi
if [ "$submit" = "shuffle" ]; then CMD="mpc shuffle" 
fi
if [ "$submit" = "next" ]; then CMD="mpc next" 
fi
if [ "$submit" = "clear" ]; then CMD="mpc clear" 
fi
if [ "$submit" = "submit" ]; then CMD="search" 
fi
if [ "$submit" = "volup" ]; then CMD="volume" DIR="up" 
fi
if [ "$submit" = "voldown" ]; then CMD="volume" DIR="down" 
fi
if [ "$submit" = "list" ]; then
   CMD="echo 'Tag:'$tag';<br>'; mpc list "$tag"|/bin/busybox sort | /bin/busybox sed 's/$/<br>/g'"
   fi
if [ "$submit" = "add" ]; then
   CMD='mpc search '$key' | mpc add'
   newkeys=""
   fi
if [ "$submit" = "reset" ]; then
   newkeys=""
   CMD=""
   fi
## DEBUG echo CMD is $CMD
## if cmd is volume change, get volume status and adjust
if [ "$CMD" = "volume" ]; then
  VOL=`mpc volume | /bin/busybox sed 's/volume://g' | /bin/busybox sed 's/\%//g'` 
  if [ "$DIR" = "up" ]; then
    if [ "$VOL" -gt "86" ]; then
	  let VOL=100
    else
 	  let VOL+=13
    fi
  else ## volume request is "down"
    if [ "$VOL" -lt "15" ]; then
	let VOL=0
    else
	 let VOL-=15
    fi
  fi	
CMD='mpc volume '$VOL 
fi  
if [ "$CMD" = "search" ]; then
  CMD='mpc search '$newkeys" | /bin/busybox sed 's/$/<br>/g'"
fi
## display form html (closing html is left off, added after search key fields added)
/bin/busybox cat <<EOF
<html>
<head>
    <title>JUKEBOX MUSIC SELECTION</title>
<style>
div #panel1 { width: 48%; float: left; border: 1px solid; padding: 0px 2px 2px 5px; }
div #panel2 { width: 50%; float: right; border: 1px solid; padding: 0px 2px 2px 5px; }
media screen and (max-width: 1024px) { form,input,button { font-size: 24pt; } }
</style>
</head>
<body bgcolor=#bbbbee >
<div style="font-family: Arial, Helvetica, sans-serif; font-size: medium; ">
   	<div>
              <h1> SELECT and PLAY MUSIC</h1>
	</div>
   <hr />
<form action="http://${HTTP_HOST}${SCRIPT_NAME}" method="POST">
       <strong > SELECT  </strong>
         Search Tag  <select  name="tag">
		<option>Artist</option>
		<option>Genre</option>
		<option value="Title">Song</option>
	   	<option value="Album">Type</option>
            </select>
<button name="submit" type="submit" value="list">list</button>
	Search Text  <input name="pattern" type="text" />
	<input name="submit" type="submit" value="submit" />
<hr />
current keys  <input name="key"  type="text"
 size="40" readonly="true" value ="$newkeys"/>
<button name="submit" type="submit" value="add">add to playlist</button>
<button name="submit" type="submit" value="reset">clear</button>
<hr>
<strong> PLAY  </strong>
<button name="submit" type="submit" value="shuffle">shuffle</button>
<button name="submit" type="submit" value="prev" alt="back"><<</button>
<button name="submit" type="submit" value="play" alt="play/stop"> > ||</button>
<button name="submit" type="submit" value="next" alt="next">>></button>
<button name="submit" type="submit" value="voldown" alt="vol -">vol -</button>
<button name="submit" type="submit" value="volup" alt="vol +">vol +</button>
<button name="submit" type="submit" value="clear">clear</button>
</form>
<div id="panel1"><h3>SELECTION</h3>
EOF
## echo 'CMD: '$CMD
if [ "$CMD" != "" ]; then
  eval $CMD
fi
echo '</div>'
echo '<div id="panel2"><h3>PLAYLIST</h3>'
mpc playlist | /bin/busybox sed 's/$/<br>/g'
echo '</div></div></body></html>'

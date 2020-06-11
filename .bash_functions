# vim:ft=sh

cd+ () {
    # "cd PLUS" - mkdir, cd, and ls in one command!
    # - cd into a directory and list its contents in one step
    # - create a directory then cd into it in one step
    # - truncate ls output
    # - customize with $CDPLUS_LSCMD, $CDPLUS_LIMIT and $CDPLUS_MSG in .bashrc, eg:
    #
    #       # use tree-style directory listing
    #       CDPLUS_LSCMD='tree -C -L 1 --noreport' 
    #
    #       # show file sizes, largest first
    #       CDPLUS_ALTCMD() { find "$1" -maxdepth 1 -exec du -hs \; | sort -rh ; }
    #       CDPLUS_LSCMD='CDPLUS_ALTCMD' 
    #
    #       # display contents of a readme.txt instead of directory contents, if one exists
    #       CDPLUS_MSG="more lines"
    #       CDPLUS_ALTCMD() { [[ -f "$1"/readme.txt ]] && cat "$1"/readme.txt ; }
    #       CDPLUS_LSCMD='CDPLUS_ALTCMD' 

    dest="${@:-$HOME}"
    lscmd="${CDPLUS_LSCMD:-"ls --color=always --group-directories-first"}"
    limit="${CDPLUS_LIMIT:-20}"
    messg="${CDPLUS_MSG:-"more files"}"
    
    if [ $limit -ne 0 ]; then
        if [ -e "$dest" ]; then
            contents="$($lscmd "$dest")"
            length="$(echo "$contents" | wc -l)"
            remain="$(echo "$contents" | tail -n +$limit | wc -l)"
            if [ $length -ge $limit ]; then
                echo "$contents" | head -n $limit
                echo "--- $remain $messg ---"
            elif [ ! -z "$contents" ]; then
                echo "$contents"
            fi
        fi
    fi

    # make the directory if it doesn't exist
    if [ "$dest" != "-" ]; then
        mkdir -pv "$dest"
    fi

    \cd "$dest"
}

filter() {
	# Searches for files in PATH, that match the regexes in PATTERN_FILE,
    # can refine the search further by supplying non-regex PATTERN
    #
	# Usage:
	# filter PATH PATTERN_FILE [ PATTERN ] 
    #
	# Examples:
	# filter  /media/Backup $videos "python"               # export videos="~/.filter_patterns/vids.txt"
	#
	# The file "~/vids.txt" may contain regular expressions that match most video
    # filename extensions (mp4,mkv,avi,etc.)
	
	find -L "$1" -type f \
	| grep -i -f "$2" \
	| grep -i -F "$3"
}

nth() {
	# Displays the nth line of a file or standard input
	# Usage: nth NUM [ FILE ]
    #	
    # Examples:
    # nth 15 ~/.bashrc | bash                              # execute a single line of a script

	tail -n+$1 $2 | head -n1				               # fastest solution
}

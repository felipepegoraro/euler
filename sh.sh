#!/usr/bin/env bash

# AUTHOR: Felipe Pegoraro
# GITHUB: github.com/felipepegoraro/euler
# LAST UPDATE: 24/06/2022

endc=$(tput sgr0)
green=$(tput setaf 2)
red=$(tput setaf 1)

_add(){
	sed -i '1{s|```$|!\[img\](https://projecteuler.net/themes/logo_default.png)\n```|}' README.md

	# experimental ====================================================
	for i in $(ls -1 ./src | grep -oP "^[\d]*" | uniq -d); do 
		for x in $(ls -1 ./src/${i}.* | sed -r 's/^(.*)\.(.*)$/\2/'); do
			sed -i -E "s/^(${i} : .* : \[[^$x]\])/\1[$x]]-/" README.md
			sed -i -E "s/^(${i}.*)]].*/\1]/" README.md
		done
	done  
	# TODO ============================================================

	while read -r filename; do
		if [ ! $(grep -o "${filename%.*}" README.md) ]; then 
			sed -i "/^????/ {
			s/????/${filename%.*}/
			s/\[?\]/\[${filename#*\.}\]/
		}" README.md

			date=$(date +%d/%m/%y)
			sed -i -E "s|([0-9]+ : )(\?\?\/\?\?\/\?\?)( : \[.*\])|\1${date//\//\/}\3|" README.md
			sed -i '/``` /d' README.md
			echo '``` ' >> README.md
			echo '``` ' >> README.md
			printf "???? : ??/??/?? : [?]\n" >> README.md
			echo '``` ' >> README.md
		fi
	done <<< $(ls  ./src) 
}

_list(){
	printf "\n  CODE |   DAY\n  -----+---------\n"
	while read -r dates; do
		# printf "%s\n" "$dates"
		sed -E 's/:/|/;s/^/  /' <<< "$dates"
	done <<< $(grep -Po "[0-9]+\s:\s.*(?=:)" README.md)

	printf "\n"
	return 0
}

_compile(){
	printf "\n"

	for i in $(
		awk -F' :' '/^[0-9]{4}/ {
				print $1".c"
			}' README.md )
	do
		printf " %s[+]%s gcc -o bin/%s src/%s\n" "$green" "$endc" "${i%.c}" "$i"
		gcc -o bin/${i%.c} src/${i} 2>&-

		if [ $? != 0 ]; then 
			printf "\n %s[-]%s error.: %s" "$red" "$endc"  "$i"
			printf "\n %s[-]%s delete? (Y/n): " "$red" "$endc" 
			read -r reply 

			if [[ "$reply" =~ [y,Y,s,S] ]]; then 
				sed -i "/^${i%.*}/d" README.md
				printf "\n"
			else 
				printf " %s[-]%s ignoring file: %s\n\n" "$red" "$endc" "${i}"  
			fi
		fi
	done

	printf "\n %s[+]%s compile process: finished\n\n" "$green" "$endc"
	return 0
}


_help(){
	printf "%s  SCRIPT %s
\tcompile, list, add files 
\tlisted in README.md ...
  
%s  SYNOPSIS %s
\t./sh.sh [options] 
  
%s  OPTIONS %s
\t-a  Add file from 'src/' in 'README.md'
\t-c	Compile all files in 'src/' to 'bin/'
\t-l	Listing
\t-h	Show this Help
" "$green" "$endc" "$green" "$endc" "$green" "$endc"
}

for arg in "$@"; do 
	case "$arg" in 
		-a) _add;;
		-c) _compile;;
		-l) _list;;
		-h|--help) _help;;
	esac
done

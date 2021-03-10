#!/bin/bash

# Interpret $BASH parameters
options=':o:h'
while getopts $options option
do
    case $option in
        o ) outdir=$OPTARG
            outdir="${outdir}"
            ;;
        h ) echo " "
            echo "GuildWars2.sh, a script to get loading screen images from GuildWars2."
            echo "Part of BackgroundGrabber."
            echo " "
            echo "The Script options are as follows:"
            echo " "
            echo "  -h    Displays this help message"
            echo "  -o    Output directory that images must be put into"
            echo " "
            exit 0
            ;;  
        \?) echo "Unknown option: -$OPTARG" >&2; exit 1;;
        : ) echo "Missing option argument for -$OPTARG" >&2; exit 1;;
        * ) echo "Unimplemented option: -$OPTARG" >&2; exit 1;;
    esac
done

# Get webpage with all background image links
wget -O list https://wiki.guildwars2.com/wiki/Category:Loading_screen_images

# Get list of background image links
grep -o 'href="/wiki/File.*\.jpg"' list | cut -d ' ' -f 1 | uniq | cut -c 18- | rev | cut -c 2- | rev > listlinks

while read imagename; do
  wget -O temp "https://wiki.guildwars2.com/wiki/File:${imagename}"
  correctpath=$(grep "Original file" temp | cut -c 36- | cut -d " " -f 1 | rev | cut -c 2- | rev)
  wget -O "${outdir}${imagename}" "https://wiki.guildwars2.com${correctpath}"
done < listlinks

rm list listlinks temp

#!/bin/bash

# Interpret $BASH parameters
options=':o:s:h'
while getopts $options option
do
    case $option in
        o ) OutDir=$OPTARG
            OutDir="${OutDir}"
            ;;
        s ) ImgSource=$OPTARG
            ImgSource="${ImgSource}"
            ;;
        h ) echo " "
            echo "MeasurePerformance, a script to measure performance metrics of a script or unix command."
            echo " "
            echo "The Script options are as follows:"
            echo " "
            echo "  -h    Displays this help message"
            echo "  -o    Output directory that images must be put into"
            echo "  -s    Source to get backgrounds from. Working options are 'ElderScrollsOnline', 'GuildWars2'"
            echo " "
            exit 0
            ;;  
        \?) echo "Unknown option: -$OPTARG" >&2; exit 1;;
        : ) echo "Missing option argument for -$OPTARG" >&2; exit 1;;
        * ) echo "Unimplemented option: -$OPTARG" >&2; exit 1;;
    esac
done


# Create OutDir
echo "Ensuring that output directory exist..."
if [ -d $OutDir ]; then
    echo "Output directory exists"
else
    echo "Output directory does not exists, creating path..."
    mkdir -p $OutDir
    echo "Path to output directory created"
fi

# Run Correct Command
if [ $ImgSource = "ElderScrollsOnline" ]; then
    bash scripts/ElderScrollsOnline.sh -o $OutDir
fi

if [ $ImgSource = "GuildWars2" ]; then
    bash scripts/GuildWars2.sh -o $OutDir
fi
#!/bin/bash
#By Vincent Lee / vlee489
#(c) of Vincent Lee 2015
#See LICENSE file for copyright and license details
#The Nexus is made for the SuperNinja Network

#The Nexus
#Versions 2.0

#Constants
#------------------------
BuildToolDownload="https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar"
BuildToolName="BuildTool.jar"
FolderName="BuildTool"
GitPrerequisites="git"
JavaPrerequisites="openjdk-7-jre-headless"
TarPrerequisites="tar"
CurlPrerequisites="curl"
#------------------------

while test $# -gt 0; do
        case "$1" in
                -h|--help)
                        echo "The Nexus Updater 2.0"
                        echo "options:"
                        echo "-h, --help                show brief help"
                        echo "-install | -i             Install the updater's prerequisities"
                        echo "-update  | -u             Update the prerequisities and BuildTool"
                        echo "-build   | -b             Build Spigot/Bukkit/CraftBukkit"
                        exit 0
                        ;;
       -update|-u)
                        echo "This update will delete all of the build tool and it's contents!"
                        echo "You have 3 SECONDS to cancel this with CTRL+C"
                        sleep 3
                        echo "updating prerequisities via apt-get"
                        apt-get update && apt-get upgrade -y
                        echo "Deleting BuildTool Folder!"
                        rm -rf $FolderName
                        echo "Rebuilding folder and Downloading Build tool!"
                        mkdir $FolderName
                        curl -o $BuildToolDownload
                        ;;
      -install|-i)
                       echo "Installing prerequisities via apt-get"
                       apt-get update && apt-get upgrade -y
                       apt-get install -y $GitPrerequisites $JavaPrerequisites $TarPrerequisites $CurlPrerequisites
                       mkdir BuildTool
                       cd $FolderName
                       curl -o $BuildToolDownload#
                       ;;
        -build|-b)
                       echo "Running main build tool"
                       cd $FolderName
                       git config --global --unset core.autocrlf
                       java -jar BuildTools.jar --rev latest
                       ;;
                *)
                        break
                        ;;
        esac
done
#!/bin/bash
# Fatkus Kusuma
# Email Validator_Version2 v2
# By Fatkus Kusuma Kusuma
# Thanks To Malhadi Jr
# 24 April 2018

RED='\033[0;31m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
ORANGE='\033[0;33m' 
PUR='\033[0;35m'
GRN="\e[32m"
WHI="\e[37m"
NC='\033[0m'
echo ""

printf "$RED                ################    $GRN#####\n"
printf "$RED                ###############    $GRN######\n"
printf "$RED                ##############    $GRN#######\n"
printf "$RED                ####             $GRN########\n"
printf "$RED                ####            $GRN#########\n"
printf "$RED                ###########    #$GRN###  ####\n"
printf "$RED                ###########   ##$GRN##   ####\n"
printf "$RED                ####          ##$GRN##   ####\n"
printf "$RED                ####    ###    #$GRN#########\n"
printf "$RED                ####    ####    $GRN##   ####\n"
printf "$RED                ####    #####    $GRN#   ####\n"
printf "$RED                #################$GRN########\n"
printf "$RED                #################$GRN########\n"
printf "$RED                #################$GRN########\n"
cat <<EOF
              - https://fatkus.org -
           [+] Fattahkus Kusuma Kusuma [+]
        
--------------------------------------------------------
         Fatkus Kusuma - Email Validator_Version2 2018
--------------------------------------------------------

EOF

# Assign the arguments for each
# parameter to global variable
while getopts ":i:r:l:t:dchu" o; do
    case "${o}" in
        i)
            inputFile=${OPTARG}
            ;;
        r)
            targetFolder=${OPTARG}
            ;;
        l)
            sendList=${OPTARG}
            ;;
        t)
            perSec=${OPTARG}
            ;;
        d)
            isDel='y'
            ;;
        c)
            isCompress='y'
            ;;
        h)
            usage
            ;;
        u)
            updater "manual"
            ;;
    esac
done

# Do automatic update
# before passing arguments
# echo "[+] Doing an automatic update from server slackerc0de.us on `date`"
# updater "auto"


if [[ $inputFile == '' || $targetFolder == '' || $sendList == '' || $perSec == '' ]]; then
  cli_mode="interactive"
else
  cli_mode="interpreter"
fi

# Assign false value boolean
# to both options when its null
if [ -z "${isDel}" ]; then
  isDel='n'
fi

if [ -z "${isCompress}" ]; then
  isCompress='n'
fi

SECONDS=0

# Asking user whenever the
# parameter is blank or null
if [[ $inputFile == '' ]]; then
  # Print available file on
  # current folder
  # clear
  tree
  read -p "Enter mailist file: " inputFile
fi

if [[ $targetFolder == '' ]]; then
  read -p "Enter target folder: " targetFolder
  # Check if result folder exists
  # then create if it didn't
  if [[ ! -d "$targetFolder" ]]; then
    echo "[+] Creating $targetFolder/ folder"
    mkdir $targetFolder
  else
    read -p "$targetFolder/ folder are exists, append to them ? [y/n]: " isAppend
    if [[ $isAppend == 'n' ]]; then
      exit
    fi
  fi
else
  if [[ ! -d "$targetFolder" ]]; then
    echo "[+] Creating $targetFolder/ folder"
    mkdir $targetFolder
  fi
fi

if [[ $isDel == '' || $cli_mode == 'interactive' ]]; then
  read -p "Delete list per check ? [y/n]: " isDel
fi

if [[ $isCompress == '' || $cli_mode == 'interactive' ]]; then
  read -p "Compress the result ? [y/n]: " isCompress
fi

if [[ $sendList == '' ]]; then
  read -p "How many list send: " sendList
fi

if [[ $perSec == '' ]]; then
  read -p "Delay time: " perSec
fi


urlencode() {
    # urlencode <string>

    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf "$c" ;;
            *) printf '%s' "$c" | xxd -p -c1 |
                   while read c; do printf '%%%s' "$c"; done ;;
        esac
    done
}


fatkus_request() {
  # Regular Colors
  BLACK='\033[0;30m'        
  RED='\033[0;31m' 
  GREEN='\033[0;32m'
  YELLOW='\033[0;33m'       
  BLUE='\033[0;34m'         
  PURPLE='\033[0;35m'       
  CYAN='\033[0;36m'   
  NC='\033[0m'  

  # Bold
  BBlack='\033[1;30m'       
  BRed='\033[1;31m'         
  BGreen='\033[1;32m'       
  BYellow='\033[1;33m'      
  BBlue='\033[1;34m'        
  BPurple='\033[1;35m'      
  BCyan='\033[1;36m'        

  # Underline
  UBlack='\033[4;30m'      
  URed='\033[4;31m'         
  UGreen='\033[4;32m'      
  UYellow='\033[4;33m'     
  UBlue='\033[4;34m'        
  UPurple='\033[4;35m'     
  UCyan='\033[4;36m'      

  # Background
  On_Black='\033[40m'      
  On_Red='\033[41m'        
  On_Green='\033[42m'      
  On_Yellow='\033[43m'     
  On_Blue='\033[44m'        
  On_Purple='\033[45m'     
  On_Cyan='\033[46m'       

  # High Intensty
  IBlack='\033[0;90m'      
  IRed='\033[0;91m'       
  IGreen='\033[0;92m'
  IYellow='\033[0;93m'
  IBlue='\033[0;94m'
  IPurple='\033[0;95m'
  ICyan='\033[0;96m'

  # Bold High Intensty
  BIBlack='\033[1;90m'
  BIRed='\033[1;91m'
  BIGreen='\033[1;92m'
  BIYellow='\033[1;93m'
  BIBlue='\033[1;94m'
  BIPurple='\033[1;95m'
  BICyan='\033[1;96m'

  # High Intensty backgrounds
  On_IBlack='\033[0;100m'
  On_IRed='\033[0;101m'
  On_IGreen='\033[0;102m'
  On_IYellow='\033[0;103m'
  On_IBlue='\033[0;104m'
  On_IPurple='\033[10;95m'
  On_ICyan='\033[0;106m'

  SECONDS=0

  # echo "$1 => $csrf | $nsid"

  posted=`curl 'http://api.neverbounce.com/v4/single/check?key=secret_5c76002cdac1263ab7071401765698fd&email='$1'' -H 'Connection: keep-alive' -H 'Cache-Control: max-age=0' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.170 Safari/537.36 OPR/53.0.2907.57' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: en-US,en;q=0.9' -H 'Cookie: _ga=GA1.2.1877493556.1526867253; _gid=GA1.2.394819861.1526867253; __qca=P0-694611553-1526867257473; __idcontext={"deviceID":"14tW97qEo91iO881J7CooPQYnE4","cookieID":"14tW97RoCLoJKP6z38Ft78wlX3a"}; __zlcmid=mWhM8ONOyOSVna' --compressed -D - -s -L`
  duration=$SECONDS

  dead="$(echo "$posted" | grep -c 'result":"invalid')"
  live="$(echo "$posted" | grep -c 'result":"valid')"

  header="${UYellow}`date +%H:%M:%S` from ${URed}$inputFile ${BIGreen}to ${BCyan}$targetFolder"
  footer="[Fatkus Kusuma - Email Validator_Version2 V-1.2] $(($duration % 60))sec.\n"

  if [[ $dead == 1 ]]; then
    printf "[$header] ${BIPurple}$2/$3. ${BIYellow}DIE => $1 ${NC} $footer"
    echo "$1" >> $4/die.txt
  else
    if [[ $live > 0 ]]; then
      printf "[$header] ${BIPurple}$2/$3. ${On_Cyan}LIVE => $1 ${NC} $footer"
      echo "$1" >> $4/live.txt
    else
      printf "[$header] ${BIPurple}$2/$3. ${BIRed}UNKNOWN => $1 ${NC} $footer"
      echo "$1" >> $4/unknown.txt
      echo "$posted" >> $4/reason.txt
    fi
  fi

  # rm -f $1.html

  printf "\r"
}

if [[ ! -f $inputFile ]]; then
  echo "[404] File mailist not found. Check your mailist file name."
  ls -l
  exit
fi

# Preparing file list 
# by using email pattern 
# every line in $inputFile
echo "[+] Cleaning your mailist file"
grep -Eiorh '([[:alnum:]_.-]+@[[:alnum:]_.-]+?\.[[:alpha:].]{2,6})' $inputFile | tr '[:upper:]' '[:lower:]' | sort | uniq > temp_list && mv temp_list $inputFile

# Finding match mail provider
echo "########################################"
# Print total line of mailist
totalLines=`grep -c "@" $inputFile`
echo "There are $totalLines of list."
echo " "
echo "hotmail: `grep -c "@hotmail" $inputFile`"
echo "live: `grep -c "@live" $inputFile`"
echo "msn: `grep -c "@msn" $inputFile`"
echo "outlook: `grep -c "@outlook" $inputFile`"
echo "Yahoo: `grep -c "@yahoo" $inputFile`"
echo "Gmail: `grep -c "@gmail" $inputFile`"
echo "Aol: `grep -c "@aol" $inputFile`"
echo "########################################"

# Extract email per line
# from both input file
IFS=$'\r\n' GLOBIGNORE='*' command eval  'mailist=($(cat $inputFile))'
con=1

echo "[+] Sending $sendList email per $perSec seconds"

for (( i = 0; i < "${#mailist[@]}"; i++ )); do
  username="${mailist[$i]}"
  indexer=$((con++))
  tot=$((totalLines--))
  fold=`expr $i % $sendList`
  if [[ $fold == 0 && $i > 0 ]]; then
    header="`date +%H:%M:%S`"
    duration=$SECONDS
    echo "Waiting $perSec seconds. $(($duration / 3600)) hours $(($duration / 60 % 60)) minutes and $(($duration % 60)) seconds elapsed, ratio $sendList email / $perSec seconds"
    sleep $perSec
  fi
  vander=`expr $i % 8`
  # if [[ -f $targetFolder/unknown.txt ]]; then
  #   echo "Token expired. Waiting last request done..."
  #   wait
  #   sleep 1
  #   get_token
  #   sleep 2
  #   rm -f $targetFolder/unknown.txt
  # fi
  
  fatkus_request "$username" "$indexer" "$tot" "$targetFolder" "$inputFile" &

  if [[ $isDel == 'y' ]]; then
    grep -v -- "$username" $inputFile > "$inputFile"_temp && mv "$inputFile"_temp $inputFile
  fi
done 

# waiting the background process to be done
# then checking list from garbage collector
# located on $targetFolder/unknown.txt
echo "[+] Waiting background process to be done"
wait
wc -l $targetFolder/*

if [[ $isCompress == 'y' ]]; then
  tgl=`date`
  tgl=${tgl// /-}
  zipped="$targetFolder-$tgl.zip"

  echo "[+] Compressing result"
  zip -r "compressed/$zipped" "$targetFolder/die.txt" "$targetFolder/live.txt" "$targetFolder/limited.txt"
  echo "[+] Saved to compressed/$zipped"
  mv $targetFolder haschecked
  echo "[+] $targetFolder has been moved to haschecked/"
fi
#rm $inputFile
duration=$SECONDS
echo "Checking done in $(($duration / 3600)) hours $(($duration / 60 % 60)) minutes and $(($duration % 60)) seconds."
echo "+==========+ Fatkus Kusuma Family - Email Validator_Version2 - By Fatkus Kusuma Kusuma +==========+"

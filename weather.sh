#!/bin/bash

#Mini database json
data='[{"bandung":"208977","banten":"688288","depok":"202649","medan":"3237599","manokwari":"205479"}]'

#Input location
echo -e "Indexed city:\n-Bandung\n-Banten\n-Depok\n-Medan\n-Manokwari"
read -p 'Input Location: ' area

#Parsing data json
filterkodearea=$(echo ${data} |  jq ".[].$area")
kodearea=$(echo $filterkodearea | awk '{gsub("\"", "");print}') #Delete unnecessary 1

suhuraw=$(curl -i -s -k -X $'GET' -H $'Host: www.accuweather.com' -H $'User-Agent: Don\'t worry, i\'am good guy ...' $'https://www.accuweather.com/en/id/${area}/${kodearea}/weather-forecast/${kodearea}' | grep recentLocations) #Unduh json
suhuparsing1=$(echo $suhuraw | awk '{gsub("var recentLocations = ", "");print}') #Delete unnecessary 2
suhuparsing2=$(echo $suhuparsing1 | awk '{gsub(";", "");print}') #Delete unnecessary 3
echo "----------------------------------------------"
echo -e "Simple Weather Forecast\n"
echo $suhuparsing2 | jq ".[].localizedName" #View area
echo $suhuparsing2 | jq ".[].temp" #View temperature
echo "----------------------------------------------"

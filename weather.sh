#!/bin/bash

#Mini database json
data='[{"bandung":"208977","banten":"688288","depok":"202649","medan":"3237599","manokwari":"205479"}]'

#Masukan lokasi
echo -e "Kota yang baru bisa ter-index adalah:\n-Bandung\n-Banten\n-Depok\n-Medan\n-Manokwari"
read -p 'Masukan Lokasi: ' area

#Parsing data json
filterkodearea=$(echo ${data} |  jq ".[].$area")
kodearea=$(echo $filterkodearea | awk '{gsub("\"", "");print}') #Hapus kalimat yang tidak perlu 3

suhuraw=$(curl -i -s -k -X $'GET' -H $'Host: www.accuweather.com' -H $'User-Agent: Don\'t worry, i\'am good guy ...' $'https://www.accuweather.com/en/id/${area}/${kodearea}/weather-forecast/${kodearea}' | grep recentLocations) #Unduh json
suhuparsing1=$(echo $suhuraw | awk '{gsub("var recentLocations = ", "");print}') #Hapus kalimat yang tidak perlu 1
suhuparsing2=$(echo $suhuparsing1 | awk '{gsub(";", "");print}') #Hapus kalimat yang tidak perlu 2
echo "----------------------------------------------"
echo -e "Laporan Cuaca Sederhana\n"
echo $suhuparsing2 | jq ".[].localizedName" #Tampilkan area
echo $suhuparsing2 | jq ".[].temp" #Tampilkan suhu
echo "----------------------------------------------"

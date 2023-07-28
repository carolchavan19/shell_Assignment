#!/bin/bash
verify_opt() {
    case $1 in
        INGESTOR|JOINER|WRANGLER|VALIDATOR)
            return 0;;
	MID|HIGH|LOW)
            return 0;;
	Auction|Bid)
	    return 0;;
	[0-9])
	    return 0;;
	*)
	  echo "invalid output"
	    exit;;
esac
}	

while true; do
	echo "Enter the value from the choices given below"
	read -p "Component Name [INGESTOR/JOINER/WRANGLER/VALIDATOR]: " name
	verify_opt "$name" 
	read -p "Scale [MID/HIGH/LOW]: " scale
	verify_opt  "$scale"
	read -p "View [Auction/Bid]: " view
	verify_opt  "$view"
	read -p "Count [single digit number]: " count
	verify_opt  "$count"
	
    if [ "$view" = "Auction" ]; then
        sudo sed -i '1s/.*/'"$view; $scale; $name;ETL; vdopiasample=$count"'/' /etc/shellscrip.conf
    else
        sudo sed -i '2s/.*/'"$view; $scale; $name;ETL; vdopiasample-bid=$count"'/' /etc/shellscrip.conf
    fi

    echo " conf file updated successfully."
    break
done

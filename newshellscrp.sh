#!/bin/bash
verify_name() {
    case $1 in
        INGESTOR|JOINER|WRANGLER|VALIDATOR)
            return 0;;
	[0-9]*)  
          echo "Please enter a string."
	   exit;;
        *)
          echo "invalid input"
            exit;;
esac
}
	
verify_scale() {
    case $1 in
        MID|HIGH|LOW)
            return 0;;
	[0-9]*)
          echo "Please enter a string ."
           exit;;
	*)
          echo "invalid input"
            exit;;
esac
}

verify_view() {
    case $1 in
        Auction|Bid)
            return 0;;
	[0-9]*)  
          echo "Please enter a string ."
	   exit;;
        *)
          echo "invalid input"
            exit;;
esac
}

verify_count() {
    case $1 in
        [0-9])
            return 0;;
        *)
          echo "Invalid input. Please enter a number between 0 and 9"
            exit;;
esac
}


while true; do
	echo "Enter the value from the choices given below"
	read -p "Component Name [INGESTOR/JOINER/WRANGLER/VALIDATOR]: " name
	name1=$(echo "$name" | tr '[:lower:]' '[:upper:]')
	verify_name "$name1"
 
	read -p "Scale [MID/HIGH/LOW]: " scale
	scale1=$(echo "$scale" | tr '[:lower:]' '[:upper:]')
	verify_scale  "$scale1"

	read -p "View [Auction/Bid]: " view
	view1=$(echo "$view" | awk '{print toupper(substr($0, 1, 1)) tolower(substr($0, 2))}')
	verify_view  "$view1"

	read -p "Count [single digit number]: " count
	verify_count  "$count"
	
    if [ "$view1" = "Auction" ]; then
        sudo sed -i '1s/.*/'"$view1; $scale1; $name1;ETL; vdopiasample=$count"'/' /etc/shellscrip.conf
    else
        sudo sed -i '2s/.*/'"$view1; $scale1; $name1;ETL; vdopiasample-bid=$count"'/' /etc/shellscrip.conf
    fi

    echo " conf file updated successfully."
    break
done

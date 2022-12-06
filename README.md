If you use rsync on a regular basis to sync between computers or to flash drives or hard disks, this script can help.

# How it works
- First you define your locations in the `locations.csv` file.
  + A name for each location and device, and the path for that location.
- Contents of `locations.csv`
  + The first row is a header. You can add the name of your devices here from the second column onwards.
  + From the second row onwards, give each location a name in the first column, and then its full path from the second column onwards.
  + Put the path in the right column below your devices. Leave the others blank.
  + Since rsync works over the network, you can provide the path with the username and ipaddress/hostname too. See `locations.csv` for examples.

# Onlinetest
This is a 3 tier environment. 

Web server:
1. There is one Webserver which is public facing
2. It can accept traffic over http port 80. NSG rules to allow traffic on port 80 is added.

App server:
1. There is one App server which is in private zone 
2. It has an NSG attached to deny traffic from external sources over port 80
3. An NSG rule that allows traffic between Vnets is added
3. It hosts the DB that is also in the private zone and cannot be accessed publicly

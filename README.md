# Kung Flu
This is a small-scale game effort intended to develop a process and get back into the swing of game development in a way that can involve the whole group.

## Basic Overview
You play as a white blood cell. Your job is to destroy bacteria while avoiding viruses. You move to dodge and enlarge yourself to envelop and devour bacteria.

# Dev Guide

## ServerProperties
This project is implemented with a server-controlled architecture so that group play sessions can dynamically respond to feedback and game properties can be changed on the fly in order to achieve the best game feel in the most effecient timeframe possible. To do this, the ServerProperties node is utilized that is synced across all clients via a MultiplayerSynchronizer. Each game client then references the ServerProperties node for its values.

### How to add a server property
1. Open the `server_properties.gd` file
2. Add an `export` variable, with a pascale-case title (like camelcase but first letter is capatalized too)
   - Give it a logical default value
![image](https://github.com/user-attachments/assets/66ec4894-981e-45bd-b93f-4673b3b0b9cb)
3. Open the `server_properties.tcsn` scene file
4. Click on the **MultiplayerSynchronizer**
5. Click the **Add property to sync...** button
![image](https://github.com/user-attachments/assets/7a84521f-2ccd-4ad5-a057-9c408aa5d514)
6. On the Pick a node to synchronize dialog, double-click the **ServerProperties** node
7. Under Matches, select the new server property you just added
![image](https://github.com/user-attachments/assets/24ad19e6-e548-46a7-9611-e95b7d1ae1b1)
8. Click **Open**

#!/bin/bash

clear
echo "======================================"
echo "     MINI LINUX PROCESS MANAGER"
echo "======================================"
echo ""
echo "This project demonstrates how the Linux"
echo "kernel manages processes using live"
echo "implementations."
echo ""

while true
do
    echo "------------ MENU ------------"
    echo "1. Create background process"
    echo "2. List running processes"
    echo "3. Show process states"
    echo "4. Show process tree"
    echo "5. Kill a process"
    echo "6. Demonstrate CPU scheduling"
    echo "7. Demonstrate zombie process"
    echo "8. Exit"
    echo "------------------------------"
    read -p "Enter your choice: " choice

    case $choice in
        1)
   echo "Creating a background process..."
   sleep 60 &
   pid=$!
   echo "Process created successfully!"
   echo "PID  : $pid"
   echo "PPID : $$"
   ;;

        2)
   echo "Listing running processes (PID | PPID | USER | COMMAND)"
   echo "------------------------------------------------------"
   ps -eo pid,ppid,user,comm --sort=pid | head -15
   ;;

        3)
   read -p "Enter PID to check state (or press Enter to see top processes): " pid
   if [ -z "$pid" ]; then
       echo "Showing first 10 processes and their states..."
       ps -eo pid,ppid,state,comm | head -10
   else
       # Fetch the output for the given PID
       output=$(ps -o pid,ppid,state,comm -p $pid)
       
       # Check if process exists
       if [ "$(echo "$output" | wc -l)" -le 1 ]; then
           echo "PID $pid does not exist or has already finished."
       else
           echo "$output"
       fi
   fi
   ;;


        4)
   read -p "Enter PID to show process tree (or press Enter for full tree): " pid
   if [ -z "$pid" ]; then
       echo "Full process tree:"
       pstree -A -p | head -20
   else
       # Check if PID exists first
       if ps -p $pid > /dev/null 2>&1; then
           echo "Process tree for PID $pid:"
           pstree -A -p $pid
       else
           echo "PID $pid does not exist."
       fi
   fi
   ;;

        5)
   read -p "Enter PID to terminate (must be your process): " pid
   # Check if PID exists and belongs to current user
   if ps -p $pid -o user= | grep -qw $USER; then
       kill $pid 2>/dev/null
       sleep 1
       if ps -p $pid > /dev/null 2>&1; then
           echo "Process $pid did not terminate, forcing termination..."
           kill -9 $pid
           sleep 1
       fi
       if ps -p $pid > /dev/null 2>&1; then
           echo "Failed to terminate process $pid."
       else
           echo "Process $pid terminated successfully."
       fi
   else
       echo "Cannot terminate PID $pid (does not exist or owned by another user)."
   fi
   ;;


        6)
   echo "Demonstrating CPU scheduling with multiple processes..."
   
   # Create 3 CPU-intensive background processes
   yes > /dev/null &
   pid1=$!
   yes > /dev/null &
   pid2=$!
   yes > /dev/null &
   pid3=$!
   
   echo "Created 3 CPU-intensive processes:"
   echo "PID1: $pid1  PID2: $pid2  PID3: $pid3"
   
   echo "Observing CPU usage for 5 seconds..."
   sleep 2
   top -b -n1 | head -15
   
   # Terminate the processes to clean up
   kill -9 $pid1 $pid2 $pid3 2>/dev/null
   echo "CPU-intensive processes terminated."
   ;;

        7)
   echo "Demonstrating Zombie Process..."
   
   # Create a child process that exits immediately
   ( exit 0 ) &
   child_pid=$!
   
   echo "Child process created with PID: $child_pid"
   sleep 1
   
   echo "Checking if it became a zombie..."
   ps -el | grep Z | grep $child_pid || echo "No zombie found (too fast)."
   
   echo "Parent process sleeping 5 seconds to allow zombie to appear..."
   sleep 5
   ps -el | grep Z | grep $child_pid || echo "Zombie may have already been cleaned up."
   
   ;;

        8) echo "Exiting project..."; exit;;
        *) echo "Invalid choice. Try again.";;
    esac

    echo ""
done


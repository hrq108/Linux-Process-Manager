# Linux Process Manager
This project demonstrates Linux process management using an interactive Bash script, showcasing how the Linux kernel creates, schedules, manages, and terminates processes.

## Project Overview
The program acts as a mini process manager, providing a menu-driven interface that allows users to create, monitor, and control processes in real time. Each option demonstrates a specific aspect of Linux process behavior using standard system utilities.

## Features

- Creation of background processes
- Listing running processes
- Display of process states
- Visualization of process hierarchy (process tree)
- Safe termination of processes
- CPU scheduling demonstration
- Zombie process demonstration

## Key Concepts Demonstrated

- Process creation and background execution
- Process ID (PID) and Parent Process ID (PPID)
- Linux process states (Running, Sleeping, Zombie, etc.)
- Parent–child process relationships
- Signal-based process termination (SIGTERM, SIGKILL)
- CPU scheduling and time-sharing
- Zombie processes and process lifecycle

## Technologies Used

- Bash Shell Scripting
- Linux Process Management Utilities (ps, pstree, top, kill)
- Linux / Ubuntu

## How to Run

chmod +x process_manager.sh
./process_manager.sh
or
bash process_manager.sh

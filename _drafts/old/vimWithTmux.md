---
layout: post
title: Vim with TMUX
comments: disqus
---

I wrote this set of instructions to help my fellow grad students in the AMS
department at UC - Santa Cruz better utilize the available resources in our
department. I have tried to make this tutorial general, but may at times
refer to resources (servers) specific to our department.

# Servers at UCSC
There are several Linux interactive servers available at UCSC. An interactive
server is a server (a huge computer) that you can log into and execute
commands, like you would on your local machine, in a terminal. 

(The biggest interactive servers at UCSC AMS are `jerez`, `mencia`, and
`muscat`.)

In order to efficiently use the resources on the Linux server, it helps to know
how to efficiently navigate a UNIX terminal. If you have a MAC or LINUX
machine, you have a UNIX terminal. If you have Windows 10, you can now access a
LINUX BASH shell natively.  Though the setup is quite straight-forward, it is
out of the scope of this post.

In this post, I will step you through the basics of how to navigate and execute
commands on a UNIX terminal. I will then show you how to do it on a server.
It's often good to start with the end in mind. So I'll start with a motivating
example.

# Motivating Example
Say you want to **run an R-script on an interactive server**. This is one
way you could do it:

1. Launch SFTP (secure file transfer protocol) to send / receive files from a server (say `jerez`)
   - `sftp myUserName@jerez.soe.ucsc.edu`
2. Send your script to the server
    - `put myFile.R`
3. Log on to the server
    - `ssh myUserName@jerez.soe.ucsc.edu`
4. Execute the command on your script
    - `Rscript myFile.R &`
    - Note here that the command `Rscript` acts on the script `myFile.R`.
    - The ampersand `&` at the end is optional. It allows you to execute
      your script "in the background". Meaning, you can do other things in
      your terminal after executing a command (e.g. `Rscript`). You can 
      even log off the server while the job runs. Without the ampersand, 
      you cannot use the terminal until the job is finished. If you
      exit the server before the job is done, your job stops and your
      results will not be saved. Therefore, add `&` at the end of your commands
      when you have long-running jobs.
    - Also, if you plan to run many jobs, you should add `nice` before your
      command. (e.g. `nice Rscript myFile.R &`) This basically prevents you
      from becoming a server hog who uses most of the resources on the server.
5. Send results back to your computer
    - `get myOutput.rda`

INSERT VIDEO HERE

# TMUX
TMUX is a terminal multiplexer.

# Vim
Vim is a text editor.


# Vim with TMUX

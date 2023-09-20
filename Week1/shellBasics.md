## Navigating Like a Tourist

+ __Imagine you're a tourist in a new city. You're exploring the city streets, visiting various landmarks, and you want to get around efficiently.__

1. _pwd_ - "Where Am I?": This command tells you where you are right now. It's like checking your GPS.
```pwd```

2. _ls_ - "What's Around Here?": Use this command to list the contents of your current location (directory). It's like looking at a map to see what's nearby.
```ls```

3. _cd_ - "Change Location": When you want to move to a new place (directory), use cd. It's like walking or taking a taxi to a new spot.
```cd /```

4. _.._ - "Up One Level": Just like going up a floor in a building, .. takes you one level up in the directory structure.
```cd ..```

5. _~_ - "Home Sweet Home": This tilde (~) represents your home directory. It's like always having a way to get back to your hotel.
```cd ~```


## Becoming a Local
+ __Now, you're more familiar with the city, and you want to explore like a local.__

6. _mkdir_ - "Build a House": Create a new directory, like building a new house in the city.
```mkdir myHome``` ```mkdir myNewHome``` 

7. _rmdir_ - "Demolish": Remove a directory when you're done with it. It's like tearing down an old building.
```rmdir myHome```

8. _cp_ - "Copy-Paste": Copy files or directories from one place to another, like making photocopies.
```cp source destination```

9. _mv_ - "Move": Move files or directories to a new location. Think of it as relocating your belongings.
```mv source destination```

10. _rm_ - "Delete": Delete files or directories. Imagine throwing away things you no longer need.
```rm file_or_directory```


## The Shell Ninja

+ __You've mastered the basics and now want to become a shell ninja.__

11. tab completion - "Autocomplete": Start typing a command or file path and press Tab. The shell will try to complete it for you, saving you time.
```cd my_looooong_directory_name # Instead of typing the whole name, press Tab after "my_"```  

12. "Time Machine": Use the up and down arrow keys to cycle through your command history. It's like time-traveling through your recent actions.

13. wildcards - "Jokers": Use wildcards like * (matches anything) and ? (matches a single character) to perform advanced searches.
```ls *.txt    # List all files ending with .txt```

14. _grep_ - "Search Master": Search for specific text within files. It's like having a super-powered magnifying glass.
```grep "search_term" file.txt```

15. pipes (|) - "Connect the Dots": Use pipes to connect commands, passing output from one as input to another. It's like building intricate machines.
command1 | command2

16. _touch_ - "Create Magic": Use the touch command to create empty files. It's like summoning a blank parchment for your spells.
```touch I_am_empty.txt```

17. _find_ - "Treasure Hunt": This command helps you search for files and directories deep within your computer. Think of it as a treasure map for your data.
```find /path/to/search -name "filename"```

Remember, the key to becoming a shell pro is practice. The more you navigate and play with these commands, the more comfortable you'll become. Soon, you'll be navigating your computer like a true _shell magician!_


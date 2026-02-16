## bash script
# Imperial Git Aliases
[alias]
    # "git rebellion" - Fetch all and prune dead branches (Crush the resistance)
    rebellion = fetch --all --prune
    
    # "git ignite" - Push to current branch (Fire when ready)
    ignite = push origin HEAD
    
    # "git clone-trooper" - Create a new branch from operational
    clone-trooper = checkout -b
    
    # "git blame-admiral" - Find out who wrote this failing code
    blame-admiral = blame

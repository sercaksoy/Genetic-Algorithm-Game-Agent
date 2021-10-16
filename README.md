# Genetic-Algorithm-Game-Agent

## About it
The hero, who is in the center of the square tries to survive from zombies which get close in waves to him, by shooting them.

Zombies can come from 8 directions. One unit per processing step they are also created one by one. It is not necessary to be created every step.

The hero can also shoot in same 8 directions also can choose not to shoot. He tries to kill from the farthest distance because the hero afraids of them. He does that trying to turn between smaller angles otherwise it may become difficult to aim. Also the hero tries to save as much as possible bullets for the next levels.

Zombies, if any, are moved one step closer to the hero first in each action step. Then a zombie waiting in line is created. The last hero is allowed to shoot. The first zombie found in the direction the hero shoots dies. 

## Fitness Functions
fitness1 : reduced bullets (trying to minimize)
fitness2 : total zombie closeness (trying to minimize)
fitness3 : how many degrees the hero rotates around (trying to minimize)

## Hyper Parameters
- Number of Zombies
- Path length
- Number of bullets
- Hero action length
- Population size
- Generation size
- Mutation rate


### This figure shows how fitness functions values decreases among the generation
<img src="https://github.com/sercaksoy/Genetic-Algorithm-Game-Agent/blob/main/ss/1.png">


### This figure shows the game play on a matrix
<img src="https://github.com/sercaksoy/Genetic-Algorithm-Game-Agent/blob/main/ss/2.png">

### This figure shows the shooted bullet counts
<img src="https://github.com/sercaksoy/Genetic-Algorithm-Game-Agent/blob/main/ss/3.png">

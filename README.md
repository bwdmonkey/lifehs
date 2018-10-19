# lifehs

Haskell implementation of Conway's Game of Life

Authors: Tom Lee, Susie Chen, James Luo

Usage:

```bash
$ runhaskell LifeGUI.hs
Welcome to Conway's Game of Life!
What would you like to do?
1) Use custom plots
2) Use seeds
> 1
Please provide a cell position you like to add in format of x, y (1-index)
or "quit" to quit:
> [...]
. ■ . . . . . . . . . . . . . . . . . .
■ . ■ . . . . . . . . . . . . . . . . .
. ■ ■ . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . .
Press ^c in order to finish
```

Note that this program uses ANSI escape sequences hence may not work on Windows.

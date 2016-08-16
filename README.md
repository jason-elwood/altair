# Altair

<!--[![Build Status](https://travis-ci.org/sindresorhus/pageres.svg?branch=master)](https://travis-ci.org/sindresorhus/pageres) [![Coverage Status](https://coveralls.io/repos/sindresorhus/pageres/badge.svg?branch=master)](https://coveralls.io/r/sindresorhus/pageres?branch=master)-->

A text based adventure game for your Mac Terminal.  Written in Swift.  


## Install

Altair is bundled with the <a
href="https://github.com/droppedpixel/altairwrapper">altairwrapper app</a>. 
Drag Altair Wrapper App to Applications folder and launch it the same way
you would any other OS X application.

## Usage

```js

```

## Known issues

There is a tendency for the terminal to flicker when a command
is entered.  I believe this is because the app is not syncd with the screen
refresh, as would be solved by CADisplayLink with UIKit apps.  

## Character creation:

//

## Commands:
Commands arecase sensitive.  Command arguments are not.

#### help
Displays onscreen help.

#### tutorial
Replays the new-game turorial.

#### look
Describes the player's current location.  Gives clues regarding who the player
can talk to, possible quests, places to travel, etc.

#### talk
Initiates a conversation with available NPC.
example:
```js
talk Ned
```
#### travel
Travel to an adjacent location on the map, provided the user is within the level
range.
example:
```js
travel valerion
```

#### attack
When engaged in combat, attack will attack the targeted creature.
example:
```js
attack bat
```

#### potion
Player consumes potion, if available, restoring some health.

## Configure:

Type config to see a list of configuration options.

- `width`: Sets width (in columns) of the terminal.  Values too small or too large may have undesireable
  affects. 
- `height`: Sets height (in rows) of the terminal.  Values too small or too large may have undesireable
  affects. 
- `text-color`: Color options are white, black, orange, yellow, green, blue and
  cyan.
- `background-color`: Color options are white, black, orange, yellow, green,
  blue and cyan. 
- `reset-game`: Resets current game and character. 

##### username

Type: `string`

Username for authenticating with HTTP auth.

##### password

Type: `string`

Password for authenticating with HTTP auth.

#### options

Type: `object`

Options set here will take precedence over the ones set in the constructor.


## Team

Jason Elwood 


## License

GNU © 2016

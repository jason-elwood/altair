# Altair

[![Build Status](https://travis-ci.org/sindresorhus/pageres.svg?branch=master)](https://travis-ci.org/sindresorhus/pageres) [![Coverage Status](https://coveralls.io/repos/sindresorhus/pageres/badge.svg?branch=master)](https://coveralls.io/r/sindresorhus/pageres?branch=master)

Another text based adventure game for your Mac Terminal.  Written in Swift.  


## Install

```
$ chmod 700 Altair  // make file executable on your system
Double click the Altair file.
```

## Usage

```js
const Pageres = require('pageres');

const pageres = new Pageres({delay: 2})
	.src('yeoman.io', ['480x320', '1024x768', 'iphone 5s'], {crop: true})
	.src('todomvc.com', ['1280x1024', '1920x1080'])
	.src('data:text/html;base64,PGgxPkZPTzwvaDE+', ['1024x768'])
	.dest(__dirname)
	.run()
	.then(() => console.log('done'));
```

## API

### Pageres([options])

#### options

##### delay

Type: `number` *(seconds)*  
Default: `0`

Delay capturing the screenshot.

Useful when the site does things after load that you want to capture.

##### timeout

Type: `number` *(seconds)*  
Default: `60`

Number of seconds after which PhantomJS aborts the request.

##### crop

Type: `boolean`  
Default: `false`

Crop to the set height.

##### css

Type: `string`

Apply custom CSS to the webpage. Specify some CSS or the path to a CSS file.

##### cookies

Type: `array` of `string`, `object`

A string with the same format as a [browser cookie](https://en.wikipedia.org/wiki/HTTP_cookie) or an object of what [`phantomjs.addCookie`](http://phantomjs.org/api/phantom/method/add-cookie.html) accepts.

###### Tip

Go to the website you want a cookie for and copy-paste it from Dev Tools.

##### filename

Type: `string`

Define a customized filename using [Lo-Dash templates](https://lodash.com/docs#template).  
For example `<%= date %> - <%= url %>-<%= size %><%= crop %>`.

Available variables:

- `url`: The URL in [slugified](https://github.com/ogt/slugify-url) form, eg. `http://yeoman.io/blog/` becomes `yeoman.io!blog`
- `size`: Specified size, eg. `1024x1000`
- `width`: Width of the specified size, eg. `1024`
- `height`: Height of the specified size, eg. `1000`
- `crop`: Outputs `-cropped` when the crop option is true
- `date`: The current date (Y-M-d), eg. 2015-05-18
- `time`: The current time (h-m-s), eg. 21-15-11

##### selector

Type: `string`

Capture a specific DOM element.

##### hide

Type: `array`

Hide an array of DOM elements.

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

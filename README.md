#Arthur Lui's Blog

## Cloning
In a terminal,
> $ git clone https://github.com/luiarthur/luiarthur.github.io.git

## Cloning Submodules
I only have one submodule `assets/R_Functions`. After cloning the main repo,
> $ git submodule init  
> $ git submodule update

# Pulling Submodules

- `cd` into to submodule
> $ git fetch
> $ git merge origin/master

# Pushing Submodule

- A little more complicated...
  - https://git-scm.com/book/en/v2/Git-Tools-Submodules


This will clone the `assets/R_Functions` repo.  
Learn more about *Git Submodules* [here](http://git-scm.com/book/en/v2/Git-Tools-Submodules).

***
***

#Clean Blog by Start Bootstrap - Jekyll Version

The official Jekyll version of the Clean Blog theme by [Start Bootstrap](http://startbootstrap.com/).

###[View Live Demo &rarr;](http://ironsummitmedia.github.io/startbootstrap-clean-blog-jekyll/)

## Before You Begin

In the _config.yml file, the base URL is set to /startbootstrap-clean-blog-jekyll which is this themes gh-pages preview. It's recommended that you remove the base URL before working with this theme locally!

It should look like this:
`baseurl: ""`

## What's Included

A full Jekyll environment is included with this theme. If you have Jekyll installed, simply run `jekyll serve` in your command line and preview the build in your browser. You can use `jekyll serve --watch` to watch for changes in the source files as well.

A Grunt environment is also included. There are a number of tasks it performs like minification of the JavaScript, compiling of the LESS files, adding banners to keep the Apache 2.0 license intact, and watching for changes. Run the grunt default task by entering `grunt` into your command line which will build the files. You can use `grunt watch` if you are working on the JavaScript or the LESS.

You can run `jekyll serve --watch` and `grunt watch` at the same time to watch for changes and then build them all at once.

## Support

Visit Clean Blog's template overview page on Start Bootstrap at http://startbootstrap.com/template-overviews/clean-blog/ and leave a comment, email feedback@startbootstrap.com, or open an issue here on GitHub for support.

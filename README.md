## Summary

This repo is an extraction from [archive.org](https://archive.org) for [dreamhead.blogbus.com](http://dreamhead.blogbus.com)

## Jekyll
* install ruby gems by running `bundle install`
* this repo uses [jekyll](https://jekyllrb.com) with [mediumish-theme-jekyll](https://github.com/wowthemesnet/mediumish-theme-jekyll/), run `bundle exec jekyll serve` to view in browser
* with the MARKDOWN files under *_posts*, it can be transfered to other themes/tools of your choice

## Parser

* raw data extracted is saved in *posts.json*
* markdown template can be modified in erb template file (*post_template.erb*)
* run `./parse_posts` to regenerat markdown files from source `posts.json` after you change template file

## Copyright

* Copyright of all posts in this repo belongs to the author of [dreamhead.blogbus.com](http://dreamhead.blogbus.com)

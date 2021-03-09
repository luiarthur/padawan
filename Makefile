.PHONY: clean serve clean_serve

all: clean_serve

clean:
	rm -rf _site

serve:
	bundle exec jekyll serve --incremental --livereload

serve-draft:
	bundle exec jekyll serve --incremental --drafts

clean-serve: clean serve

clean-serve-draft: clean serve_draft

update-gems:
	rm Gemfile.lock
	bundle install

install:
	bundle install

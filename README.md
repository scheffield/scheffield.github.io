# Hosting
* www.digitalme.co
* Followed https://medium.com/@JinnaBalu/godaddy-domain-with-github-pages-62aed906d4ef
  * there was some fuck up where a godaddy redirect would cause trouble
  * had to add a custom A record and remove the existing one
  * also removed all forwarding for now

# Deploy
```bash
./deploy.sh
```

# Develop
* follow `jekkyl` installation guide: https://jekyllrb.com/docs/installation
  * on WSL2 use the ubuntu version
* run
```bash
bundle exec jekyll serve --livereload
```
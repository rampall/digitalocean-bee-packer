Based on https://www.digitalocean.com/community/tutorials/how-to-create-digitalocean-snapshots-using-packer-on-ubuntu-16-04

This creates DigitalOcean snapshots / images, which can be used to create new Droplets which include Bee and Swarm-CLI.

Update `my_token` in `template.pkr.hcl` and build with:

```
packer build template.pkr.hcl
```

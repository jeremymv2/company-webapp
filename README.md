# company-webapp-cookbook

This cookbook automates the installation of:
  - nginx server serving requests on port 8000
  - serves content from the following repo: https://github.com/puppetlabs/exercise-webpage

It also:
  - ensures that the required configuration is completed reliably
  - is idempotent and does not repeat redundant tasks

## Dependencies

This cookbook installs all of its dependencies via Berkshelf and the Chef supermarket

## Supported Platforms

This cookbook supports the same platforms as the nginx and git cookbooks.  (Debian and RHEL families)

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['company-webapp']['port']</tt></td>
    <td>string</td>
    <td>Port for nginx to listen on</td>
    <td><tt>8000</tt></td>
  </tr>
  <tr>
    <td><tt>['company-webapp']['gitrepo']</tt></td>
    <td>string</td>
    <td>Location of the git repo</td>
    <td><tt>https://github.com/puppetlabs/exercise-webpage.git</tt></td>
  </tr>
  <tr>
    <td><tt>['company-webapp']['gitbranch']</tt></td>
    <td>string</td>
    <td>Which branch to deploy from</td>
    <td><tt>master</tt></td>
  </tr>
  <tr>
    <td><tt>['company-webapp']['docroot']</tt></td>
    <td>string</td>
    <td>Target directory to deploy website</td>
    <td><tt>/var/www/nginx/default</tt></td>
  </tr>
  <tr>
    <td><tt>['company-webapp']['index']</tt></td>
    <td>string</td>
    <td>What file names nginx should use as index</td>
    <td><tt>index.html index.htm</tt></td>
  </tr>
</table>

## Usage

### local workstation / development test
```
Git
 - install git and clone down this repository

VirtualBox
 http://www.oracle.com/technetwork/server-storage/virtualbox/downloads/index.html

Vagrant
 http://www.vagrantup.com/downloads.html
 vagrant plugin install vagrant-berkshelf

Chef DK
 https://downloads.chef.io/chef-dk/

PATH
 ensure that /opt/chefdk/bin is before any other Chef items in your PATH variable

Get Rolling
cd into company-webapp
kitchen converge # this will instantiate a new VM and converge it
point your workstation browser to http://localhost:8000
kitchen login # this will allow you to log in to the VM

```

### deploying this to your infrastructure

 Include `company-webapp` in your node's Chef `run_list`:

```json
{
  "run_list": [
    "recipe[company-webapp::default]"
  ]
}
```

## License and Authors

Author:: Jeremy J. Miller (<jeremymv2@gmail.com>)

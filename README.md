# Getting Started

1. Set up automated deployment
	a. Point Google Domain to Cloudflare
	b. Set up Digital Ocean server
		i. Initial server setup (do all steps - refer to note below)
			- https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-16-04
			- NOTE: After you're done with the guide, open port 4000 with the command `sudo ufw allow 4000` so you can test the deployment later.
		ii. Install Nginx (do all steps)
			- https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-16-04
		iii. Create server blocks (do all steps)
			- https://www.digitalocean.com/community/tutorials/how-to-set-up-nginx-server-blocks-virtual-hosts-on-ubuntu-16-04
		iii. Secure Nginx with SSL certificate (do all steps - refer to note below)
			- https://www.digitalocean.com/community/tutorials/how-to-set-up-let-s-encrypt-with-nginx-server-blocks-on-ubuntu-16-04
			- NOTE:In step 4, choose option 2, Redirect. This will provide automatic redirects to HTTPS on the production server we're creating in this tutorial.
			- NOTE: After you are done with this guide, change Cloudflare's Crypto SSL setting to Full
	c. Automate deployment
		i. Install Elixir/Phoenix on server, configure SSH, and create test project (do steps 2-4 - refer to note below)
			- https://www.digitalocean.com/community/tutorials/how-to-automate-elixir-phoenix-deployment-with-distillery-and-edeliver-on-ubuntu-16-04
			- NOTE: In step 4, replace `mix phx.new --no-ecto --no-brunch myproject` with `mix phx.new myproject`
		ii. Install Nodejs and Postgres (do steps 6 & 7 - refer to note below)
			- https://devato.com/automate-elixir-phoenix-1-4-deployment-with-distillery-and-edeliver-on-ubuntu/
			- NOTE: In step 7, replace `sudo app update` with `sudo apt update`
			- NOTE: In step 7, replace`pgsql` command with `psql`
			- NOTE: Note down the username and password of your db user, you will have to use it when you copy prod.secret to the server later.
		iii. Install build-essential package 
			- Type `sudo apt-get install build-essential` in server command line
		iii. Configure Distillery and eDeliver (do steps 5-9 - refer to note below)
			- https://www.digitalocean.com/community/tutorials/how-to-automate-elixir-phoenix-deployment-with-distillery-and-edeliver-on-ubuntu-16-04
			- NOTE: In step 5, when you copy prod.secret to your server change `example.com:/home...` to `deploy@example.com:home...`
			- NOTE: In step 5, after you copy prod.secret, change it to what you see here in step 8 with the database username/password that noted down from a few steps before. https://devato.com/automate-elixir-phoenix-1-4-deployment-with-distillery-and-edeliver-on-ubuntu/
			- NOTE: In step 5, use the latest eDeliver dependency that you'll find here https://github.com/edeliver/edeliver
			- NOTE: In step 6, below the `pre_erlang_get_and_update_deps` function, add the `pre_erlang_clean_compile()` function that you'll find in here https://devato.com/automate-elixir-phoenix-1-4-deployment-with-distillery-and-edeliver-on-ubuntu/

2. Add front-end dependencies
	a. Change CSS to SCSS
		i. https://elixirforum.com/t/phoenix-1-4-webpack-4-and-bulma-bootstrap-4-sass/14354/7
	b. Add Bulma/Bulma Extensions/Animate.css
		ii. https://elixirforum.com/t/phoenix-1-4-webpack-4-and-bulma-bootstrap-4-sass/14354/20


References
1. Restarting Stuff
	a. Rebooting the server
		- `sudo systemctl reboot`
	b. Restart Nginx
		- `sudo systemctl restart nginx`
	b. Restart postgres
		- `sudo systemctl restart postgresql`
	c. Restart SSH
		- `sudo systemctl reload sshd`
2. Ports
	a. See what ports are listening
		- `netstat -nlt`
	b. Open port
		- `sudo ufw allow 8080`
	c. Close port
		- `ufw delete allow 8080`
3. Folder paths
	a. Postgres configs
		- `/etc/postgresql/9.5/main`
	b. Error logs
		- `/var/log/nginx/error.log`
4. Nginx users 
	a. Adding users
		- `sudo adduser user_name`
	b. Deleting users
		- `sudo userdel user_name`
		- Then remove their home directory with
		- `sudo rm -rf /home/username`
5. NPM
	a. See what version you are using
		- `npm -v`
		-	`npm install -g npm@latest`
6. Build and deploy
		- `cd ~/myproject`
		- `mix edeliver build release`
		- `mix edeliver deploy release to production`
		- `mix edeliver start production`
		- after you do the above once, you can upgrade versions by bumping up the version number in Mix.exs and using the command `mix edeliver upgrade production`



	






































	1. Set up automated deployment
	a. Point Google Domain to Cloudflare
	b. Set up Digital Ocean server
		i. Initial server setup (do all steps)
			- https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-16-04
		ii. Install Elixir/Phoenix, configure SSH (do steps 2,3)
		https://www.digitalocean.com/community/tutorials/how-to-automate-elixir-phoenix-deployment-with-distillery-and-edeliver-on-ubuntu-16-04
		i. Then try this guide (and see notes below)
			- https://devato.com/automate-elixir-phoenix-1-4-deployment-with-distillery-and-edeliver-on-ubuntu/
			- Step 1: After completing, initialize a git repository in your project folder. 
			- Step 2-5: skip
			- Step 7: Replace `sudo app update` with `sudo apt update`
			- Step 7: replace`pgsql` command with `psql`
			- Step 8: instead of putting prod.secret in `mkdir -p apps/phxroad/secret`, create a folders in the deploy directory called `app_config` and put prod.secret in there
			- Step 9: In the .deliver/config file, change `BUILD_AT=` to `"/home/deploy/app_build"` and `DELIVER_TO=` to `"/home/deploy/app_release"`. Also, in the `pre_erlang_get_and_update_deps` function, change `local _prod_secret_path=` to `"/home/deploy/app_config/prod.secret.exs"`
			- Step 10: Before step 9, type `echo ".deliver/releases/" >> .gitignore` command in project folder to add .deliver releases to git ignore. Then add and commit the project before deploying in step 10.
		 

		iii. Install Nginx
			- https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-16-04
		iv. Secure Nginx with SSL certificate
			- https://www.digitalocean.com/community/tutorials/how-to-set-up-let-s-encrypt-with-nginx-server-blocks-on-ubuntu-16-04
		vi. Add pre_erlang_get_and_update_deps function to .deliver/config so Webpack can build assets
			- https://www.digitalocean.com/community/tutorials/how-to-set-up-a-node-js-application-for-production-on-ubuntu-16-04
		vii. Add Nodejs and Postgres annd Build Essentials to server
			- https://medium.com/@zek/deploy-early-and-often-deploying-phoenix-with-edeliver-and-distillery-part-one-5e91cac8d4bd
	c. Build and deploy
		- `cd ~/myproject`
		- `mix edeliver build release`
		- `mix edeliver deploy release to production`
		- `mix edeliver start production`
		- after you do the above once, you can upgrade versions by bumping up the version number in Mix.exs and using the command `mix edeliver upgrade production`
2. Add front-end dependencies
	a. Change CSS to SCSS
		i. https://elixirforum.com/t/phoenix-1-4-webpack-4-and-bulma-bootstrap-4-sass/14354/7
2. Add Bulma/Bulma Extensions/Animate.css
		ii. https://elixirforum.com/t/phoenix-1-4-webpack-4-and-bulma-bootstrap-4-sass/14354/20
3. 

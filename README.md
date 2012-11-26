# box_cli

box_cli provides a basic and minimal command-line interface to Box (<https://www.box.com/>). It is not written by Box; use at your own risk. We hope that eventually Box will provide their own command-line interfaces for Linux, BSD, OS/X, Windows, etc. Until then, this may help.

## Install

Install the gem:

    gem install box_cli

## Usage

After installing the gem, you can run the command `box` to use the application. For help, type

    box --help

NOTE: All of the commands that communicate with Box require an API key and user credentials. To obtain your own Box API key, read the documentation here: <http://developers.box.net/w/page/12923956/ApiOverview#GettingStartedwiththeBoxAPI> -- We do not ship an API key with this gem, because you may be
working off of a forked copy.

When a command requires an API key and user credentials, it will find them in the following order:

1. It will find the values in the options `--api_key`, `--user`, and `--password`
2. Failing that, it will check for environment variables `BOX_CLI_API_KEY`, `BOX_CLI_USER`, and `BOX_CLI_PASSWORD`
3. Failing that, it will prompt for the value from the keyboard

You may define each of these options separately. In other words, if you define only the environment variables `BOX_CLI_API_KEY` and `BOX_CLI_USER`, you will
be prompted only for the password.

The most commonly-used commands are:

    box info path
    box upload file path
    box download path
    box delete path
    box account_info
    
The commands adhere fairly closely to the Box API, as defined by the list of calls in the right sidebar at the developer site: <http://developers.box.net/w/page/12923956/ApiOverview>. For example, `box account_info` might produce an interaction similar to this:

    $ box account_info
    Status: get_account_info_ok
    User:   
       Login:           john@iorahealth.com
       Email:           john@iorahealth.com
       Access:          11756654
       User:            11756654
       Space amount:    21474836480
       Space used:      1657381056
       Max upload size: 2147483647

To understand what the status value "get_account_info_ok" means, consult the documentation for the API call that corresponds to the command (i.e., <http://developers.box.net/w/page/12923928/ApiFunction_get_account_info>).

## Testing

To run all tests that don't require exercising box directly (replacing the key, user, and password *with those used when the VCR cassettes were created*),

    BOX_CLI_API_KEY=pzay0i0o2psakiitm9ysn2jjd2ho7qg5 BOX_CLI_USER=box_cli_testing@iorahealth.com BOX_CLI_PASSWORD=crazypassword01 bundle exec rake

Many of the Cucumber features require a *working* Box API key and user credentials, which should be defined through environment variables. The default rake task excludes all features tagged with `@requires_authorization` so that TravisCI will not exercise the actual service. This means that if you make changes in features, you should verify by running cucumber directly (not through rake) with your own key, user, and password:

    BOX_CLI_API_KEY=pzay0i0o2psakiitm9ysn2jjd2ho7qg5 BOX_CLI_USER=box_cli_testing@iorahealth.com BOX_CLI_PASSWORD=crazypassword01 bundle exec cucumber

NOTE: If you recreate the VCR cassettes, make sure to invalidate your API key and credentials before making a pull request or anything else that would reveal your key or credentials.

## Contributing to box_cli
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2012 Iora Health. See LICENSE.txt for further details.
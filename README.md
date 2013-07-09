# Batt

Read the battery status from your laptop. Designed to be used in `tmux`'s status line.

Currently only supports OSX.

## Installation

Add this line to your application's Gemfile:

    gem 'batt'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install batt

## Usage

There is a full API that I'm working on, but it's not complete. Gem docs will come
at the time that the code is implemented.

You can use the commandline program, in OSX only for now:

    batt <action>

Where `action` is one of the following:

 * `all` -- prints out all status of the battery
 * `status` -- 'charging' or 'discharging'
 * `source` -- 'AC Power' or 'Battery Power'
 * `remaining` -- amount of time remaining til complete discharge or complete charge
 * `capacity` -- a percentage of how charged the battery is

 ## tmux

 Example `tmux` status line configuration:

    tmux set-option status-right-length 120
    tmux set-option status-right "[ #(batt source) #(batt remaining) ] #(date \"+%Y-%m-%d %H:%M:%S\")"

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

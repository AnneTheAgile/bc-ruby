changelog.md

===========================================================
### VERSION 1.04 on 2014-01-20m

## CUSTOMER-FACING Changes; 
* [x]Issue#01 Bug when use CLI and add a batch price - integers aren't auto-converted from string.

* [x]Issue#02 Add @live variable to explicitly decide whether to show initialization 'hello' messaging, which is shared between API and CLI.

* [x]Issue#03 Refactor prompt loops to use a generic, customized prompter plus yield to create specific objects. (Ruby-tip, Cannot pass two blocks for two different yield's, so printing the resultant object is now delegated.)
- Deleted completed Terminal spec which is not user-visible; "Refactor, Consolidate to single prompt_loop with yield." 
http://stackoverflow.com/questions/10451060/use-of-yield-and-return-in-ruby
- Code;  New method;   
	# Provide the overhead functionality for prompting and yield to the given block for specific prompt.
    # (ISSUE#03) Note; It would be preferable to delay the presentation of the object's printing,
    # as done previously, but one cannot pass two different yield blocks, so now clients are responsible for printing verification messages.
    def prompt_loop_customized(aHiString, aByeString)
- The new code is slightly better but still looks messy?

* [x]Issue#04: Added RDOC files accessible at ./doc/index.html. Reultant metric: 36% of 64 item documented,
.[]Ruby-tip; To generate API Doc for project; On windows, in root, $ rdoc.bat ./lib

* [x]Issue#05: Add this ChangeLog.md and Readme.md.
Examples; https://raw.github.com/colszowka/simplecov/a38915db28552cf1a51748f104d34d86a2e897bc/CHANGELOG.md
https://raw.github.com/colszowka/simplecov/a38915db28552cf1a51748f104d34d86a2e897bc/README.md


## NON-FUNCTIONAL Changes

* [x]Issue#05: Added SimpleCov results at ./coverage/index.html#_AllFiles . Only the /lib/ files are the code to consider; their stats are great, except apparently my custom matcher?
File 	%covered 	Lines 	RelevantLines 	LinesCovered 	LinesMissed 	Avg.Hits/Line
spec/lib/custom_stdout_matcher.rb 	82.35 % 	36 	17 	14 	3 	5.8
lib/terminal.rb 	91.3 % 	123 	69 	63 	6 	5.1
lib/money.rb 	97.14 % 	74 	35 	34 	1 	149.8
lib/cart.rb 	100.0 % 	52 	27 	27 	0 	13.1
lib/store.rb 	100.0 % 	136 	70 	70 	0 	46.2


* [\]Refactor; Deleted pending spec, Already done; 
Store    it 'Refactor Products Map to use symbols instead of strings as hash keys.'  do
      pending 'cf Ruby Design rules; https:\/\/github.com\/styleguide\/ruby'
    end
Use symbols instead of strings as hash keys.
# good
hash = { :one => 1, :two => 2, :three => 3 }

* [x]Refactor; A few other tests were fixed as well.


===========================================================
### VERSION 1.03 on 2014-01-19x

* 1.Working on Windows.
* 2.First fully functional version per all original specs + CLI app.
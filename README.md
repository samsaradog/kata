Code exercises
---------------

These are the results of several kata built as part of my apprenticeship at 8th Light. All of the files contain both the test and implementation. You can run the Ruby files with:

    $ rspec \<filename\>
	
This is what we have so far:

FizzBuzz<br>
Prime Factors<br>
Roman Numerals<br>
Money Changer<br>

There are also files for FizzBuzz, Roman Numerals and Money Changer written in prolog. These can be run by installing swi-prolog:

    $ brew install swi-prolog

Then starting the prolog repl:

    $ swipl

And from within the repl, loading the file and running the tests in it. For example:

    ?- ['fizzbuzz'],run_tests.

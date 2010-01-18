
First principles
----------------

* Writing ocde is fast. Debeggging code is slow. `Code is read far more times
  than it is written <guido>`__. Therefore we should ensure that code is easy
  to read at the expense of taking longer to write it.

* Consistency is good. Meeting expectations is good. Code and APIs that are
  easy to learn and understand are those that behave the way you expect them
  to.

* `A foolish consistency is the hobgoblin of small minds <>`__. Within reason.
  If style intereferes with the *functionality* of code, style must give way.

* Explicit is better than implcit.

* In the face of ambiguity, refuse the temptation to guess.

* There should be one-- and preferably only one --obvious way to do it.

* If the implementation is hard to explain, it's a bad idea. If the implementation is easy to explain, it may be a good idea.

* However, always remember, we are here to get stuff done. 


Overall layout
--------------

* Use UTF-8 encoding
 
* Use tabs or spaces for indenting, but be consistent.
 
* Use Unix-style line endings.

* Keep lines fewer than 80 characters.

 
* Use spaces around operators, after commas, colons and semicolons,
  around { and before }.
 
* No spaces after (, [ and before ], ). except where doing multiline lists or hashes.
 
* Use two spaces before statement modifiers (postfix
  if/unless/while/until/rescue).
 
* Indent when as deep as case.
 
* Use an empty line before the return value of a method (unless it
  only has one line), and an empty line between defs.
 
* Use RDoc and its conventions for API documentation.  Don't put an
  empty line between the comment block and the def.
 
* Use empty lines to break up a long method into logical paragraphs.
 
* Avoid trailing whitespace.

* It's often handy  to seperate include statements into groups depending on
  their source. These groups are standard libraries, third-party or external
  libraries and files within the project. So witin the "FooServer" project::

   import csv
   from wrap import wrap

	import Bio
   import elementtree

   import fooserver.middleware
   import textutils # a package within foosever






Also see
--------

* `Ruby guide <http://www.caliban.org/ruby/rubyguide.shtml>`__

* Christian Neukirchen `Ruby Style Guide <http://github.com/chneukirchen/styleguide/blob/master/RUBY-STYLE>`__

* Benjamin Kudria `Ruby srtyle guide <http://github.com/bkudria/styleguide>`__

* Guido van Rossum `PEP 8 - Style guide for Python code <http://www.python.org/dev/peps/pep-0008/>`__

* Tim Peters `PEP 20 - The Zen of Python <http://www.python.org/dev/peps/pep-0020/>`__




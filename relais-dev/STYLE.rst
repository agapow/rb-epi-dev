
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


Overall formatting
------------------

Use UTF-8 encoding. Enforce this with editor hash line at the top of the file::

	# -- utf8 TODO

Use Unix-style line endings.

.. rationale:
	Strange encodings and end-of-line markers can cause strange errors in editors and interpretors. But
	everything understand utf8 and newline.	
 
Use tabs *or* spaces for indenting, but not both. Be consistent.

.. rationale:
	This gives a consistent level of relative indenting / nesting regardless of
	local editor settings and lets the code be easily 

Keep lines fewer than 80 characters.

.. rationale:
	Readability - I shouldn't have to scroll to see that the line ends "unless
	...". Also, lines that are longer than 80 characters are a sign that 1.
	you're probably trying to do too much in one line or 2. your variable names
	are far too long. 

Readability studies suggest that indivdual function should be no more than a
screenful and that within should be broke up into sections of 5-7 lines. Use two
lines between major code sections (e.g. classes) to distinguish these breaks
from internal spacing.


Code formatting
---------------
 
* Use spaces around operators, after commas, colons and semicolons,
  around { and before }.
 
* No spaces after (, [ and before ], ). except where doing multiline lists or hashes.
 
* Indent when as deep as case.
 
Return values should be clearly indicated. Either use "return" (frowned upon by
most Ruby users) or place an empty line before the implicit return value.

Ruby allows you to do a lot of things implicitly: unamed parameters and blocks,
implcit returns, etc. Don't.
 
* Use RDoc and its conventions for API documentation.  Don't put an
  empty line between the comment block and the def.
 
* Use empty lines to break up a long method into logical paragraphs.
 
* Avoid trailing whitespace.

* It's often handy  to seperate include statements into groups depending on
  their source. These groups are standard libraries, third-party or external
  libraries and files within the project. So witin the "FooServer" project::

	# standard libraries
   require 'csv'
   require 'wrap'

	# 3rd party
	require 'bio'
   require 'elementtree'

	# the local project
   require 'fooserver.middleware'
   require 'textutils'


Use "||" instead of "or".

.. rationale:
	"||" works like you expect, whereas "or" sometimes doesn't, depending on
   context. See `here <TODO>`__

Optional function parameters should always be passed in a hash as the final
argument, even if there is only one, using an idiom like this::

	def myfunc(arg1, arg2, opts={})
		defaults = {
			:foo => 3,
			:bar => true,
		}.merge(options)

.. rationale:
	Ruby's mapping of the parameters passed in to arguments gets super messy if
   you interleave named and unamed arguments or want to pass in some but not all
   unamed arguments. By using the Rails-style final hash, we get clarity,
   consistency and the ability to use any combination of optional arguments. It
   is tempting to eschew the hash if there is only one optional argument, but if
   another optional parameter has to be added later, the function signature will
   get ugly::

		# tempting but wrong
      def wraptext(str, width=60)
		# when more parameters are added
		def wraptext(str, width=60, strip_newlines=true)
		def wraptext(str, width=60, options={})
		# better solution
		def wraptext(str, options={})
     
Use `Yard <http://yardoc.org>`__ for documentation. A useful template is::

	# Short description of function.
	#
	# @param [types] param1 A description of param1.
	# @param [types] param2 A description of param2.
	#
	# @return A description of return values.
	#
	def myfunc(param1, param2)
		...
 
.. rationale:
	Yard's syntax is slightly awkward and requires some discipline and
	consistency to use, but the output is far more consistent.



Also see
--------

* `Ruby guide <http://www.caliban.org/ruby/rubyguide.shtml>`__

* Christian Neukirchen `Ruby Style Guide <http://github.com/chneukirchen/styleguide/blob/master/RUBY-STYLE>`__

* Benjamin Kudria `Ruby srtyle guide <http://github.com/bkudria/styleguide>`__

* Guido van Rossum `PEP 8 - Style guide for Python code <http://www.python.org/dev/peps/pep-0008/>`__

* Tim Peters `PEP 20 - The Zen of Python <http://www.python.org/dev/peps/pep-0020/>`__




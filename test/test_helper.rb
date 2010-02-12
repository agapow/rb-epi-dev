require 'stringio'
require 'test/unit'
require File.dirname(__FILE__) + '/../lib/relais-dev'

require 'tempfile'


def capture_output(&block)
	# purloined from zentest
	require 'stringio'
	orig_stdout = $stdout.dup
	orig_stderr = $stderr.dup
	captured_stdout = StringIO.new
	captured_stderr = StringIO.new
	$stdout = captured_stdout
	$stderr = captured_stderr
	yield
	captured_stdout.rewind
	captured_stderr.rewind
	return captured_stdout.string, captured_stderr.string
ensure
	$stdout = orig_stdout
	$stderr = orig_stderr
end

def capture_exception(&block)
	begin
		yield
	rescue StandardError => err
		return err
	end
	return nil
end

def suppress_output(&block)
	
end

def file_contents(path)
	return File.open(path, 'rb').read()
end


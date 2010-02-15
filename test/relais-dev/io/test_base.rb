
require 'test/unit/testcase'
require 'test/unit' if $0 == __FILE__

require 'relais-dev/io/base'

module TestRelais
	module TestDev
		module TestIo
			
			BaseIo = Relais::Dev::Io::BaseIo
			
			class TestBaseIo < Test::Unit::TestCase

				def test_ctor_path
					# check io can be created with path
					in_path = 'test/files/in/empty.txt'
					io = BaseIo.new(in_path, :mode=>'r')
					assert_equal(in_path, io.hndl.path)
					assert_equal(false, io.hndl.closed?)
					io.finish()
				end

				def test_ctor_stream
					# check io can be created with stream
					in_path = 'test/files/in/empty.txt'
					in_hndl = File.open('test/files/in/empty.txt', 'r')
					io = BaseIo.new(in_hndl)
					assert_equal(in_path, io.hndl.path)
					assert_equal(false, io.hndl.closed?)
					io.finish()
				end

				def test_open_and_close
					# check io ...
					# ... opens & closes paths
					in_path = 'test/files/in/empty.txt'
					io = BaseIo.new(in_path, :mode=>'r')
					assert_equal(in_path, io.hndl.path)
					assert_equal(false, io.hndl.closed?)
					io.finish()
					assert_equal(true, io.hndl.closed?)

					# ...  and leave everything else alone
					in_hndl = File.open('test/files/in/empty.txt', 'r')
					io = BaseIo.new(in_hndl)
					assert_equal(in_path, io.hndl.path)
					assert_equal(false, io.hndl.closed?)
					io.finish()
					assert_equal(false, io.hndl.closed?)
				end

				def test_class_with
					# check that io is created & handed to block & closes file
					in_path = 'test/files/in/empty.txt'
					tmp_hndl = nil
					BaseIo.with(in_path, :mode=>'r') { |io|
						assert_instance_of(BaseIo, io)
						tmp_hndl = io.hndl
						assert_equal(in_path, tmp_hndl.path)
						assert_equal(false, tmp_hndl.closed?)
					}
					assert_equal(true, tmp_hndl.closed?)
				end

			end
		end
	end
end

module TestRelais
	module TestDev
		module TestIo
			
			Reader = Relais::Dev::Io::Reader

			class TestReader < Test::Unit::TestCase
				# TODO: need to test setting of modes
				
				def test_ctor
					# check that object created appropriately
					in_path = 'test/files/in/oneline.txt'
					wrtr = Reader.new(in_path)
					wrtr = Reader.new(in_path, :mode=>'r')
				end
				
				def test_read
					# check that file read appropriately
					in_path = 'test/files/in/oneline.txt'
					wrtr = Reader.new(in_path)
					assert_equal("line 1\n", wrtr.read())
				end
				
				def test_class_with
					# check that io is created & handed to block & closes file
					in_path = 'test/files/in/oneline.txt'
					Reader.with(in_path) { |wrtr|
						assert_instance_of(Reader, wrtr)
						assert_equal("line 1\n", wrtr.read())
					}
				end
				
			end
		end
	end
end

module TestRelais
	module TestDev
		module TestIo
			
			LineReader = Relais::Dev::Io::LineReader

			class TestLineReader < Test::Unit::TestCase
				
				def test_read_line
					# check that io is created & handed to block & closes file
					in_path = 'test/files/in/oneline.txt'
					LineReader.with(in_path) { |wrtr|
						assert_instance_of(LineReader, wrtr)
						assert_equal("line 1", wrtr.read_line())
					}
				end
				
			end

		end
	end
end

module TestRelais
	module TestDev
		module TestIo
			
			LineWriter = Relais::Dev::Io::LineWriter
			OUT_PATH = 'test/files/out/oneline.txt'

			class TestLineWriter < Test::Unit::TestCase
				def test_write_line
					# check that output is written correctly
					LineWriter.with(OUT_PATH) { |wrtr|
						wrtr.write_line("foo")
					}
					assert_equal(file_contents(OUT_PATH), "foo\n")
				end

			end
		end
	end
end

module TestRelais
	module TestDev
		module TestIo
			
			RecordReader = Relais::Dev::Io::RecordReader
			IN_PATH = 'test/files/in/rec-delim.txt'

			class TestRecordReader < Test::Unit::TestCase

				def test_ctor
					# check that object created appropriately
					wrtr = RecordReader.new(IN_PATH, 'delim')
					wrtr = RecordReader.new(IN_PATH, :mode=>'r')
				end
				
				def test_read
					# check that file read appropriately
					wrtr = RecordReader.new(IN_PATH, 'delim')
					assert_equal("foo", wrtr.read_record())
					assert_equal("bar", wrtr.read_record())
					assert_equal("baz\n", wrtr.read_record())
					assert_equal(nil, wrtr.read_record())
				end

				def test_read_all
					# check that file read appropriately
					wrtr = RecordReader.new(IN_PATH, 'delim')
					assert_equal(["foo", "bar", "baz\n"], wrtr.read_all_records())
				end

				def test_read_each
					wrtr = RecordReader.new(IN_PATH, 'delim')
					recs = []
					wrtr.read_each { |r|
						recs << r
					}
					assert_equal(["foo", "bar", "baz\n"], recs)
				end

				def test_read_record
					in_path = 'test/files/in/rec-delim.txt'
					RecordReader.with(in_path, 'delim') { |rdr|
						assert_equal("foo", rdr.read_record())
					}
				end

				def test_read_all_records
					in_path = 'test/files/in/rec-delim.txt'
					RecordReader.with(in_path, 'delim') { |rdr|
						assert_equal(["foo", "bar", "baz\n"], rdr.read_all_records())
					}
				end

			end
		end
	end
end


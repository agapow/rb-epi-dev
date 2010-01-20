
require 'epiobjs'
require 'csv'

def wrap_text(txt, col=60)
  txt.gsub(/(.{1,#{col}})( +|$)\n?|(.{#{col}})/,
    "\\1\\3\n")
end

hndl = File.open('isolates-with-split-genes.bin', 'rb')
data = hndl.read()
isolates = Marshal.load(data)

GENES = ['PB2', 'PB1', 'PA', 'HA', 'NP', 'NA', 'MP', 'NS']

GENES.each { |g|
	print "Collecting data for gene #{g}\n"
   seqs = isolates.collect { |iso|
		iso.bioseqs.find { |b|
			b.title == g
		}
	}
	print "Collected #{seqs.length} genes from #{isolates.length} isolates\n"

	hndl = File.open("#{g}.fasta", 'wb')
	seqs.each { |s|
		print "Writing #{s.identifier}\n"
		hndl.write("> #{s.identifier}\n")	
		hndl.write(wrap_text(s.data))
	}
	hndl.close()
}


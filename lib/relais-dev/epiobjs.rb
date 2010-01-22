#! /usr/bin/env ruby
# -*- coding: utf-8 -*-


DOMAIN = 'epiinformatics.org'


class EpiObject
	def to_yaml_type
		"!#{DOMAIN},2010-01-10/#{@@class.to_s()}"
	end

	def to_yaml_properties
		[ '@name', '@phone', '@address' ]
	end

	def from_yaml_dict(ydict)
		@id = ydict.fetch(:id, nil)
		@identifier = ydict.fetch(:identifier, nil)
		@source = ydict.fetch(:source, nil)
		@id = ydict.fetch(:id, nil)
	end
end

class ExtRef
   attr_accessor(
      :source,
      :identifier
   )
end


class PrimaryEpiObject < EpiObject
	attr_accessor(
		:id,
		:identifier,
		:source,
		:title,
		:extrefs
	)

	def to_yaml_properties
      return super() + [
			'@id',
			'@source',
			'@identifier',
			'@title',
			'extrefs',
		]
   end

end


class Isolate < PrimaryEpiObject
	attr_accessor(
		:material,
		:bioseqs
	)

   def from_yaml_dict(ydict)
		@material = ydict.fetch(:material, nil)
		@bioseqs = ydict.fetch(:bioseqs, nil)
   end
end      


class Bioseq < PrimaryEpiObject
	attr_accessor(
		:data,
		:isolate_id
	)

	def from_yaml_dict(ydict)
		@data = ydict.fetch(:data, nil)
		@isolate_id = ydict.fetch(:isolate_id, nil)
	end
	
end


def obj_from_yaml (yaml_node)

end


def dump_to_file (obj, file_or_path)
	if file_or_path.class == String
		hndl = File.open(file_or_path, 'w')
		file_opened = true
	else
		hndl = file_or_path
		file_opened = false
	end

	Marshal.dump(obj, hndl)
	file_opened? inhndl.close()
end


def load_from_file (file_or_path)
	if file_or_path.class == String
		hndl = File.open(file_or_path, 'r')
		file_opened = true
	else
		hndl = file_or_path
		file_opened = false
	end

	obj = Marshal.load(hndl)
	file_opened? inhndl.close()
	return obj
end



### TEST


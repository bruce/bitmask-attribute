# bitmask-attribute

Transparent manipulation of bitmask attributes.

## Example

Simply declare an existing integer column as a bitmask with its possible
values.

    class User < ActiveRecord::Base
      bitmask :roles, :as => [:writer, :publisher, :editor] 
    end
    
You can then modify the column using the declared values without resorting
to manual bitmasks.
    
    user = User.create(:name => "Bruce", :roles => [:publisher, :editor])
    user.roles
    # => [:publisher, :editor]
    user.roles << :writer
    user.roles
    # => [:publisher, :editor, :writer]
    
For the moment, querying for bitmasks is left as an exercise to the reader,
but here's how to grab the bitmask for a specific possible value for use in
your SQL query:

    bitmask = User.bitmasks[:roles][:editor]
    # Use `bitmask` as needed

## Modifying possible values

Once you have data using a bitmask, don't change the order of the values,
remove any values, or insert any new values in the array anywhere except at
the end.

## Contributing and reporting issues

Please feel free to fork & contribute fixes via GitHub pull requests.
The official repository for this project is
http://github.com/bruce/bitmask-attribute

Issues can be reported at
http://github.com/bruce/bitmask-attribute/issues

## Credits

Thanks to the following contributors:

* [Jason L Perry](http://github.com/ambethia)
* [Nicolas Fouché](http://github.com/nfo)

## Copyright

Copyright (c) 2007-2009 Bruce Williams. See LICENSE for details.

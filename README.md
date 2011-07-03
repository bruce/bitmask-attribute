bitmask-attribute
=================

Transparent manipulation of bitmask attributes.

Example
-------

Simply declare an existing integer column as a bitmask with its possible
values.

    class User < ActiveRecord::Base
      bitmask :roles, :as => [:writer, :publisher, :editor, :proofreader] 
    end
    
You can then modify the column using the declared values without resorting
to manual bitmasks.
    
    user = User.create(:name => "Bruce", :roles => [:publisher, :editor])
    user.roles
    # => [:publisher, :editor]
    user.roles << :writer
    user.roles
    # => [:publisher, :editor, :writer]
    
It's easy to find out if a record has a given value:

    user.roles?(:editor)
    # => true
    
You can check for multiple values (uses an `and` boolean):

    user.roles?(:editor, :publisher)
    # => true
    user.roles?(:editor, :proofreader)
    # => false

Or, just check if any values are present:

    user.roles?
    # => true

Named Scopes
------------

A couple useful named scopes are also generated when you use
`bitmask`:

    User.with_roles
    # => (all users with roles)
    User.with_roles(:editor)
    # => (all editors)
    User.with_roles(:editor, :writer)
    # => (all users who are BOTH editors and writers)

Later we'll support an `or` boolean; for now, do something like:

    User.with_roles(:editor) + User.with_roles(:writer)
    # => (all users who are EITHER editors and writers)

Find records without any bitmask set:

    User.without_roles
    # => (all users without a role)

Later we'll support finding records without a specific bitmask.

Adding Methods
--------------

You can add your own methods to the bitmasked attributes (similar to
named scopes):

    bitmask :other_attribute, :as => [:value1, :value2] do
      def worked?
        true
      end
    end

    user = User.first
    user.other_attribute.worked?
    # => true


Warning: Modifying possible values
----------------------------------

IMPORTANT: Once you have data using a bitmask, don't change the order
of the values, remove any values, or insert any new values in the `:as`
array anywhere except at the end.  You won't like the results.

Contributing and reporting issues
---------------------------------

Please feel free to fork & contribute fixes via GitHub pull requests.
The official repository for this project is
http://github.com/bruce/bitmask-attribute

Issues can be reported at
http://github.com/bruce/bitmask-attribute/issues

Credits
-------

Thanks to the following contributors:

* [Jason L Perry](http://github.com/ambethia)
* [Nicolas Fouché](http://github.com/nfo)

Copyright
---------

Copyright (c) 2007-2009 Bruce Williams. See LICENSE for details.

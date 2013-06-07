EenieMeenie
========

[![Gem Version](https://badge.fury.io/rb/eenie_meenie.png)](http://badge.fury.io/rb/eenie_meenie) [![Build Status](https://travis-ci.org/rthbound/eenie_meenie.png?branch=master)](https://travis-ci.org/rthbound/eenie_meenie) [![Coverage Status](https://coveralls.io/repos/rthbound/eenie_meenie/badge.png?branch=master)](https://coveralls.io/r/rthbound/eenie_meenie?branch=master) [![Code Climate](https://codeclimate.com/github/rthbound/eenie_meenie.png)](https://codeclimate.com/github/rthbound/eenie_meenie)

Decides to which experimental group a member of a population should be assigned.

Installation
------------

EenieMeenie is a Ruby gem, and can be installed using `gem install eenie_meenie` or by adding the following to your application's Gemfile:

    gem 'eenie_meenie', '0.1.1'

Usage
-----

When using this gem, you'll be able to:

1. Assign as a threshold a number somewhere in the range of (0,1] to each experimental group.
2. Assign a threshold of "DO NOT CARE" to any group by passing `false` instead of a number.
3. Tell it to which groups a member can be assigned.  Any group with a threshold should be included here (otherwise the threshold is pointless).
4. Tell it how to scope the member class (tell it which study, if you're using one member class for all studies)
5. Specify the population to be used when calculating whether a group's population threshold has been reached.

Example Configurations
----------------------

eenie_meenie users can specify the population
using the :members option, e.g.

```ruby
EenieMeenie::Assignment.new({
  member:  @some_member,
  members: MemberClass.where(something).joins(another),
  groups:  ["Experimental", "Control"],
  group_rules: {
    "Experimental" => { threshold: 0.51 },
    "Control"      => { threshold: 0.51 }
  }
})
```

Other examples ...

```ruby
# Control: Do not care  (chosen manually, if ever)
# Experimental A: %50   (randomly assign)
# Experimental B: %50   (randomly assign)

EenieMeenie::Assignment.new({
  groups: ["Experimental A", "Experimental B"],  # EenieMeenie's assignment options
  member: @obj,                                  # Member of population
  group_rules: {
    "Control"        => { threshold: false },    # Don't care
    "Experimental A" => { threshold: 0.5 },      # No more than 50%
    "Experimental B" => { threshold: 0.5 }       # No more than 50%
  },
  class_rules: { organization_id: 1}             # Only consider members belonging to Organization 1
}).execute!
```

```ruby
# Control:        %33.3   (randomly assign)
# Experimental A: %33.3   (randomly assign)
# Experimental B: %33.3   (randomly assign)

EenieMeenie::Assignment.new({
  groups: ["Control", "Experimental A", "Experimental B"], # EenieMeenie's assignment options
  member: @obj,                                            # Member of population
  group_rules: {
    "Control"         => { threshold: (1.0 / 3.0) },       # No more than one-third
    "Experimental A"  => { threshold: (1.0 / 3.0) },       # No more than one-third
    "Experimental B" => { threshold:  (1.0 / 3.0) }        # No more than one-third
  },
  class_rules: { organization_id: 1} # Only consider members belonging to Organization 1
}).execute!
```

```ruby
# Control:        %50         (randomly assign)
# Experimental:   %50         (randomly assign)
# Experimental A: Do not care (manually assign)
# Experimental B: Do not care (manually assign)

# If "Control" is too full, put them in "Experimental"          ...
# Later someone will choose whether they're in "Experimental A" ...
# or in "Experimental B"

EenieMeenie::Assignment.new({
  groups: ["Control", "Experimental"],       # EenieMeenie's assignment options
  member: @obj,                              # Member of population
  group_rules: {
    "Control"        => { threshold: 0.5 },  # No more than one half
    "Experimental"   => { threshold: 0.5 },  # No more than one half
    "Experimental A" => { threshold: false } # Don't care
    "Experimental B" => { threshold: false } # Don't care
  }
}).execute!
```

### Pull requests/issues

Use GitHub's issue tracker to report problems or request changes. Pull Requests are encouraged. Don't forget to add tests for any changes you'd like merged.

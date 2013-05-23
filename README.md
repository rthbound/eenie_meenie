EenieMeenie
========

This tool was written in order to play with some simple methods for assigning members of a population to one of two groups. The goal was initially to provide an algorithm that will limit the user's ability to predict which group a member will be assigned.

Installation
------------

EenieMeenie is a Ruby gem, and can be installed using `gem install eenie_meenie`

Usage
-----

EenieMeenie currently provides two algorithms for assigning members to experimental groups.

`EenieMeenie::Assignment` was the first algorithm, and was intended to handle situations where members of a population are to be assigned to ONE of TWO groups.  As I started working with a greater variety of research studies, I found the algorithm to be both overcomplicated and inadequate.

`EeenieMeenie::PolyAssignment` is a new algorithm.  With this algorithm you'll be able to:

1. Assign a threshold (a `Float` to represent percentage) to each experimental group.
2. Assign a threshold of "DO NOT CARE" to any group by passing `false` instead of a `Float`
3. Tell EeenieMeenie which groups can be assigned by the algorithm.  Any group with a threshold should be included here.
4. Tell it how to scope the member class (tell it which study, if you're using one member class for all studies)

Example Configurations
----------------------

```ruby
# Control: Do not care  (chosen manually, if ever)
# Experimental A: %50   (randomly assign)
# Experimental B: %50   (randomly assign)

EenieMeenie::Assignment.new({
  groups: ["Experimental A", "Experimental B"],  # EenieMeenie's assignment options
  member: @obj,                                  # Member of population
  group_rules: {
    "Control"         => { threshold: false },   # Don't care
    "Experimental A"  => { threshold: 0.5 },     # No more than 50%
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
  groups: ["Control", "Experimental A", "Experimental B"],      # EenieMeenie's assignment options
  member: @obj,                                      # Member of population
  group_rules: {
    "Control"         => { threshold: (1.0 / 3.0) },    # No more than one-third
    "Experimental A"  => { threshold: (1.0 / 3.0) },    # No more than one-third
    "Experimental B" => { threshold: (1.0 / 3.0) }     # No more than one-third
  },
  class_rules: { organization_id: 1} # Only consider members belonging to Organization 1
}).execute!
```

```ruby
# Control:        %50         (randomly assign)
# Experimental:   Do not care (randomly assign)
# Experimental A: Do not care (manually assign)
# Experimental B: Do not care (manually assign)

# If "Control" is too full, put them in "Experimental"          ...
# Later someone will choose whether they're in "Experimental A" ...
# or in "Experimental B"

EenieMeenie::Assignment.new({
  groups: ["Control", "Experimental"],       # EenieMeenie's assignment options
  member: @obj,                              # Member of population
  group_rules: {
    "Control"        => { threshold: 0.5 },   # No more than one-third
    "Experimental"   => { threshold: false }, # Don't care
    "Experimental A" => { threshold: false }  # Don't care
    "Experimental B" => { threshold: false }  # Don't care
  }
}).execute!
```

### Pull requests/issues

Please submit any useful pull requests through GitHub. Please report any bugs using Github's issue tracker

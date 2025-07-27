# Make things that are the same, the same. 
## Make things that are different, different.

When programming, we’re often trying to model real-world concepts. We create
classes or types to represent the user of the system, their team, their billing
status, etc. etc.

But the world is a messy place, and full of edge cases. We end up sticking on
little bits of extra functionality to accommodate some of these variations. And
that’s when we can get into trouble.

Unlike real life, computer systems are not messy. They are *exactly* what we
program them to be. Programming is the process of codifying logic. How we go
about doing that is up to us.

### A rule of thumb

One way we can think about codifying things is to consider if something is A or
B (or C, or D, etc.) and then make sure that we treat them as such.

When we have a requirement for there to be a regular user and an admin user, we
can think about if these are both instances of the same thing with some extra
permissions, or if they are in fact totally different concepts. In this
instance, they are probably more the same than they are different, so we make a
single User concept and mix in some additional behaviour somehow. The admin
nature of User is inherent to the User concept.

When we require there to be multiple types of document, say invoices and
receipts, we might decide that these things, though similar in some ways, are
fundamentally different in other ways. An invoice might be in various states
while a receipt is not, and a receipt may be publicly viewable while an invoice
is not. In this case, we might choose to represent these as two conceptually
different concepts, Invoice and Receipt.

### Why this helps

In the contrived examples above, it probably doesn’t matter if we represent
invoices as the same thing as receipts. Where it gets interesting is when
requirements change. Take for example a situation where we have a
classification system for movies. We take in data about the movie, say the
director, certification, IMDB score, etc. and we mung all that together somehow
to come up with a score.

Now let’s say we want to extend this system to also classify books. Books don’t
have a director, they have an author. Nor do they have a certification (but
perhaps they have some other “suitability” attribute?). What should we do? We
have two options:

1. We can extend our current classifier to switch to different logic based on
the type of thing we’re classifying, or 

2. We can create a new classifier to
classify only books, leaving our original movie classification logic unchanged.

This is a classic situation in which we need to ask ourselves “are these things
the same, or are they different?”

If we look at these requirements and view them as being effectively the same
thing, then we should work very hard to make our classification logic be
generally applicable to both movies and books. If we look at these requirements
and think they are substantially different, then we should recognise that by
making these things different in our code.

Introducing a new concept into a system isn’t something to be taken lightly.
Every concept we add increases the complexity of the system, so before jumping
into creating new concepts for every little deviation from the mean we should
really think if we actually *need* to incur that complexity or if we can get
away with thinking of the new thing in a way that already exists.

However, once a new concept is introduced, we should use it. Things should
either be A or B, and never “A-ish” or “B-ish”.

The world is a messy place, but our code isn’t. When we encounter ambiguity, we
should ask ourselves “is this the same as something we already have, or is it
different?” then make our code reflect that. 

## References
- [Sandi Metz - Make Everything The Same (2016)](href="https://sandimetz.com/blog/2016/6/9/make-everything-the-same")>

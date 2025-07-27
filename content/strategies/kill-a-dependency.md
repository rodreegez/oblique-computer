# Kill your dependencies

When building software, particularly for the web, particularly in certain situations, there can be a temptation to lean on the package manager of your language of choice to pull in bits of functionality as required. Package managers have become increasingly sophisticated, doing a fabulous job of "dependency resolution” i.e. ensuring all the packages you require all work with each other and generally making working with packages a breeze (`rake gems:install`, anyone?)

However, this convenience can come at a cost. When we lean too heavily on third-party libraries, we become like assemblers of Lego bricks, stacking together what’s available into something approximating what we want to build.

### The hidden costs

Every Lego brick we reach for is a potential point of failure. All code is a liability, code we don’t own doubly so.

We’ve all seen cases of “supply chain injection attacks” where a malicious actor has leveraged access to an innocuous library to create a backdoor in any applications that use that code.

When working with frameworks, libraries for these frameworks are often coupled to specific functionality and APIs. If the framework updates and the library does not, a single library can hold back the upgrading of the rest of the application.

It’s also easy for one dependency to in turn depend on one or two others. A new Ruby on Rails application, for example, lists tens of gems in the default Gemfile, while the resulting Gemfile.lock after installing those gems can list somewhere around one hundred total gems installed. In JavaScript-land, which massively leans into packages for a variety of reasons, these are rookie numbers.

### Pragmatism and exceptions

Of course, writing everything ourselves from scratch is not practical, and in some cases doing so would even be considered foolish. Rolling your own cryptography library is generally accepted to be a Bad Idea, and things like databases and operating systems benefit from decades of open source contributions and scrutiny.

As we touched on above, different languages have different cultural norms around dependencies. What could be considered a lot in Ruby or Python may be trivial numbers in another language, and that’s fine.  What might be an “essential” third-party library in one language might be a standard function in another. It’s not about killing *all* your dependencies, that would be impractical.

### Evaluate before you install

By all means pull in libraries and packages as required but, before stacking on yet another Lego brick, consider if you really need to open yourself up to another potential vulnerability, another potential botched update, another maintainer going rogue, or worse.

Evaluate the code of the libraries you’re pulling in. Ask yourself “if the maintainer of this library were to go away, where would that leave me?” Perhaps there is a robust community around the package and the bus factor is high, perhaps you’re a willing contributor and can step up if required.&#x20;

Also ask yourself if you could just implement the core functionality from the library directly. Perhaps a bespoke implementation would be leaner, providing just the functionality you need and nothing you don’t. Perhaps rolling your own will help you understand an important concept more fully. Perhaps doing it yourself will yield a more elegant solution in your specific circumstances.

Finally, ask yourself how many further packages does this package depend on in turn? Are they the ones you’d expect to see? Are those further dependencies well supported?

### The case for fewer dependencies

Codebases with fewer dependencies are generally simpler to work on. They are easier to reason about, stack traces are smaller, documentation is all in one place, etc.

You don’t need to kill every dependency, but you should be ready to. The goal isn’t austerity, it’s autonomy. Every library you choose not to install is one less system to patch, one less changelog to read, one less maintainer to trust.

You are a software developer, so write software. Write software you understand, and does exactly what you want it to. When the next package beckons, ask yourself: do I need this, or do I need to think harder?

Kill your dependencies. Or at least, don’t let them kill you.

## References
- [Mike Perham - Kill Your Dependencies (2016)](http://www.mikeperham.com/2016/02/09/kill-your-dependencies/)

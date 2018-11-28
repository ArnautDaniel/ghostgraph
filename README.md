# ghostgraph

ghostgraph is an attempt to make a program that can take a function from a file and generate a graphviz .dot file to show the context the program operates in.  Things like global variables,  visual representations of structures, arguments, local variables, would be included in the graph along with a step by step flow showing the programs state at each point in time.

I was hoping to figure out a way to transpile to an unevaluated language called "doggo" so I could simply implement a translation between it and the target language to support new languages, but I'm not sure that's such a great approach if I'm going to have to use a parser anyway.  I've been trying to figure out good ways to get started in reading through large codebases and being able to somewhat visualize the dataflow seems quite helpful.

I'm aware that programs like doxygen already have some of this functionality available but I wanted to try to do it myself.

The next step will probably involve rewriting it to use a parser rather than this weird ad-hoc method I'm using.  Guile seems to support LALR and PEG so at least I have some options.  

ghostgraph should be able to support different levels of context.  For instance you might want a 30,000 foot view or just the local context of a particular function.  It would also probably be prudent to attach a latex backend so you could also document the function or context alongside a fancy graph.

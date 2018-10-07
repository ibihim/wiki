# A Philosophy of Software Design
*by John Ousterhout*

## Table of Contents
1. [Introduction](#introduction)
2. [The Nature of Complexity](#the-nature-of-complexity)
3. [Working Code Isn't Enough](#working-code-isn't-enough)
4. [Modules Should Be Deep](#modules-should-be-deep)
5. [Information Hiding and Leakage](#information-hiding-and-leakage)
6. [General-Purpose Modules are Deeper](#general-purpose-modules-are-deeper)
7. [Different Layer, Different Abstraction](#different-layer,-different-abstraction)
8. [Pull Complexity Downwards](#pull-complexity-downwards)
9. [Better Together Or Better Apart?](#better-together-or-better-apart)
10. [Define Errors Out Of Existence](#define-errors-out-of-existence)
11. [Design Twice](#design-twice)
12. [Why Write Comments? The Four Excuses](#why-write-comments?-the-four-excuses)
13. [Comments Should Describe Things that Aren't Obvious from the Code](#comments-should-describe-things-that-aren't-obvious-from-the-code)
14. [Choosing Names](#choosing-names)
15. [Write The Comments First](#write-the-comments-first)
16. [Modifying Existing Code](#modifying-existing-code)
17. [Consistency](#consistency)
18. [Code Should be Obvious](#code-should-be-obvious)
19. [Software Trends](#software-trends)
20. [Designing for Performance](#designing-for-performance)
21. [Conclusion](#conclusion)


## Introduction

Complexity

* Complexity increases inevitably over the life of any program. The larger the program and the more people that work on it, the more difficult it is to manage complexity.
* The first approach is to eliminate complexity by making code simpler and more obvious. For example, complexity can be reduced by eliminating special cases or using identifiers in a consistent fashion.
* The second approach to complexity is to encapsulate it, so that programmers can work on a system without being exposed to all of its complexity at once (modular design).

Waterfall

* Unfortunately, the waterfall model rarely works well in software.
* It isn't possible to visualize the design for a large software system well enough to understand all of its implications before building anything.

Agile

* In agile development, the initial design focuses on a small subset of the overall functionality.
* By spreading out the design this way, problems with the initial design can be fixed while the system is still small.


## The Nature of Complexity

Complexity definition

* Complexity is anything related to the structure of a software system that makes it hard to understand and modify the system.
* Complexity is what a developer experiences at a particular point in time when trying to achieve a particular goal.
* Complexity doesn't necessarily relate to the overall size or functionality of the system. Large systems with sophisticated features, if such a system is easy to work on, is not complex.

Symptoms of complexity

* Change amplification: The first symptom of complexity is that a seemingly change requires code modifications in many different places.
* Cognitive load: The second symptom of complexity is cognitive load, which refers to how much a developer needs to know in order to complete a task. Sometimes an approach that requires more lines of code is actually simpler, because it reduces cognitive load (frameworks that make it possible to write applications with a couple of lines).
* Unknown unknowns: The third symptom of complexity is that it is not obvious which pieces of code must be modified to complete a task. This is the worst manifestation of complexity.

Causes of Complexity: dependencies and obscurity

* A **dependency** exists when a given piece of code cannot be understood and modified in isolation.
* **Obscurity** occurs when important information is not obvious. Obscurity comes about because of inadequate documentation. However, obscurity is also a design issue. If a system has a clean and obvious design, then it will need less documentation.

Complexity is incremental: it isn't caused by a single catastrophic error; it accumulates in lots of small chunks.


## Working Code Isn't Enough

Tactical programming

* Before long, some of the complexities will start causing problems.
* So you look for quick patches to work around any problems you encounter. This just creates more complexity, which then requires more patches.
* Pretty soon the code is a mess, but by this point things are so bad that it would take months of work to clean up.

Strategic programming

* Working code isn't enough
* most of the code in any system is written by extending the existing code base, so your most  important job as a developer is to facilitate those future extensions.

How much to invest?

* Up-front investment, won't be effective: Watefall.
* The best approach is to make lots of small investments on a continual basis, adding up to about 10-20% of your total development time.

Startups and investment

* Facebook: "Move fast and break things"
* Facebook has been spectaculary successful as a company, but its code base became a mess:
  - incomprehensible
  - unstable
  - few comments
  - few tests
  - painful to work with
* Eventually, changed the motto to "Move fast with solid infrastructure"


## Modules Should Be Deep

## Information Hiding and Leakage

## General-Purpose Modules are Deeper

## Different Layer, Different Abstraction

## Pull Complexity Downwards

## Better Together Or Better Apart?

## Define Errors Out Of Existence

## Design Twice

## Why Write Comments? The Four Excuses

## Comments Should Describe Things that Aren't Obvious from the Code

## Choosing Names

## Write The Comments First

## Modifying Existing Code

## Consistency

## Code Should be Obvious

## Software Trends

## Designing for Performance

## Conclusion

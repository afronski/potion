# Potion

## What it is?

**TL;DR**: Are you familiar with *nodeschool.io* initiative? We would like to build the same for community focused on *Erlang VM*.

Each *potion* is an interactive workshop about one particular topic. Assignments gathered in the particular workshop are ordered by a increasing difficulty. After selecting a specified task, you will receive details about how you should approach that particular topic, small code snippets and other valuable resources. After preparing a solution for that task, you ca either *run* your task in a testing environment and perform tests on your own, or *verify* that assignment by prepared set of tests. In both cases as a third argument (second one is an operation) you are passing a path and file name to the solution.

When solution will pass prepared test suite, your active assignment will be marked as a *completed*. If not, you will receive a status what is wrong and an error details if applicable.

## How to build and run it?

1. `mix escript.build`
2. `./potion`
3. Move around menu, choose proper option and start playing with assignments!

## How to create a new workshop?

Just *fork* the repository and start hacking! :wink:

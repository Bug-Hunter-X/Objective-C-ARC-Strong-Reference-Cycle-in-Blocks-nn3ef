# Objective-C ARC Strong Reference Cycle in Blocks

This repository demonstrates a common issue in Objective-C: strong reference cycles created within blocks when using Automatic Reference Counting (ARC).  The `bug.m` file shows the problematic code, resulting in memory leaks. The solution (`bugSolution.m`) illustrates how to resolve this using `weak` references to `self` within the block.
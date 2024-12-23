In Objective-C, a common yet subtle error arises when dealing with object ownership and memory management using ARC (Automatic Reference Counting).  Specifically, it involves strong reference cycles within blocks.  Consider this scenario:

```objectivec
@property (strong, nonatomic) MyObject *myObject;

- (void)someMethod {
    self.myObject = [[MyObject alloc] init];
    [self.myObject doSomethingWithCompletion:^(MyObject *obj) {
        // Strong reference cycle!  'self' is implicitly referenced in this block.
        // 'obj' is also a strong reference to self.myObject.
        // self -> myObject -> obj -> self
        [self useObject:obj];
    }];
}
```

The block captures `self` implicitly.  If `myObject`'s `doSomethingWithCompletion` method retains the completion block (and `self`) directly or indirectly, a strong reference cycle is formed: `self` strongly references `myObject`, and `myObject`'s completion block strongly references `self`. This prevents either object from being deallocated, resulting in memory leaks.
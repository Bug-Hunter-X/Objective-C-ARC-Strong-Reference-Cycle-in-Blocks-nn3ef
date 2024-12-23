To fix this, use a `weak` reference to `self` inside the block:

```objectivec
@property (strong, nonatomic) MyObject *myObject;

- (void)someMethod {
    self.myObject = [[MyObject alloc] init];
    __weak typeof(self) weakSelf = self; // Create a weak reference
    [self.myObject doSomethingWithCompletion:^(MyObject *obj) {
        // Check for nil to ensure self hasn't already been deallocated
        if (weakSelf) {
            [weakSelf useObject:obj];
        }
    }];
}
```

By declaring `weakSelf`, we break the strong reference cycle. The block now holds a weak reference to `self`, preventing the retain cycle. The `if (weakSelf)` check ensures that we avoid using `self` after it has been deallocated.
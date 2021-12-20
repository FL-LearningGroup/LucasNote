## C# bin vs obj Folder
https://www.codeproject.com/Articles/1247885/Csharp-bin-vs-obj-Folder

## Why need two folder(bin and obj)
So the next question which comes to our mind is why do we need compiling in two phases, why not just do it in one go. By doing the two phase compiling, we achieve incremental or conditional compiling.

When we work with big projects, we will have a lot of code files and we would like to only compile those code files which have changed. In the “obj” folder we have entry of each code file compilation. So we can know from the same which files exactly have changed, thus making compiling fast.

## Self Summary
+ in “obj” folder, we have compiled files for each source code file 
+ in “bin” folder, we have a single unit which links all individually compiled code files.

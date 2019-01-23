; ModuleID = 'function_3/main.c'
source_filename = "function_3/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@global = common dso_local global i32 0, align 4, !dbg !0

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @f() #0 !dbg !11 {
entry:
  call void @g(), !dbg !14
  ret void, !dbg !15
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @g() #0 !dbg !16 {
entry:
  store i32 123, i32* @global, align 4, !dbg !17
  ret void, !dbg !18
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !19 {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @f(), !dbg !22
  %0 = load i32, i32* @global, align 4, !dbg !23
  %cmp = icmp eq i32 %0, 123, !dbg !24
  %conv = zext i1 %cmp to i32, !dbg !24
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !25
  ret i32 0, !dbg !26
}

declare dso_local i32 @assert(...) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!7, !8, !9}
!llvm.ident = !{!10}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "global", scope: !2, file: !3, line: 3, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 7.0.1 (https://github.com/llvm-mirror/clang.git 4519e2637fcc4bf6e3049a0a80e6a5e7b97667cb) (https://github.com/llvm-mirror/llvm.git cd98f42d0747826062fc3d2d2fad383aedf58dd6)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "function_3/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!4 = !{}
!5 = !{!0}
!6 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!7 = !{i32 2, !"Dwarf Version", i32 4}
!8 = !{i32 2, !"Debug Info Version", i32 3}
!9 = !{i32 1, !"wchar_size", i32 4}
!10 = !{!"clang version 7.0.1 (https://github.com/llvm-mirror/clang.git 4519e2637fcc4bf6e3049a0a80e6a5e7b97667cb) (https://github.com/llvm-mirror/llvm.git cd98f42d0747826062fc3d2d2fad383aedf58dd6)"}
!11 = distinct !DISubprogram(name: "f", scope: !3, file: !3, line: 5, type: !12, isLocal: false, isDefinition: true, scopeLine: 6, isOptimized: false, unit: !2, retainedNodes: !4)
!12 = !DISubroutineType(types: !13)
!13 = !{null}
!14 = !DILocation(line: 9, column: 3, scope: !11)
!15 = !DILocation(line: 10, column: 1, scope: !11)
!16 = distinct !DISubprogram(name: "g", scope: !3, file: !3, line: 12, type: !12, isLocal: false, isDefinition: true, scopeLine: 13, isOptimized: false, unit: !2, retainedNodes: !4)
!17 = !DILocation(line: 14, column: 9, scope: !16)
!18 = !DILocation(line: 15, column: 1, scope: !16)
!19 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 17, type: !20, isLocal: false, isDefinition: true, scopeLine: 18, isOptimized: false, unit: !2, retainedNodes: !4)
!20 = !DISubroutineType(types: !21)
!21 = !{!6}
!22 = !DILocation(line: 19, column: 3, scope: !19)
!23 = !DILocation(line: 20, column: 10, scope: !19)
!24 = !DILocation(line: 20, column: 16, scope: !19)
!25 = !DILocation(line: 20, column: 3, scope: !19)
!26 = !DILocation(line: 21, column: 3, scope: !19)

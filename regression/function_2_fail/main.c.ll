; ModuleID = 'function_2_fail/main.c'
source_filename = "function_2_fail/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@global = common global i32 0, align 4, !dbg !0

; Function Attrs: noinline nounwind uwtable
define void @f() #0 !dbg !10 {
entry:
  call void @g(), !dbg !13
  ret void, !dbg !14
}

; Function Attrs: noinline nounwind uwtable
define void @g() #0 !dbg !15 {
entry:
  store i32 123, i32* @global, align 4, !dbg !16
  ret void, !dbg !17
}

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !18 {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @f(), !dbg !21
  %0 = load i32, i32* @global, align 4, !dbg !22
  %cmp = icmp ne i32 %0, 123, !dbg !23
  %conv = zext i1 %cmp to i32, !dbg !23
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !24
  ret i32 0, !dbg !25
}

declare i32 @assert(...) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!7, !8}
!llvm.ident = !{!9}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "global", scope: !2, file: !3, line: 1, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.0 (trunk 295264)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "function_2_fail/main.c", directory: "/home/rasika/llvm2goto/llvm2goto-regression-master")
!4 = !{}
!5 = !{!0}
!6 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!7 = !{i32 2, !"Dwarf Version", i32 4}
!8 = !{i32 2, !"Debug Info Version", i32 3}
!9 = !{!"clang version 5.0.0 (trunk 295264)"}
!10 = distinct !DISubprogram(name: "f", scope: !3, file: !3, line: 3, type: !11, isLocal: false, isDefinition: true, scopeLine: 4, isOptimized: false, unit: !2, variables: !4)
!11 = !DISubroutineType(types: !12)
!12 = !{null}
!13 = !DILocation(line: 7, column: 3, scope: !10)
!14 = !DILocation(line: 8, column: 1, scope: !10)
!15 = distinct !DISubprogram(name: "g", scope: !3, file: !3, line: 10, type: !11, isLocal: false, isDefinition: true, scopeLine: 11, isOptimized: false, unit: !2, variables: !4)
!16 = !DILocation(line: 12, column: 9, scope: !15)
!17 = !DILocation(line: 13, column: 1, scope: !15)
!18 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 15, type: !19, isLocal: false, isDefinition: true, scopeLine: 16, isOptimized: false, unit: !2, variables: !4)
!19 = !DISubroutineType(types: !20)
!20 = !{!6}
!21 = !DILocation(line: 17, column: 3, scope: !18)
!22 = !DILocation(line: 18, column: 10, scope: !18)
!23 = !DILocation(line: 18, column: 16, scope: !18)
!24 = !DILocation(line: 18, column: 3, scope: !18)
!25 = !DILocation(line: 19, column: 3, scope: !18)

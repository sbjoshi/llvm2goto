; ModuleID = '2002-10-13-BadLoad.c'
source_filename = "2002-10-13-BadLoad.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@window_size = global i64 65536, align 8, !dbg !0

; Function Attrs: noinline nounwind optnone uwtable
define i32 @test() #0 !dbg !13 {
entry:
  %0 = load i64, i64* @window_size, align 8, !dbg !15
  %conv = trunc i64 %0 to i32, !dbg !16
  ret i32 %conv, !dbg !17
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !18 {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  %call = call i32 @test(), !dbg !22
  %cmp = icmp eq i32 %call, 65536, !dbg !23
  %conv = zext i1 %cmp to i32, !dbg !23
  %call1 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !24
  ret i32 0, !dbg !25
}

declare i32 @assert(...) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!9, !10, !11}
!llvm.ident = !{!12}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "window_size", scope: !2, file: !3, line: 1, type: !8, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !5, globals: !7)
!3 = !DIFile(filename: "2002-10-13-BadLoad.c", directory: "/home/ubuntu/llvm2goto/regression/llvm_test_suit/single_source/unit-tests")
!4 = !{}
!5 = !{!6}
!6 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!7 = !{!0}
!8 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!9 = !{i32 2, !"Dwarf Version", i32 4}
!10 = !{i32 2, !"Debug Info Version", i32 3}
!11 = !{i32 1, !"wchar_size", i32 4}
!12 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!13 = distinct !DISubprogram(name: "test", scope: !3, file: !3, line: 3, type: !14, isLocal: false, isDefinition: true, scopeLine: 3, isOptimized: false, unit: !2, variables: !4)
!14 = !DISubroutineType(types: !5)
!15 = !DILocation(line: 4, column: 19, scope: !13)
!16 = !DILocation(line: 4, column: 9, scope: !13)
!17 = !DILocation(line: 4, column: 2, scope: !13)
!18 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 9, type: !19, isLocal: false, isDefinition: true, scopeLine: 9, isOptimized: false, unit: !2, variables: !4)
!19 = !DISubroutineType(types: !20)
!20 = !{!21}
!21 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!22 = !DILocation(line: 11, column: 9, scope: !18)
!23 = !DILocation(line: 11, column: 16, scope: !18)
!24 = !DILocation(line: 11, column: 2, scope: !18)
!25 = !DILocation(line: 12, column: 2, scope: !18)

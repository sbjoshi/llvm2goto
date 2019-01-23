; ModuleID = 'Pointer_Arithmetic3/main.c'
source_filename = "Pointer_Arithmetic3/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@nums = common dso_local global [2 x i32] zeroinitializer, align 4, !dbg !0
@p = common dso_local global i32* null, align 8, !dbg !6

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !17 {
entry:
  store i32 1, i32* getelementptr inbounds ([2 x i32], [2 x i32]* @nums, i64 0, i64 1), align 4, !dbg !20
  store i32* getelementptr inbounds ([2 x i32], [2 x i32]* @nums, i64 0, i64 0), i32** @p, align 8, !dbg !21
  %0 = load i32*, i32** @p, align 8, !dbg !22
  %incdec.ptr = getelementptr inbounds i32, i32* %0, i32 1, !dbg !22
  store i32* %incdec.ptr, i32** @p, align 8, !dbg !22
  %1 = load i32*, i32** @p, align 8, !dbg !23
  %2 = load i32, i32* %1, align 4, !dbg !24
  %cmp = icmp eq i32 %2, 1, !dbg !25
  %conv = zext i1 %cmp to i32, !dbg !25
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !26
  ret i32 0, !dbg !27
}

declare dso_local i32 @assert(...) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!13, !14, !15}
!llvm.ident = !{!16}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "nums", scope: !2, file: !3, line: 1, type: !10, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 7.0.1 (https://github.com/llvm-mirror/clang.git 4519e2637fcc4bf6e3049a0a80e6a5e7b97667cb) (https://github.com/llvm-mirror/llvm.git cd98f42d0747826062fc3d2d2fad383aedf58dd6)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "Pointer_Arithmetic3/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!4 = !{}
!5 = !{!0, !6}
!6 = !DIGlobalVariableExpression(var: !7, expr: !DIExpression())
!7 = distinct !DIGlobalVariable(name: "p", scope: !2, file: !3, line: 2, type: !8, isLocal: false, isDefinition: true)
!8 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DICompositeType(tag: DW_TAG_array_type, baseType: !9, size: 64, elements: !11)
!11 = !{!12}
!12 = !DISubrange(count: 2)
!13 = !{i32 2, !"Dwarf Version", i32 4}
!14 = !{i32 2, !"Debug Info Version", i32 3}
!15 = !{i32 1, !"wchar_size", i32 4}
!16 = !{!"clang version 7.0.1 (https://github.com/llvm-mirror/clang.git 4519e2637fcc4bf6e3049a0a80e6a5e7b97667cb) (https://github.com/llvm-mirror/llvm.git cd98f42d0747826062fc3d2d2fad383aedf58dd6)"}
!17 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 4, type: !18, isLocal: false, isDefinition: true, scopeLine: 4, isOptimized: false, unit: !2, retainedNodes: !4)
!18 = !DISubroutineType(types: !19)
!19 = !{!9}
!20 = !DILocation(line: 5, column: 11, scope: !17)
!21 = !DILocation(line: 6, column: 5, scope: !17)
!22 = !DILocation(line: 7, column: 4, scope: !17)
!23 = !DILocation(line: 9, column: 11, scope: !17)
!24 = !DILocation(line: 9, column: 10, scope: !17)
!25 = !DILocation(line: 9, column: 13, scope: !17)
!26 = !DILocation(line: 9, column: 3, scope: !17)
!27 = !DILocation(line: 10, column: 1, scope: !17)

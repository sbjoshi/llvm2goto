; ModuleID = 'function_2/main.c'
source_filename = "function_2/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@a = common global [1 x i32] zeroinitializer, align 4, !dbg !0

; Function Attrs: noinline nounwind uwtable
define i32 @f(i32 %i) #0 !dbg !13 {
entry:
  %i.addr = alloca i32, align 4
  store i32 %i, i32* %i.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %i.addr, metadata !16, metadata !17), !dbg !18
  %0 = load i32, i32* %i.addr, align 4, !dbg !19
  %add = add nsw i32 %0, 1, !dbg !20
  ret i32 %add, !dbg !21
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !22 {
entry:
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  call void @llvm.dbg.declare(metadata i32* %x, metadata !25, metadata !17), !dbg !26
  call void @llvm.dbg.declare(metadata i32* %y, metadata !27, metadata !17), !dbg !28
  %0 = load i32, i32* %y, align 4, !dbg !29
  store i32 %0, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @a, i64 0, i64 0), align 4, !dbg !30
  %1 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @a, i64 0, i64 0), align 4, !dbg !31
  %call = call i32 @f(i32 %1), !dbg !32
  store i32 %call, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @a, i64 0, i64 0), align 4, !dbg !33
  %2 = load i32, i32* getelementptr inbounds ([1 x i32], [1 x i32]* @a, i64 0, i64 0), align 4, !dbg !34
  %3 = load i32, i32* %y, align 4, !dbg !35
  %add = add nsw i32 %3, 1, !dbg !36
  %cmp = icmp eq i32 %2, %add, !dbg !37
  %conv = zext i1 %cmp to i32, !dbg !37
  %call1 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !38
  ret i32 0, !dbg !39
}

declare i32 @assert(...) #2

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!10, !11}
!llvm.ident = !{!12}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "a", scope: !2, file: !3, line: 8, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.0 (trunk 295264)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "function_2/main.c", directory: "/home/rasika/llvm2goto/llvm2goto-regression-master")
!4 = !{}
!5 = !{!0}
!6 = !DICompositeType(tag: DW_TAG_array_type, baseType: !7, size: 32, elements: !8)
!7 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!8 = !{!9}
!9 = !DISubrange(count: 1)
!10 = !{i32 2, !"Dwarf Version", i32 4}
!11 = !{i32 2, !"Debug Info Version", i32 3}
!12 = !{!"clang version 5.0.0 (trunk 295264)"}
!13 = distinct !DISubprogram(name: "f", scope: !3, file: !3, line: 1, type: !14, isLocal: false, isDefinition: true, scopeLine: 2, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!14 = !DISubroutineType(types: !15)
!15 = !{!7, !7}
!16 = !DILocalVariable(name: "i", arg: 1, scope: !13, file: !3, line: 1, type: !7)
!17 = !DIExpression()
!18 = !DILocation(line: 1, column: 11, scope: !13)
!19 = !DILocation(line: 3, column: 9, scope: !13)
!20 = !DILocation(line: 3, column: 10, scope: !13)
!21 = !DILocation(line: 3, column: 2, scope: !13)
!22 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 10, type: !23, isLocal: false, isDefinition: true, scopeLine: 10, isOptimized: false, unit: !2, variables: !4)
!23 = !DISubroutineType(types: !24)
!24 = !{!7}
!25 = !DILocalVariable(name: "x", scope: !22, file: !3, line: 11, type: !7)
!26 = !DILocation(line: 11, column: 6, scope: !22)
!27 = !DILocalVariable(name: "y", scope: !22, file: !3, line: 11, type: !7)
!28 = !DILocation(line: 11, column: 9, scope: !22)
!29 = !DILocation(line: 13, column: 9, scope: !22)
!30 = !DILocation(line: 13, column: 7, scope: !22)
!31 = !DILocation(line: 14, column: 11, scope: !22)
!32 = !DILocation(line: 14, column: 9, scope: !22)
!33 = !DILocation(line: 14, column: 7, scope: !22)
!34 = !DILocation(line: 16, column: 9, scope: !22)
!35 = !DILocation(line: 16, column: 17, scope: !22)
!36 = !DILocation(line: 16, column: 18, scope: !22)
!37 = !DILocation(line: 16, column: 14, scope: !22)
!38 = !DILocation(line: 16, column: 2, scope: !22)
!39 = !DILocation(line: 17, column: 1, scope: !22)
; ModuleID = 'function_4/main.c'
source_filename = "function_4/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@a = common dso_local global [13 x [13 x i32]] zeroinitializer, align 16, !dbg !0

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @f(i32 %i) #0 !dbg !14 {
entry:
  %i.addr = alloca i32, align 4
  store i32 %i, i32* %i.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %i.addr, metadata !17, metadata !DIExpression()), !dbg !18
  %0 = load i32, i32* %i.addr, align 4, !dbg !19
  %add = add nsw i32 %0, 1, !dbg !20
  ret i32 %add, !dbg !21
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !22 {
entry:
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  call void @llvm.dbg.declare(metadata i32* %x, metadata !25, metadata !DIExpression()), !dbg !26
  call void @llvm.dbg.declare(metadata i32* %y, metadata !27, metadata !DIExpression()), !dbg !28
  store i32 5, i32* getelementptr inbounds ([13 x [13 x i32]], [13 x [13 x i32]]* @a, i64 0, i64 10, i64 5), align 4, !dbg !29
  %0 = load i32, i32* getelementptr inbounds ([13 x [13 x i32]], [13 x [13 x i32]]* @a, i64 0, i64 10, i64 5), align 4, !dbg !30
  %cmp = icmp eq i32 %0, 5, !dbg !31
  %conv = zext i1 %cmp to i32, !dbg !31
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !32
  ret i32 0, !dbg !33
}

declare dso_local i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!10, !11, !12}
!llvm.ident = !{!13}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "a", scope: !2, file: !3, line: 8, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 8.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5, nameTableKind: None)
!3 = !DIFile(filename: "function_4/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!4 = !{}
!5 = !{!0}
!6 = !DICompositeType(tag: DW_TAG_array_type, baseType: !7, size: 5408, elements: !8)
!7 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!8 = !{!9, !9}
!9 = !DISubrange(count: 13)
!10 = !{i32 2, !"Dwarf Version", i32 4}
!11 = !{i32 2, !"Debug Info Version", i32 3}
!12 = !{i32 1, !"wchar_size", i32 4}
!13 = !{!"clang version 8.0.0 "}
!14 = distinct !DISubprogram(name: "f", scope: !3, file: !3, line: 1, type: !15, scopeLine: 2, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!15 = !DISubroutineType(types: !16)
!16 = !{!7, !7}
!17 = !DILocalVariable(name: "i", arg: 1, scope: !14, file: !3, line: 1, type: !7)
!18 = !DILocation(line: 1, column: 11, scope: !14)
!19 = !DILocation(line: 3, column: 9, scope: !14)
!20 = !DILocation(line: 3, column: 10, scope: !14)
!21 = !DILocation(line: 3, column: 2, scope: !14)
!22 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 10, type: !23, scopeLine: 10, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!23 = !DISubroutineType(types: !24)
!24 = !{!7}
!25 = !DILocalVariable(name: "x", scope: !22, file: !3, line: 11, type: !7)
!26 = !DILocation(line: 11, column: 6, scope: !22)
!27 = !DILocalVariable(name: "y", scope: !22, file: !3, line: 11, type: !7)
!28 = !DILocation(line: 11, column: 9, scope: !22)
!29 = !DILocation(line: 12, column: 11, scope: !22)
!30 = !DILocation(line: 15, column: 9, scope: !22)
!31 = !DILocation(line: 15, column: 18, scope: !22)
!32 = !DILocation(line: 15, column: 2, scope: !22)
!33 = !DILocation(line: 16, column: 1, scope: !22)

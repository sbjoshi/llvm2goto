; ModuleID = 'Multi_Dimensional_Array5/main.c'
source_filename = "Multi_Dimensional_Array5/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@g_134 = dso_local global i32 1, align 4, !dbg !0
@g_374 = dso_local global [1 x [1 x i32*]] [[1 x i32*] [i32* @g_134]], align 8, !dbg !6

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @func_79(i32* %p_80) #0 !dbg !17 {
entry:
  %p_80.addr = alloca i32*, align 8
  store i32* %p_80, i32** %p_80.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %p_80.addr, metadata !20, metadata !DIExpression()), !dbg !21
  %0 = load i32*, i32** %p_80.addr, align 8, !dbg !22
  store i32 0, i32* %0, align 4, !dbg !23
  %1 = load i32*, i32** %p_80.addr, align 8, !dbg !24
  %2 = load i32, i32* %1, align 4, !dbg !25
  %cmp = icmp eq i32 %2, 0, !dbg !26
  %conv = zext i1 %cmp to i32, !dbg !26
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !27
  %3 = load i32, i32* @g_134, align 4, !dbg !28
  %cmp1 = icmp eq i32 %3, 0, !dbg !29
  %conv2 = zext i1 %cmp1 to i32, !dbg !29
  %call3 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv2), !dbg !30
  ret void, !dbg !31
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @assert(...) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !32 {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  %0 = load i32*, i32** getelementptr inbounds ([1 x [1 x i32*]], [1 x [1 x i32*]]* @g_374, i64 0, i64 0, i64 0), align 8, !dbg !35
  call void @func_79(i32* %0), !dbg !36
  ret i32 0, !dbg !37
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!13, !14, !15}
!llvm.ident = !{!16}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "g_134", scope: !2, file: !3, line: 5, type: !10, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 8.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5, nameTableKind: None)
!3 = !DIFile(filename: "Multi_Dimensional_Array5/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!4 = !{}
!5 = !{!0, !6}
!6 = !DIGlobalVariableExpression(var: !7, expr: !DIExpression())
!7 = distinct !DIGlobalVariable(name: "g_374", scope: !2, file: !3, line: 6, type: !8, isLocal: false, isDefinition: true)
!8 = !DICompositeType(tag: DW_TAG_array_type, baseType: !9, size: 64, elements: !11)
!9 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !{!12, !12}
!12 = !DISubrange(count: 1)
!13 = !{i32 2, !"Dwarf Version", i32 4}
!14 = !{i32 2, !"Debug Info Version", i32 3}
!15 = !{i32 1, !"wchar_size", i32 4}
!16 = !{!"clang version 8.0.0 "}
!17 = distinct !DISubprogram(name: "func_79", scope: !3, file: !3, line: 9, type: !18, scopeLine: 10, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!18 = !DISubroutineType(types: !19)
!19 = !{null, !9}
!20 = !DILocalVariable(name: "p_80", arg: 1, scope: !17, file: !3, line: 9, type: !9)
!21 = !DILocation(line: 9, column: 20, scope: !17)
!22 = !DILocation(line: 11, column: 5, scope: !17)
!23 = !DILocation(line: 11, column: 10, scope: !17)
!24 = !DILocation(line: 12, column: 12, scope: !17)
!25 = !DILocation(line: 12, column: 11, scope: !17)
!26 = !DILocation(line: 12, column: 16, scope: !17)
!27 = !DILocation(line: 12, column: 4, scope: !17)
!28 = !DILocation(line: 13, column: 11, scope: !17)
!29 = !DILocation(line: 13, column: 16, scope: !17)
!30 = !DILocation(line: 13, column: 4, scope: !17)
!31 = !DILocation(line: 14, column: 1, scope: !17)
!32 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 16, type: !33, scopeLine: 17, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!33 = !DISubroutineType(types: !34)
!34 = !{!10}
!35 = !DILocation(line: 19, column: 12, scope: !32)
!36 = !DILocation(line: 19, column: 4, scope: !32)
!37 = !DILocation(line: 20, column: 4, scope: !32)

; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %a = alloca [3 x [3 x i32]], align 16
  %p1 = alloca [3 x i32]*, align 8
  %p2 = alloca i32*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata [3 x [3 x i32]]* %a, metadata !11, metadata !DIExpression()), !dbg !15
  call void @llvm.dbg.declare(metadata [3 x i32]** %p1, metadata !16, metadata !DIExpression()), !dbg !20
  %arrayidx = getelementptr inbounds [3 x [3 x i32]], [3 x [3 x i32]]* %a, i64 0, i64 1, !dbg !21
  store [3 x i32]* %arrayidx, [3 x i32]** %p1, align 8, !dbg !22
  call void @llvm.dbg.declare(metadata i32** %p2, metadata !23, metadata !DIExpression()), !dbg !25
  %0 = load [3 x i32]*, [3 x i32]** %p1, align 8, !dbg !26
  %arrayidx1 = getelementptr inbounds [3 x i32], [3 x i32]* %0, i64 0, i64 2, !dbg !27
  store i32* %arrayidx1, i32** %p2, align 8, !dbg !28
  %1 = load i32*, i32** %p2, align 8, !dbg !29
  store i32 100, i32* %1, align 4, !dbg !30
  %arrayidx2 = getelementptr inbounds [3 x [3 x i32]], [3 x [3 x i32]]* %a, i64 0, i64 1, !dbg !31
  %arrayidx3 = getelementptr inbounds [3 x i32], [3 x i32]* %arrayidx2, i64 0, i64 2, !dbg !31
  %2 = load i32, i32* %arrayidx3, align 4, !dbg !31
  %cmp = icmp eq i32 %2, 100, !dbg !32
  %conv = zext i1 %cmp to i32, !dbg !32
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !33
  ret i32 0, !dbg !34
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 8.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression/2d_array2")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 8.0.0 "}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 1, type: !8, scopeLine: 1, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "a", scope: !7, file: !1, line: 2, type: !12)
!12 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 288, elements: !13)
!13 = !{!14, !14}
!14 = !DISubrange(count: 3)
!15 = !DILocation(line: 2, column: 9, scope: !7)
!16 = !DILocalVariable(name: "p1", scope: !7, file: !1, line: 4, type: !17)
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !18, size: 64)
!18 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 96, elements: !19)
!19 = !{!14}
!20 = !DILocation(line: 4, column: 11, scope: !7)
!21 = !DILocation(line: 5, column: 11, scope: !7)
!22 = !DILocation(line: 5, column: 8, scope: !7)
!23 = !DILocalVariable(name: "p2", scope: !7, file: !1, line: 7, type: !24)
!24 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!25 = !DILocation(line: 7, column: 10, scope: !7)
!26 = !DILocation(line: 9, column: 13, scope: !7)
!27 = !DILocation(line: 9, column: 11, scope: !7)
!28 = !DILocation(line: 9, column: 8, scope: !7)
!29 = !DILocation(line: 10, column: 6, scope: !7)
!30 = !DILocation(line: 10, column: 9, scope: !7)
!31 = !DILocation(line: 11, column: 12, scope: !7)
!32 = !DILocation(line: 11, column: 20, scope: !7)
!33 = !DILocation(line: 11, column: 5, scope: !7)
!34 = !DILocation(line: 12, column: 5, scope: !7)
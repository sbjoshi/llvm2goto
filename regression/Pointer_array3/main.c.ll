; ModuleID = 'Pointer_array3/main.c'
source_filename = "Pointer_array3/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@__const.main.Y = private unnamed_addr constant [2 x i32] [i32 42, i32 13], align 4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @foo(i32** %A) #0 !dbg !7 {
entry:
  %A.addr = alloca i32**, align 8
  %_A = alloca i32*, align 8
  store i32** %A, i32*** %A.addr, align 8
  call void @llvm.dbg.declare(metadata i32*** %A.addr, metadata !13, metadata !DIExpression()), !dbg !14
  call void @llvm.dbg.declare(metadata i32** %_A, metadata !15, metadata !DIExpression()), !dbg !16
  %0 = load i32**, i32*** %A.addr, align 8, !dbg !17
  %arrayidx = getelementptr inbounds i32*, i32** %0, i64 0, !dbg !17
  %1 = load i32*, i32** %arrayidx, align 8, !dbg !17
  store i32* %1, i32** %_A, align 8, !dbg !16
  %2 = load i32*, i32** %_A, align 8, !dbg !18
  %arrayidx1 = getelementptr inbounds i32, i32* %2, i64 1, !dbg !18
  %3 = load i32, i32* %arrayidx1, align 4, !dbg !18
  ret i32 %3, !dbg !19
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !20 {
entry:
  %retval = alloca i32, align 4
  %Y = alloca [2 x i32], align 4
  %A = alloca [1 x i32*], align 8
  %x = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata [2 x i32]* %Y, metadata !23, metadata !DIExpression()), !dbg !27
  %0 = bitcast [2 x i32]* %Y to i8*, !dbg !27
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %0, i8* align 4 bitcast ([2 x i32]* @__const.main.Y to i8*), i64 8, i1 false), !dbg !27
  call void @llvm.dbg.declare(metadata [1 x i32*]* %A, metadata !28, metadata !DIExpression()), !dbg !32
  %arrayinit.begin = getelementptr inbounds [1 x i32*], [1 x i32*]* %A, i64 0, i64 0, !dbg !33
  %arraydecay = getelementptr inbounds [2 x i32], [2 x i32]* %Y, i32 0, i32 0, !dbg !34
  store i32* %arraydecay, i32** %arrayinit.begin, align 8, !dbg !33
  call void @llvm.dbg.declare(metadata i32* %x, metadata !35, metadata !DIExpression()), !dbg !36
  %arraydecay1 = getelementptr inbounds [1 x i32*], [1 x i32*]* %A, i32 0, i32 0, !dbg !37
  %call = call i32 @foo(i32** %arraydecay1), !dbg !38
  store i32 %call, i32* %x, align 4, !dbg !36
  %1 = load i32, i32* %x, align 4, !dbg !39
  %cmp = icmp eq i32 %1, 13, !dbg !40
  %conv = zext i1 %cmp to i32, !dbg !40
  %call2 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !41
  %2 = load i32, i32* %x, align 4, !dbg !42
  ret i32 %2, !dbg !43
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1) #2

declare dso_local i32 @assert(...) #3

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { argmemonly nounwind }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 8.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "Pointer_array3/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 8.0.0 "}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 3, type: !8, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !11}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!13 = !DILocalVariable(name: "A", arg: 1, scope: !7, file: !1, line: 3, type: !11)
!14 = !DILocation(line: 3, column: 15, scope: !7)
!15 = !DILocalVariable(name: "_A", scope: !7, file: !1, line: 5, type: !12)
!16 = !DILocation(line: 5, column: 9, scope: !7)
!17 = !DILocation(line: 5, column: 12, scope: !7)
!18 = !DILocation(line: 6, column: 10, scope: !7)
!19 = !DILocation(line: 6, column: 3, scope: !7)
!20 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 9, type: !21, scopeLine: 10, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!21 = !DISubroutineType(types: !22)
!22 = !{!10}
!23 = !DILocalVariable(name: "Y", scope: !20, file: !1, line: 11, type: !24)
!24 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 64, elements: !25)
!25 = !{!26}
!26 = !DISubrange(count: 2)
!27 = !DILocation(line: 11, column: 7, scope: !20)
!28 = !DILocalVariable(name: "A", scope: !20, file: !1, line: 12, type: !29)
!29 = !DICompositeType(tag: DW_TAG_array_type, baseType: !12, size: 64, elements: !30)
!30 = !{!31}
!31 = !DISubrange(count: 1)
!32 = !DILocation(line: 12, column: 9, scope: !20)
!33 = !DILocation(line: 12, column: 14, scope: !20)
!34 = !DILocation(line: 12, column: 16, scope: !20)
!35 = !DILocalVariable(name: "x", scope: !20, file: !1, line: 13, type: !10)
!36 = !DILocation(line: 13, column: 7, scope: !20)
!37 = !DILocation(line: 13, column: 13, scope: !20)
!38 = !DILocation(line: 13, column: 9, scope: !20)
!39 = !DILocation(line: 14, column: 10, scope: !20)
!40 = !DILocation(line: 14, column: 11, scope: !20)
!41 = !DILocation(line: 14, column: 3, scope: !20)
!42 = !DILocation(line: 15, column: 10, scope: !20)
!43 = !DILocation(line: 15, column: 3, scope: !20)

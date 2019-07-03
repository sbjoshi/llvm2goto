; ModuleID = 'insertion_sort_c/main.c'
source_filename = "insertion_sort_c/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @insertionSort(i32* %arr, i32 %n) #0 !dbg !7 {
entry:
  %arr.addr = alloca i32*, align 8
  %n.addr = alloca i32, align 4
  %i = alloca i32, align 4
  %key = alloca i32, align 4
  %j = alloca i32, align 4
  store i32* %arr, i32** %arr.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %arr.addr, metadata !12, metadata !DIExpression()), !dbg !13
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !14, metadata !DIExpression()), !dbg !15
  call void @llvm.dbg.declare(metadata i32* %i, metadata !16, metadata !DIExpression()), !dbg !17
  call void @llvm.dbg.declare(metadata i32* %key, metadata !18, metadata !DIExpression()), !dbg !19
  call void @llvm.dbg.declare(metadata i32* %j, metadata !20, metadata !DIExpression()), !dbg !21
  store i32 1, i32* %i, align 4, !dbg !22
  br label %for.cond, !dbg !24

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4, !dbg !25
  %1 = load i32, i32* %n.addr, align 4, !dbg !27
  %cmp = icmp slt i32 %0, %1, !dbg !28
  br i1 %cmp, label %for.body, label %for.end, !dbg !29

for.body:                                         ; preds = %for.cond
  %2 = load i32*, i32** %arr.addr, align 8, !dbg !30
  %3 = load i32, i32* %i, align 4, !dbg !32
  %idxprom = sext i32 %3 to i64, !dbg !30
  %arrayidx = getelementptr inbounds i32, i32* %2, i64 %idxprom, !dbg !30
  %4 = load i32, i32* %arrayidx, align 4, !dbg !30
  store i32 %4, i32* %key, align 4, !dbg !33
  %5 = load i32, i32* %i, align 4, !dbg !34
  %sub = sub nsw i32 %5, 1, !dbg !35
  store i32 %sub, i32* %j, align 4, !dbg !36
  br label %while.cond, !dbg !37

while.cond:                                       ; preds = %while.body, %for.body
  %6 = load i32, i32* %j, align 4, !dbg !38
  %cmp1 = icmp sge i32 %6, 0, !dbg !39
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !40

land.rhs:                                         ; preds = %while.cond
  %7 = load i32*, i32** %arr.addr, align 8, !dbg !41
  %8 = load i32, i32* %j, align 4, !dbg !42
  %idxprom2 = sext i32 %8 to i64, !dbg !41
  %arrayidx3 = getelementptr inbounds i32, i32* %7, i64 %idxprom2, !dbg !41
  %9 = load i32, i32* %arrayidx3, align 4, !dbg !41
  %10 = load i32, i32* %key, align 4, !dbg !43
  %cmp4 = icmp sgt i32 %9, %10, !dbg !44
  br label %land.end

land.end:                                         ; preds = %land.rhs, %while.cond
  %11 = phi i1 [ false, %while.cond ], [ %cmp4, %land.rhs ], !dbg !45
  br i1 %11, label %while.body, label %while.end, !dbg !37

while.body:                                       ; preds = %land.end
  %12 = load i32*, i32** %arr.addr, align 8, !dbg !46
  %13 = load i32, i32* %j, align 4, !dbg !48
  %idxprom5 = sext i32 %13 to i64, !dbg !46
  %arrayidx6 = getelementptr inbounds i32, i32* %12, i64 %idxprom5, !dbg !46
  %14 = load i32, i32* %arrayidx6, align 4, !dbg !46
  %15 = load i32*, i32** %arr.addr, align 8, !dbg !49
  %16 = load i32, i32* %j, align 4, !dbg !50
  %add = add nsw i32 %16, 1, !dbg !51
  %idxprom7 = sext i32 %add to i64, !dbg !49
  %arrayidx8 = getelementptr inbounds i32, i32* %15, i64 %idxprom7, !dbg !49
  store i32 %14, i32* %arrayidx8, align 4, !dbg !52
  %17 = load i32, i32* %j, align 4, !dbg !53
  %sub9 = sub nsw i32 %17, 1, !dbg !54
  store i32 %sub9, i32* %j, align 4, !dbg !55
  br label %while.cond, !dbg !37, !llvm.loop !56

while.end:                                        ; preds = %land.end
  %18 = load i32, i32* %key, align 4, !dbg !58
  %19 = load i32*, i32** %arr.addr, align 8, !dbg !59
  %20 = load i32, i32* %j, align 4, !dbg !60
  %add10 = add nsw i32 %20, 1, !dbg !61
  %idxprom11 = sext i32 %add10 to i64, !dbg !59
  %arrayidx12 = getelementptr inbounds i32, i32* %19, i64 %idxprom11, !dbg !59
  store i32 %18, i32* %arrayidx12, align 4, !dbg !62
  br label %for.inc, !dbg !63

for.inc:                                          ; preds = %while.end
  %21 = load i32, i32* %i, align 4, !dbg !64
  %inc = add nsw i32 %21, 1, !dbg !64
  store i32 %inc, i32* %i, align 4, !dbg !64
  br label %for.cond, !dbg !65, !llvm.loop !66

for.end:                                          ; preds = %for.cond
  ret void, !dbg !68
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !69 {
entry:
  %retval = alloca i32, align 4
  %N = alloca i32, align 4
  %arr = alloca [5 x i32], align 16
  %i = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %N, metadata !72, metadata !DIExpression()), !dbg !73
  store i32 5, i32* %N, align 4, !dbg !73
  call void @llvm.dbg.declare(metadata [5 x i32]* %arr, metadata !74, metadata !DIExpression()), !dbg !78
  %arraydecay = getelementptr inbounds [5 x i32], [5 x i32]* %arr, i32 0, i32 0, !dbg !79
  %0 = load i32, i32* %N, align 4, !dbg !80
  call void @insertionSort(i32* %arraydecay, i32 %0), !dbg !81
  call void @llvm.dbg.declare(metadata i32* %i, metadata !82, metadata !DIExpression()), !dbg !84
  store i32 1, i32* %i, align 4, !dbg !84
  br label %for.cond, !dbg !85

for.cond:                                         ; preds = %for.inc, %entry
  %1 = load i32, i32* %i, align 4, !dbg !86
  %2 = load i32, i32* %N, align 4, !dbg !88
  %cmp = icmp slt i32 %1, %2, !dbg !89
  br i1 %cmp, label %for.body, label %for.end, !dbg !90

for.body:                                         ; preds = %for.cond
  %3 = load i32, i32* %i, align 4, !dbg !91
  %idxprom = sext i32 %3 to i64, !dbg !93
  %arrayidx = getelementptr inbounds [5 x i32], [5 x i32]* %arr, i64 0, i64 %idxprom, !dbg !93
  %4 = load i32, i32* %arrayidx, align 4, !dbg !93
  %5 = load i32, i32* %i, align 4, !dbg !94
  %sub = sub nsw i32 %5, 1, !dbg !95
  %idxprom1 = sext i32 %sub to i64, !dbg !96
  %arrayidx2 = getelementptr inbounds [5 x i32], [5 x i32]* %arr, i64 0, i64 %idxprom1, !dbg !96
  %6 = load i32, i32* %arrayidx2, align 4, !dbg !96
  %cmp3 = icmp sge i32 %4, %6, !dbg !97
  %conv = zext i1 %cmp3 to i32, !dbg !97
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !98
  br label %for.inc, !dbg !99

for.inc:                                          ; preds = %for.body
  %7 = load i32, i32* %i, align 4, !dbg !100
  %inc = add nsw i32 %7, 1, !dbg !100
  store i32 %inc, i32* %i, align 4, !dbg !100
  br label %for.cond, !dbg !101, !llvm.loop !102

for.end:                                          ; preds = %for.cond
  %8 = load i32, i32* %retval, align 4, !dbg !104
  ret i32 %8, !dbg !104
}

declare dso_local i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 8.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "insertion_sort_c/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 8.0.0 "}
!7 = distinct !DISubprogram(name: "insertionSort", scope: !1, file: !1, line: 3, type: !8, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10, !11}
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!12 = !DILocalVariable(name: "arr", arg: 1, scope: !7, file: !1, line: 3, type: !10)
!13 = !DILocation(line: 3, column: 24, scope: !7)
!14 = !DILocalVariable(name: "n", arg: 2, scope: !7, file: !1, line: 3, type: !11)
!15 = !DILocation(line: 3, column: 35, scope: !7)
!16 = !DILocalVariable(name: "i", scope: !7, file: !1, line: 5, type: !11)
!17 = !DILocation(line: 5, column: 8, scope: !7)
!18 = !DILocalVariable(name: "key", scope: !7, file: !1, line: 5, type: !11)
!19 = !DILocation(line: 5, column: 11, scope: !7)
!20 = !DILocalVariable(name: "j", scope: !7, file: !1, line: 5, type: !11)
!21 = !DILocation(line: 5, column: 16, scope: !7)
!22 = !DILocation(line: 6, column: 11, scope: !23)
!23 = distinct !DILexicalBlock(scope: !7, file: !1, line: 6, column: 4)
!24 = !DILocation(line: 6, column: 9, scope: !23)
!25 = !DILocation(line: 6, column: 16, scope: !26)
!26 = distinct !DILexicalBlock(scope: !23, file: !1, line: 6, column: 4)
!27 = !DILocation(line: 6, column: 20, scope: !26)
!28 = !DILocation(line: 6, column: 18, scope: !26)
!29 = !DILocation(line: 6, column: 4, scope: !23)
!30 = !DILocation(line: 8, column: 14, scope: !31)
!31 = distinct !DILexicalBlock(scope: !26, file: !1, line: 7, column: 4)
!32 = !DILocation(line: 8, column: 18, scope: !31)
!33 = !DILocation(line: 8, column: 12, scope: !31)
!34 = !DILocation(line: 9, column: 12, scope: !31)
!35 = !DILocation(line: 9, column: 13, scope: !31)
!36 = !DILocation(line: 9, column: 10, scope: !31)
!37 = !DILocation(line: 11, column: 8, scope: !31)
!38 = !DILocation(line: 11, column: 15, scope: !31)
!39 = !DILocation(line: 11, column: 17, scope: !31)
!40 = !DILocation(line: 11, column: 22, scope: !31)
!41 = !DILocation(line: 11, column: 25, scope: !31)
!42 = !DILocation(line: 11, column: 29, scope: !31)
!43 = !DILocation(line: 11, column: 34, scope: !31)
!44 = !DILocation(line: 11, column: 32, scope: !31)
!45 = !DILocation(line: 0, scope: !31)
!46 = !DILocation(line: 13, column: 23, scope: !47)
!47 = distinct !DILexicalBlock(scope: !31, file: !1, line: 12, column: 8)
!48 = !DILocation(line: 13, column: 27, scope: !47)
!49 = !DILocation(line: 13, column: 12, scope: !47)
!50 = !DILocation(line: 13, column: 16, scope: !47)
!51 = !DILocation(line: 13, column: 17, scope: !47)
!52 = !DILocation(line: 13, column: 21, scope: !47)
!53 = !DILocation(line: 14, column: 16, scope: !47)
!54 = !DILocation(line: 14, column: 17, scope: !47)
!55 = !DILocation(line: 14, column: 14, scope: !47)
!56 = distinct !{!56, !37, !57}
!57 = !DILocation(line: 15, column: 8, scope: !31)
!58 = !DILocation(line: 16, column: 19, scope: !31)
!59 = !DILocation(line: 16, column: 8, scope: !31)
!60 = !DILocation(line: 16, column: 12, scope: !31)
!61 = !DILocation(line: 16, column: 13, scope: !31)
!62 = !DILocation(line: 16, column: 17, scope: !31)
!63 = !DILocation(line: 17, column: 4, scope: !31)
!64 = !DILocation(line: 6, column: 24, scope: !26)
!65 = !DILocation(line: 6, column: 4, scope: !26)
!66 = distinct !{!66, !29, !67}
!67 = !DILocation(line: 17, column: 4, scope: !23)
!68 = !DILocation(line: 18, column: 1, scope: !7)
!69 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 20, type: !70, scopeLine: 21, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!70 = !DISubroutineType(types: !71)
!71 = !{!11}
!72 = !DILocalVariable(name: "N", scope: !69, file: !1, line: 22, type: !11)
!73 = !DILocation(line: 22, column: 7, scope: !69)
!74 = !DILocalVariable(name: "arr", scope: !69, file: !1, line: 23, type: !75)
!75 = !DICompositeType(tag: DW_TAG_array_type, baseType: !11, size: 160, elements: !76)
!76 = !{!77}
!77 = !DISubrange(count: 5)
!78 = !DILocation(line: 23, column: 7, scope: !69)
!79 = !DILocation(line: 25, column: 17, scope: !69)
!80 = !DILocation(line: 25, column: 22, scope: !69)
!81 = !DILocation(line: 25, column: 3, scope: !69)
!82 = !DILocalVariable(name: "i", scope: !83, file: !1, line: 28, type: !11)
!83 = distinct !DILexicalBlock(scope: !69, file: !1, line: 28, column: 3)
!84 = !DILocation(line: 28, column: 11, scope: !83)
!85 = !DILocation(line: 28, column: 7, scope: !83)
!86 = !DILocation(line: 28, column: 17, scope: !87)
!87 = distinct !DILexicalBlock(scope: !83, file: !1, line: 28, column: 3)
!88 = !DILocation(line: 28, column: 19, scope: !87)
!89 = !DILocation(line: 28, column: 18, scope: !87)
!90 = !DILocation(line: 28, column: 3, scope: !83)
!91 = !DILocation(line: 30, column: 16, scope: !92)
!92 = distinct !DILexicalBlock(scope: !87, file: !1, line: 29, column: 3)
!93 = !DILocation(line: 30, column: 12, scope: !92)
!94 = !DILocation(line: 30, column: 26, scope: !92)
!95 = !DILocation(line: 30, column: 27, scope: !92)
!96 = !DILocation(line: 30, column: 22, scope: !92)
!97 = !DILocation(line: 30, column: 19, scope: !92)
!98 = !DILocation(line: 30, column: 5, scope: !92)
!99 = !DILocation(line: 31, column: 3, scope: !92)
!100 = !DILocation(line: 28, column: 24, scope: !87)
!101 = !DILocation(line: 28, column: 3, scope: !87)
!102 = distinct !{!102, !90, !103}
!103 = !DILocation(line: 31, column: 3, scope: !83)
!104 = !DILocation(line: 32, column: 1, scope: !69)

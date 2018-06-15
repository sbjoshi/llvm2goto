; ModuleID = 'insertion_sort_c/main.c'
source_filename = "insertion_sort_c/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define void @insertionSort(i32* %arr, i32 %n) #0 !dbg !6 {
entry:
  %arr.addr = alloca i32*, align 8
  %n.addr = alloca i32, align 4
  %i = alloca i32, align 4
  %key = alloca i32, align 4
  %j = alloca i32, align 4
  store i32* %arr, i32** %arr.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %arr.addr, metadata !11, metadata !12), !dbg !13
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !14, metadata !12), !dbg !15
  call void @llvm.dbg.declare(metadata i32* %i, metadata !16, metadata !12), !dbg !17
  call void @llvm.dbg.declare(metadata i32* %key, metadata !18, metadata !12), !dbg !19
  call void @llvm.dbg.declare(metadata i32* %j, metadata !20, metadata !12), !dbg !21
  store i32 1, i32* %i, align 4, !dbg !22
  br label %for.cond, !dbg !24

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4, !dbg !25
  %1 = load i32, i32* %n.addr, align 4, !dbg !28
  %cmp = icmp slt i32 %0, %1, !dbg !29
  br i1 %cmp, label %for.body, label %for.end, !dbg !30

for.body:                                         ; preds = %for.cond
  %2 = load i32*, i32** %arr.addr, align 8, !dbg !32
  %3 = load i32, i32* %i, align 4, !dbg !34
  %idxprom = sext i32 %3 to i64, !dbg !32
  %arrayidx = getelementptr inbounds i32, i32* %2, i64 %idxprom, !dbg !32
  %4 = load i32, i32* %arrayidx, align 4, !dbg !32
  store i32 %4, i32* %key, align 4, !dbg !35
  %5 = load i32, i32* %i, align 4, !dbg !36
  %sub = sub nsw i32 %5, 1, !dbg !37
  store i32 %sub, i32* %j, align 4, !dbg !38
  br label %while.cond, !dbg !39

while.cond:                                       ; preds = %while.body, %for.body
  %6 = load i32, i32* %j, align 4, !dbg !40
  %cmp1 = icmp sge i32 %6, 0, !dbg !42
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !43

land.rhs:                                         ; preds = %while.cond
  %7 = load i32*, i32** %arr.addr, align 8, !dbg !44
  %8 = load i32, i32* %j, align 4, !dbg !46
  %idxprom2 = sext i32 %8 to i64, !dbg !44
  %arrayidx3 = getelementptr inbounds i32, i32* %7, i64 %idxprom2, !dbg !44
  %9 = load i32, i32* %arrayidx3, align 4, !dbg !44
  %10 = load i32, i32* %key, align 4, !dbg !47
  %cmp4 = icmp sgt i32 %9, %10, !dbg !48
  br label %land.end

land.end:                                         ; preds = %land.rhs, %while.cond
  %11 = phi i1 [ false, %while.cond ], [ %cmp4, %land.rhs ]
  br i1 %11, label %while.body, label %while.end, !dbg !49

while.body:                                       ; preds = %land.end
  %12 = load i32*, i32** %arr.addr, align 8, !dbg !51
  %13 = load i32, i32* %j, align 4, !dbg !53
  %idxprom5 = sext i32 %13 to i64, !dbg !51
  %arrayidx6 = getelementptr inbounds i32, i32* %12, i64 %idxprom5, !dbg !51
  %14 = load i32, i32* %arrayidx6, align 4, !dbg !51
  %15 = load i32*, i32** %arr.addr, align 8, !dbg !54
  %16 = load i32, i32* %j, align 4, !dbg !55
  %add = add nsw i32 %16, 1, !dbg !56
  %idxprom7 = sext i32 %add to i64, !dbg !54
  %arrayidx8 = getelementptr inbounds i32, i32* %15, i64 %idxprom7, !dbg !54
  store i32 %14, i32* %arrayidx8, align 4, !dbg !57
  %17 = load i32, i32* %j, align 4, !dbg !58
  %sub9 = sub nsw i32 %17, 1, !dbg !59
  store i32 %sub9, i32* %j, align 4, !dbg !60
  br label %while.cond, !dbg !61, !llvm.loop !63

while.end:                                        ; preds = %land.end
  %18 = load i32, i32* %key, align 4, !dbg !65
  %19 = load i32*, i32** %arr.addr, align 8, !dbg !66
  %20 = load i32, i32* %j, align 4, !dbg !67
  %add10 = add nsw i32 %20, 1, !dbg !68
  %idxprom11 = sext i32 %add10 to i64, !dbg !66
  %arrayidx12 = getelementptr inbounds i32, i32* %19, i64 %idxprom11, !dbg !66
  store i32 %18, i32* %arrayidx12, align 4, !dbg !69
  br label %for.inc, !dbg !70

for.inc:                                          ; preds = %while.end
  %21 = load i32, i32* %i, align 4, !dbg !71
  %inc = add nsw i32 %21, 1, !dbg !71
  store i32 %inc, i32* %i, align 4, !dbg !71
  br label %for.cond, !dbg !73, !llvm.loop !74

for.end:                                          ; preds = %for.cond
  ret void, !dbg !77
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !78 {
entry:
  %retval = alloca i32, align 4
  %N = alloca i32, align 4
  %saved_stack = alloca i8*, align 8
  %i = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %N, metadata !81, metadata !12), !dbg !82
  store i32 5, i32* %N, align 4, !dbg !82
  %0 = load i32, i32* %N, align 4, !dbg !83
  %1 = zext i32 %0 to i64, !dbg !84
  %2 = call i8* @llvm.stacksave(), !dbg !84
  store i8* %2, i8** %saved_stack, align 8, !dbg !84
  %vla = alloca i32, i64 %1, align 16, !dbg !84
  call void @llvm.dbg.declare(metadata i32* %vla, metadata !85, metadata !89), !dbg !90
  %3 = load i32, i32* %N, align 4, !dbg !91
  call void @insertionSort(i32* %vla, i32 %3), !dbg !92
  call void @llvm.dbg.declare(metadata i32* %i, metadata !93, metadata !12), !dbg !95
  store i32 1, i32* %i, align 4, !dbg !95
  br label %for.cond, !dbg !96

for.cond:                                         ; preds = %for.inc, %entry
  %4 = load i32, i32* %i, align 4, !dbg !97
  %5 = load i32, i32* %N, align 4, !dbg !100
  %cmp = icmp slt i32 %4, %5, !dbg !101
  br i1 %cmp, label %for.body, label %for.end, !dbg !102

for.body:                                         ; preds = %for.cond
  %6 = load i32, i32* %i, align 4, !dbg !104
  %idxprom = sext i32 %6 to i64, !dbg !106
  %arrayidx = getelementptr inbounds i32, i32* %vla, i64 %idxprom, !dbg !106
  %7 = load i32, i32* %arrayidx, align 4, !dbg !106
  %8 = load i32, i32* %i, align 4, !dbg !107
  %sub = sub nsw i32 %8, 1, !dbg !108
  %idxprom1 = sext i32 %sub to i64, !dbg !109
  %arrayidx2 = getelementptr inbounds i32, i32* %vla, i64 %idxprom1, !dbg !109
  %9 = load i32, i32* %arrayidx2, align 4, !dbg !109
  %cmp3 = icmp sge i32 %7, %9, !dbg !110
  %conv = zext i1 %cmp3 to i32, !dbg !110
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !111
  br label %for.inc, !dbg !112

for.inc:                                          ; preds = %for.body
  %10 = load i32, i32* %i, align 4, !dbg !113
  %inc = add nsw i32 %10, 1, !dbg !113
  store i32 %inc, i32* %i, align 4, !dbg !113
  br label %for.cond, !dbg !115, !llvm.loop !116

for.end:                                          ; preds = %for.cond
  %11 = load i8*, i8** %saved_stack, align 8, !dbg !119
  call void @llvm.stackrestore(i8* %11), !dbg !119
  %12 = load i32, i32* %retval, align 4, !dbg !119
  ret i32 %12, !dbg !119
}

; Function Attrs: nounwind
declare i8* @llvm.stacksave() #2

declare i32 @assert(...) #3

; Function Attrs: nounwind
declare void @llvm.stackrestore(i8*) #2

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { nounwind }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4}
!llvm.ident = !{!5}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (trunk 295264)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "insertion_sort_c/main.c", directory: "/home/rasika/llvm2goto/llvm2goto-regression-master")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{!"clang version 5.0.0 (trunk 295264)"}
!6 = distinct !DISubprogram(name: "insertionSort", scope: !1, file: !1, line: 3, type: !7, isLocal: false, isDefinition: true, scopeLine: 4, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!7 = !DISubroutineType(types: !8)
!8 = !{null, !9, !10}
!9 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "arr", arg: 1, scope: !6, file: !1, line: 3, type: !9)
!12 = !DIExpression()
!13 = !DILocation(line: 3, column: 24, scope: !6)
!14 = !DILocalVariable(name: "n", arg: 2, scope: !6, file: !1, line: 3, type: !10)
!15 = !DILocation(line: 3, column: 35, scope: !6)
!16 = !DILocalVariable(name: "i", scope: !6, file: !1, line: 5, type: !10)
!17 = !DILocation(line: 5, column: 8, scope: !6)
!18 = !DILocalVariable(name: "key", scope: !6, file: !1, line: 5, type: !10)
!19 = !DILocation(line: 5, column: 11, scope: !6)
!20 = !DILocalVariable(name: "j", scope: !6, file: !1, line: 5, type: !10)
!21 = !DILocation(line: 5, column: 16, scope: !6)
!22 = !DILocation(line: 6, column: 11, scope: !23)
!23 = distinct !DILexicalBlock(scope: !6, file: !1, line: 6, column: 4)
!24 = !DILocation(line: 6, column: 9, scope: !23)
!25 = !DILocation(line: 6, column: 16, scope: !26)
!26 = !DILexicalBlockFile(scope: !27, file: !1, discriminator: 2)
!27 = distinct !DILexicalBlock(scope: !23, file: !1, line: 6, column: 4)
!28 = !DILocation(line: 6, column: 20, scope: !26)
!29 = !DILocation(line: 6, column: 18, scope: !26)
!30 = !DILocation(line: 6, column: 4, scope: !31)
!31 = !DILexicalBlockFile(scope: !23, file: !1, discriminator: 2)
!32 = !DILocation(line: 8, column: 14, scope: !33)
!33 = distinct !DILexicalBlock(scope: !27, file: !1, line: 7, column: 4)
!34 = !DILocation(line: 8, column: 18, scope: !33)
!35 = !DILocation(line: 8, column: 12, scope: !33)
!36 = !DILocation(line: 9, column: 12, scope: !33)
!37 = !DILocation(line: 9, column: 13, scope: !33)
!38 = !DILocation(line: 9, column: 10, scope: !33)
!39 = !DILocation(line: 11, column: 8, scope: !33)
!40 = !DILocation(line: 11, column: 15, scope: !41)
!41 = !DILexicalBlockFile(scope: !33, file: !1, discriminator: 2)
!42 = !DILocation(line: 11, column: 17, scope: !41)
!43 = !DILocation(line: 11, column: 22, scope: !41)
!44 = !DILocation(line: 11, column: 25, scope: !45)
!45 = !DILexicalBlockFile(scope: !33, file: !1, discriminator: 4)
!46 = !DILocation(line: 11, column: 29, scope: !45)
!47 = !DILocation(line: 11, column: 34, scope: !45)
!48 = !DILocation(line: 11, column: 32, scope: !45)
!49 = !DILocation(line: 11, column: 8, scope: !50)
!50 = !DILexicalBlockFile(scope: !33, file: !1, discriminator: 6)
!51 = !DILocation(line: 13, column: 23, scope: !52)
!52 = distinct !DILexicalBlock(scope: !33, file: !1, line: 12, column: 8)
!53 = !DILocation(line: 13, column: 27, scope: !52)
!54 = !DILocation(line: 13, column: 12, scope: !52)
!55 = !DILocation(line: 13, column: 16, scope: !52)
!56 = !DILocation(line: 13, column: 17, scope: !52)
!57 = !DILocation(line: 13, column: 21, scope: !52)
!58 = !DILocation(line: 14, column: 16, scope: !52)
!59 = !DILocation(line: 14, column: 17, scope: !52)
!60 = !DILocation(line: 14, column: 14, scope: !52)
!61 = !DILocation(line: 11, column: 8, scope: !62)
!62 = !DILexicalBlockFile(scope: !33, file: !1, discriminator: 8)
!63 = distinct !{!63, !39, !64}
!64 = !DILocation(line: 15, column: 8, scope: !33)
!65 = !DILocation(line: 16, column: 19, scope: !33)
!66 = !DILocation(line: 16, column: 8, scope: !33)
!67 = !DILocation(line: 16, column: 12, scope: !33)
!68 = !DILocation(line: 16, column: 13, scope: !33)
!69 = !DILocation(line: 16, column: 17, scope: !33)
!70 = !DILocation(line: 17, column: 4, scope: !33)
!71 = !DILocation(line: 6, column: 24, scope: !72)
!72 = !DILexicalBlockFile(scope: !27, file: !1, discriminator: 4)
!73 = !DILocation(line: 6, column: 4, scope: !72)
!74 = distinct !{!74, !75, !76}
!75 = !DILocation(line: 6, column: 4, scope: !23)
!76 = !DILocation(line: 17, column: 4, scope: !23)
!77 = !DILocation(line: 18, column: 1, scope: !6)
!78 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 20, type: !79, isLocal: false, isDefinition: true, scopeLine: 21, isOptimized: false, unit: !0, variables: !2)
!79 = !DISubroutineType(types: !80)
!80 = !{!10}
!81 = !DILocalVariable(name: "N", scope: !78, file: !1, line: 22, type: !10)
!82 = !DILocation(line: 22, column: 7, scope: !78)
!83 = !DILocation(line: 23, column: 11, scope: !78)
!84 = !DILocation(line: 23, column: 3, scope: !78)
!85 = !DILocalVariable(name: "arr", scope: !78, file: !1, line: 23, type: !86)
!86 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, elements: !87)
!87 = !{!88}
!88 = !DISubrange(count: -1)
!89 = !DIExpression(DW_OP_deref)
!90 = !DILocation(line: 23, column: 7, scope: !78)
!91 = !DILocation(line: 25, column: 22, scope: !78)
!92 = !DILocation(line: 25, column: 3, scope: !78)
!93 = !DILocalVariable(name: "i", scope: !94, file: !1, line: 28, type: !10)
!94 = distinct !DILexicalBlock(scope: !78, file: !1, line: 28, column: 3)
!95 = !DILocation(line: 28, column: 11, scope: !94)
!96 = !DILocation(line: 28, column: 7, scope: !94)
!97 = !DILocation(line: 28, column: 17, scope: !98)
!98 = !DILexicalBlockFile(scope: !99, file: !1, discriminator: 2)
!99 = distinct !DILexicalBlock(scope: !94, file: !1, line: 28, column: 3)
!100 = !DILocation(line: 28, column: 19, scope: !98)
!101 = !DILocation(line: 28, column: 18, scope: !98)
!102 = !DILocation(line: 28, column: 3, scope: !103)
!103 = !DILexicalBlockFile(scope: !94, file: !1, discriminator: 2)
!104 = !DILocation(line: 30, column: 16, scope: !105)
!105 = distinct !DILexicalBlock(scope: !99, file: !1, line: 29, column: 3)
!106 = !DILocation(line: 30, column: 12, scope: !105)
!107 = !DILocation(line: 30, column: 26, scope: !105)
!108 = !DILocation(line: 30, column: 27, scope: !105)
!109 = !DILocation(line: 30, column: 22, scope: !105)
!110 = !DILocation(line: 30, column: 19, scope: !105)
!111 = !DILocation(line: 30, column: 5, scope: !105)
!112 = !DILocation(line: 31, column: 3, scope: !105)
!113 = !DILocation(line: 28, column: 24, scope: !114)
!114 = !DILexicalBlockFile(scope: !99, file: !1, discriminator: 4)
!115 = !DILocation(line: 28, column: 3, scope: !114)
!116 = distinct !{!116, !117, !118}
!117 = !DILocation(line: 28, column: 3, scope: !94)
!118 = !DILocation(line: 31, column: 3, scope: !94)
!119 = !DILocation(line: 32, column: 1, scope: !78)

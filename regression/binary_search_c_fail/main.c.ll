; ModuleID = 'binary_search_c_fail/main.c'
source_filename = "binary_search_c_fail/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !6 {
entry:
  %retval = alloca i32, align 4
  %first = alloca i32, align 4
  %last = alloca i32, align 4
  %middle = alloca i32, align 4
  %n = alloca i32, align 4
  %search = alloca i32, align 4
  %array = alloca [10 x i32], align 16
  %found = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %first, metadata !10, metadata !11), !dbg !12
  call void @llvm.dbg.declare(metadata i32* %last, metadata !13, metadata !11), !dbg !14
  call void @llvm.dbg.declare(metadata i32* %middle, metadata !15, metadata !11), !dbg !16
  call void @llvm.dbg.declare(metadata i32* %n, metadata !17, metadata !11), !dbg !18
  store i32 5, i32* %n, align 4, !dbg !18
  call void @llvm.dbg.declare(metadata i32* %search, metadata !19, metadata !11), !dbg !20
  call void @llvm.dbg.declare(metadata [10 x i32]* %array, metadata !21, metadata !11), !dbg !25
  call void @llvm.dbg.declare(metadata i32* %found, metadata !26, metadata !11), !dbg !27
  store i32 0, i32* %found, align 4, !dbg !27
  store i32 0, i32* %first, align 4, !dbg !28
  %0 = load i32, i32* %n, align 4, !dbg !29
  %sub = sub nsw i32 %0, 1, !dbg !30
  store i32 %sub, i32* %last, align 4, !dbg !31
  %1 = load i32, i32* %first, align 4, !dbg !32
  %2 = load i32, i32* %last, align 4, !dbg !33
  %add = add nsw i32 %1, %2, !dbg !34
  %div = sdiv i32 %add, 2, !dbg !35
  store i32 %div, i32* %middle, align 4, !dbg !36
  br label %while.cond, !dbg !37

while.cond:                                       ; preds = %if.end12, %entry
  %3 = load i32, i32* %first, align 4, !dbg !38
  %4 = load i32, i32* %last, align 4, !dbg !40
  %cmp = icmp slt i32 %3, %4, !dbg !41
  br i1 %cmp, label %while.body, label %while.end, !dbg !42

while.body:                                       ; preds = %while.cond
  %5 = load i32, i32* %middle, align 4, !dbg !43
  %6 = load i32, i32* %first, align 4, !dbg !45
  %cmp1 = icmp sge i32 %5, %6, !dbg !46
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !47

land.rhs:                                         ; preds = %while.body
  %7 = load i32, i32* %middle, align 4, !dbg !48
  %8 = load i32, i32* %last, align 4, !dbg !50
  %cmp2 = icmp sle i32 %7, %8, !dbg !51
  br label %land.end

land.end:                                         ; preds = %land.rhs, %while.body
  %9 = phi i1 [ false, %while.body ], [ %cmp2, %land.rhs ]
  %land.ext = zext i1 %9 to i32, !dbg !52
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %land.ext), !dbg !54
  %10 = load i32, i32* %middle, align 4, !dbg !55
  %idxprom = sext i32 %10 to i64, !dbg !57
  %arrayidx = getelementptr inbounds [10 x i32], [10 x i32]* %array, i64 0, i64 %idxprom, !dbg !57
  %11 = load i32, i32* %arrayidx, align 4, !dbg !57
  %12 = load i32, i32* %search, align 4, !dbg !58
  %cmp3 = icmp slt i32 %11, %12, !dbg !59
  br i1 %cmp3, label %if.then, label %if.else, !dbg !60

if.then:                                          ; preds = %land.end
  %13 = load i32, i32* %middle, align 4, !dbg !61
  %add4 = add nsw i32 %13, 1, !dbg !62
  store i32 %add4, i32* %first, align 4, !dbg !63
  br label %if.end12, !dbg !64

if.else:                                          ; preds = %land.end
  %14 = load i32, i32* %middle, align 4, !dbg !65
  %idxprom5 = sext i32 %14 to i64, !dbg !67
  %arrayidx6 = getelementptr inbounds [10 x i32], [10 x i32]* %array, i64 0, i64 %idxprom5, !dbg !67
  %15 = load i32, i32* %arrayidx6, align 4, !dbg !67
  %16 = load i32, i32* %search, align 4, !dbg !68
  %cmp7 = icmp eq i32 %15, %16, !dbg !69
  br i1 %cmp7, label %if.then8, label %if.else10, !dbg !70

if.then8:                                         ; preds = %if.else
  %17 = load i32, i32* %found, align 4, !dbg !71
  %add9 = add nsw i32 %17, 1, !dbg !73
  store i32 %add9, i32* %found, align 4, !dbg !74
  br label %while.end, !dbg !75

if.else10:                                        ; preds = %if.else
  %18 = load i32, i32* %middle, align 4, !dbg !76
  %sub11 = sub nsw i32 %18, 1, !dbg !77
  store i32 %sub11, i32* %last, align 4, !dbg !78
  br label %if.end

if.end:                                           ; preds = %if.else10
  br label %if.end12

if.end12:                                         ; preds = %if.end, %if.then
  %19 = load i32, i32* %first, align 4, !dbg !79
  %20 = load i32, i32* %last, align 4, !dbg !80
  %add13 = add nsw i32 %19, %20, !dbg !81
  %div14 = sdiv i32 %add13, 2, !dbg !82
  store i32 %div14, i32* %middle, align 4, !dbg !83
  br label %while.cond, !dbg !84, !llvm.loop !86

while.end:                                        ; preds = %if.then8, %while.cond
  %21 = load i32, i32* %first, align 4, !dbg !88
  %22 = load i32, i32* %last, align 4, !dbg !89
  %cmp15 = icmp sgt i32 %21, %22, !dbg !90
  br i1 %cmp15, label %land.lhs.true, label %lor.rhs, !dbg !91

land.lhs.true:                                    ; preds = %while.end
  %23 = load i32, i32* %found, align 4, !dbg !92
  %cmp16 = icmp eq i32 %23, 0, !dbg !93
  br i1 %cmp16, label %lor.end, label %lor.rhs, !dbg !94

lor.rhs:                                          ; preds = %land.lhs.true, %while.end
  %24 = load i32, i32* %first, align 4, !dbg !95
  %25 = load i32, i32* %last, align 4, !dbg !96
  %cmp17 = icmp sle i32 %24, %25, !dbg !97
  br i1 %cmp17, label %land.rhs18, label %land.end20, !dbg !98

land.rhs18:                                       ; preds = %lor.rhs
  %26 = load i32, i32* %found, align 4, !dbg !99
  %cmp19 = icmp sgt i32 %26, 0, !dbg !101
  br label %land.end20

land.end20:                                       ; preds = %land.rhs18, %lor.rhs
  %27 = phi i1 [ false, %lor.rhs ], [ %cmp19, %land.rhs18 ]
  br label %lor.end, !dbg !102

lor.end:                                          ; preds = %land.end20, %land.lhs.true
  %28 = phi i1 [ true, %land.lhs.true ], [ %27, %land.end20 ]
  %lor.ext = zext i1 %28 to i32, !dbg !104
  %call22 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %lor.ext), !dbg !106
  ret i32 0, !dbg !107
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @assert(...) #2

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4}
!llvm.ident = !{!5}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (trunk 295264)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "binary_search_c_fail/main.c", directory: "/home/rasika/llvm2goto/llvm2goto-regression-master")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{!"clang version 5.0.0 (trunk 295264)"}
!6 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 1, type: !7, isLocal: false, isDefinition: true, scopeLine: 2, isOptimized: false, unit: !0, variables: !2)
!7 = !DISubroutineType(types: !8)
!8 = !{!9}
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DILocalVariable(name: "first", scope: !6, file: !1, line: 3, type: !9)
!11 = !DIExpression()
!12 = !DILocation(line: 3, column: 8, scope: !6)
!13 = !DILocalVariable(name: "last", scope: !6, file: !1, line: 3, type: !9)
!14 = !DILocation(line: 3, column: 15, scope: !6)
!15 = !DILocalVariable(name: "middle", scope: !6, file: !1, line: 3, type: !9)
!16 = !DILocation(line: 3, column: 21, scope: !6)
!17 = !DILocalVariable(name: "n", scope: !6, file: !1, line: 4, type: !9)
!18 = !DILocation(line: 4, column: 8, scope: !6)
!19 = !DILocalVariable(name: "search", scope: !6, file: !1, line: 5, type: !9)
!20 = !DILocation(line: 5, column: 8, scope: !6)
!21 = !DILocalVariable(name: "array", scope: !6, file: !1, line: 6, type: !22)
!22 = !DICompositeType(tag: DW_TAG_array_type, baseType: !9, size: 320, elements: !23)
!23 = !{!24}
!24 = !DISubrange(count: 10)
!25 = !DILocation(line: 6, column: 8, scope: !6)
!26 = !DILocalVariable(name: "found", scope: !6, file: !1, line: 8, type: !9)
!27 = !DILocation(line: 8, column: 8, scope: !6)
!28 = !DILocation(line: 10, column: 10, scope: !6)
!29 = !DILocation(line: 11, column: 11, scope: !6)
!30 = !DILocation(line: 11, column: 13, scope: !6)
!31 = !DILocation(line: 11, column: 9, scope: !6)
!32 = !DILocation(line: 12, column: 14, scope: !6)
!33 = !DILocation(line: 12, column: 20, scope: !6)
!34 = !DILocation(line: 12, column: 19, scope: !6)
!35 = !DILocation(line: 12, column: 25, scope: !6)
!36 = !DILocation(line: 12, column: 11, scope: !6)
!37 = !DILocation(line: 14, column: 4, scope: !6)
!38 = !DILocation(line: 14, column: 11, scope: !39)
!39 = !DILexicalBlockFile(scope: !6, file: !1, discriminator: 2)
!40 = !DILocation(line: 14, column: 19, scope: !39)
!41 = !DILocation(line: 14, column: 17, scope: !39)
!42 = !DILocation(line: 14, column: 4, scope: !39)
!43 = !DILocation(line: 17, column: 14, scope: !44)
!44 = distinct !DILexicalBlock(scope: !6, file: !1, line: 14, column: 25)
!45 = !DILocation(line: 17, column: 24, scope: !44)
!46 = !DILocation(line: 17, column: 21, scope: !44)
!47 = !DILocation(line: 17, column: 30, scope: !44)
!48 = !DILocation(line: 17, column: 33, scope: !49)
!49 = !DILexicalBlockFile(scope: !44, file: !1, discriminator: 2)
!50 = !DILocation(line: 17, column: 42, scope: !49)
!51 = !DILocation(line: 17, column: 39, scope: !49)
!52 = !DILocation(line: 17, column: 30, scope: !53)
!53 = !DILexicalBlockFile(scope: !44, file: !1, discriminator: 4)
!54 = !DILocation(line: 17, column: 7, scope: !53)
!55 = !DILocation(line: 19, column: 17, scope: !56)
!56 = distinct !DILexicalBlock(scope: !44, file: !1, line: 19, column: 11)
!57 = !DILocation(line: 19, column: 11, scope: !56)
!58 = !DILocation(line: 19, column: 27, scope: !56)
!59 = !DILocation(line: 19, column: 25, scope: !56)
!60 = !DILocation(line: 19, column: 11, scope: !44)
!61 = !DILocation(line: 20, column: 18, scope: !56)
!62 = !DILocation(line: 20, column: 25, scope: !56)
!63 = !DILocation(line: 20, column: 16, scope: !56)
!64 = !DILocation(line: 20, column: 10, scope: !56)
!65 = !DILocation(line: 22, column: 22, scope: !66)
!66 = distinct !DILexicalBlock(scope: !56, file: !1, line: 22, column: 16)
!67 = !DILocation(line: 22, column: 16, scope: !66)
!68 = !DILocation(line: 22, column: 33, scope: !66)
!69 = !DILocation(line: 22, column: 30, scope: !66)
!70 = !DILocation(line: 22, column: 16, scope: !56)
!71 = !DILocation(line: 23, column: 18, scope: !72)
!72 = distinct !DILexicalBlock(scope: !66, file: !1, line: 22, column: 41)
!73 = !DILocation(line: 23, column: 24, scope: !72)
!74 = !DILocation(line: 23, column: 16, scope: !72)
!75 = !DILocation(line: 24, column: 10, scope: !72)
!76 = !DILocation(line: 27, column: 17, scope: !66)
!77 = !DILocation(line: 27, column: 24, scope: !66)
!78 = !DILocation(line: 27, column: 15, scope: !66)
!79 = !DILocation(line: 29, column: 17, scope: !44)
!80 = !DILocation(line: 29, column: 25, scope: !44)
!81 = !DILocation(line: 29, column: 23, scope: !44)
!82 = !DILocation(line: 29, column: 30, scope: !44)
!83 = !DILocation(line: 29, column: 14, scope: !44)
!84 = !DILocation(line: 14, column: 4, scope: !85)
!85 = !DILexicalBlockFile(scope: !6, file: !1, discriminator: 4)
!86 = distinct !{!86, !37, !87}
!87 = !DILocation(line: 31, column: 4, scope: !6)
!88 = !DILocation(line: 33, column: 13, scope: !6)
!89 = !DILocation(line: 33, column: 21, scope: !6)
!90 = !DILocation(line: 33, column: 19, scope: !6)
!91 = !DILocation(line: 33, column: 27, scope: !6)
!92 = !DILocation(line: 33, column: 30, scope: !39)
!93 = !DILocation(line: 33, column: 35, scope: !39)
!94 = !DILocation(line: 33, column: 40, scope: !39)
!95 = !DILocation(line: 33, column: 45, scope: !85)
!96 = !DILocation(line: 33, column: 52, scope: !85)
!97 = !DILocation(line: 33, column: 50, scope: !85)
!98 = !DILocation(line: 33, column: 58, scope: !85)
!99 = !DILocation(line: 33, column: 61, scope: !100)
!100 = !DILexicalBlockFile(scope: !6, file: !1, discriminator: 6)
!101 = !DILocation(line: 33, column: 66, scope: !100)
!102 = !DILocation(line: 33, column: 40, scope: !103)
!103 = !DILexicalBlockFile(scope: !6, file: !1, discriminator: 8)
!104 = !DILocation(line: 33, column: 40, scope: !105)
!105 = !DILexicalBlockFile(scope: !6, file: !1, discriminator: 10)
!106 = !DILocation(line: 33, column: 4, scope: !105)
!107 = !DILocation(line: 34, column: 4, scope: !6)

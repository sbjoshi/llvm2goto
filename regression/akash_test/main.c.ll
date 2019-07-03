; ModuleID = 'akash_test/main.c'
source_filename = "akash_test/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %first = alloca i32, align 4
  %last = alloca i32, align 4
  %middle = alloca i32, align 4
  %n = alloca i32, align 4
  %search = alloca i32, align 4
  %array = alloca [10 x i32], align 16
  %found = alloca i32, align 4
  %cmp119 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %first, metadata !11, metadata !DIExpression()), !dbg !12
  call void @llvm.dbg.declare(metadata i32* %last, metadata !13, metadata !DIExpression()), !dbg !14
  call void @llvm.dbg.declare(metadata i32* %middle, metadata !15, metadata !DIExpression()), !dbg !16
  call void @llvm.dbg.declare(metadata i32* %n, metadata !17, metadata !DIExpression()), !dbg !18
  store i32 5, i32* %n, align 4, !dbg !18
  call void @llvm.dbg.declare(metadata i32* %search, metadata !19, metadata !DIExpression()), !dbg !20
  call void @llvm.dbg.declare(metadata [10 x i32]* %array, metadata !21, metadata !DIExpression()), !dbg !25
  call void @llvm.dbg.declare(metadata i32* %found, metadata !26, metadata !DIExpression()), !dbg !27
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

while.cond:                                       ; preds = %if.end16, %entry
  %3 = load i32, i32* %first, align 4, !dbg !38
  %4 = load i32, i32* %last, align 4, !dbg !39
  %cmp = icmp sle i32 %3, %4, !dbg !40
  br i1 %cmp, label %while.body, label %while.end, !dbg !37

while.body:                                       ; preds = %while.cond
  %5 = load i32, i32* %middle, align 4, !dbg !41
  %6 = load i32, i32* %first, align 4, !dbg !43
  %cmp1 = icmp sge i32 %5, %6, !dbg !44
  %conv = zext i1 %cmp1 to i32, !dbg !44
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !45
  %7 = load i32, i32* %middle, align 4, !dbg !46
  %8 = load i32, i32* %last, align 4, !dbg !47
  %cmp2 = icmp sle i32 %7, %8, !dbg !48
  %conv3 = zext i1 %cmp2 to i32, !dbg !48
  %call4 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv3), !dbg !49
  %9 = load i32, i32* %middle, align 4, !dbg !50
  %idxprom = sext i32 %9 to i64, !dbg !52
  %arrayidx = getelementptr inbounds [10 x i32], [10 x i32]* %array, i64 0, i64 %idxprom, !dbg !52
  %10 = load i32, i32* %arrayidx, align 4, !dbg !52
  %11 = load i32, i32* %search, align 4, !dbg !53
  %cmp5 = icmp slt i32 %10, %11, !dbg !54
  br i1 %cmp5, label %if.then, label %if.else, !dbg !55

if.then:                                          ; preds = %while.body
  %12 = load i32, i32* %middle, align 4, !dbg !56
  %add7 = add nsw i32 %12, 1, !dbg !57
  store i32 %add7, i32* %first, align 4, !dbg !58
  br label %if.end16, !dbg !59

if.else:                                          ; preds = %while.body
  %13 = load i32, i32* %middle, align 4, !dbg !60
  %idxprom8 = sext i32 %13 to i64, !dbg !62
  %arrayidx9 = getelementptr inbounds [10 x i32], [10 x i32]* %array, i64 0, i64 %idxprom8, !dbg !62
  %14 = load i32, i32* %arrayidx9, align 4, !dbg !62
  %15 = load i32, i32* %search, align 4, !dbg !63
  %cmp10 = icmp eq i32 %14, %15, !dbg !64
  br i1 %cmp10, label %if.then12, label %if.else14, !dbg !65

if.then12:                                        ; preds = %if.else
  %16 = load i32, i32* %found, align 4, !dbg !66
  %add13 = add nsw i32 %16, 1, !dbg !68
  store i32 %add13, i32* %found, align 4, !dbg !69
  br label %while.end, !dbg !70

if.else14:                                        ; preds = %if.else
  %17 = load i32, i32* %middle, align 4, !dbg !71
  %sub15 = sub nsw i32 %17, 1, !dbg !72
  store i32 %sub15, i32* %last, align 4, !dbg !73
  br label %if.end

if.end:                                           ; preds = %if.else14
  br label %if.end16

if.end16:                                         ; preds = %if.end, %if.then
  %18 = load i32, i32* %first, align 4, !dbg !74
  %19 = load i32, i32* %last, align 4, !dbg !75
  %add17 = add nsw i32 %18, %19, !dbg !76
  %div18 = sdiv i32 %add17, 2, !dbg !77
  store i32 %div18, i32* %middle, align 4, !dbg !78
  br label %while.cond, !dbg !37, !llvm.loop !79

while.end:                                        ; preds = %if.then12, %while.cond
  call void @llvm.dbg.declare(metadata i32* %cmp119, metadata !81, metadata !DIExpression()), !dbg !82
  %20 = load i32, i32* %first, align 4, !dbg !83
  %21 = load i32, i32* %last, align 4, !dbg !84
  %cmp20 = icmp sgt i32 %20, %21, !dbg !85
  %conv21 = zext i1 %cmp20 to i32, !dbg !85
  store i32 %conv21, i32* %cmp119, align 4, !dbg !82
  %22 = load i32, i32* %first, align 4, !dbg !86
  %23 = load i32, i32* %last, align 4, !dbg !88
  %cmp22 = icmp sgt i32 %22, %23, !dbg !89
  br i1 %cmp22, label %if.then24, label %if.else32, !dbg !90

if.then24:                                        ; preds = %while.end
  %24 = load i32, i32* %found, align 4, !dbg !91
  %cmp25 = icmp eq i32 %24, 0, !dbg !94
  br i1 %cmp25, label %if.then27, label %if.else29, !dbg !95

if.then27:                                        ; preds = %if.then24
  %call28 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 1), !dbg !96
  br label %if.end31, !dbg !96

if.else29:                                        ; preds = %if.then24
  %call30 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 0), !dbg !97
  br label %if.end31

if.end31:                                         ; preds = %if.else29, %if.then27
  br label %if.end40, !dbg !98

if.else32:                                        ; preds = %while.end
  %25 = load i32, i32* %found, align 4, !dbg !99
  %cmp33 = icmp sgt i32 %25, 0, !dbg !102
  br i1 %cmp33, label %if.then35, label %if.else37, !dbg !103

if.then35:                                        ; preds = %if.else32
  %call36 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 1), !dbg !104
  br label %if.end39, !dbg !104

if.else37:                                        ; preds = %if.else32
  %call38 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 0), !dbg !105
  br label %if.end39

if.end39:                                         ; preds = %if.else37, %if.then35
  br label %if.end40

if.end40:                                         ; preds = %if.end39, %if.end31
  ret i32 0, !dbg !106
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
!1 = !DIFile(filename: "akash_test/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 8.0.0 "}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 1, type: !8, scopeLine: 2, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "first", scope: !7, file: !1, line: 3, type: !10)
!12 = !DILocation(line: 3, column: 8, scope: !7)
!13 = !DILocalVariable(name: "last", scope: !7, file: !1, line: 3, type: !10)
!14 = !DILocation(line: 3, column: 15, scope: !7)
!15 = !DILocalVariable(name: "middle", scope: !7, file: !1, line: 3, type: !10)
!16 = !DILocation(line: 3, column: 21, scope: !7)
!17 = !DILocalVariable(name: "n", scope: !7, file: !1, line: 4, type: !10)
!18 = !DILocation(line: 4, column: 8, scope: !7)
!19 = !DILocalVariable(name: "search", scope: !7, file: !1, line: 5, type: !10)
!20 = !DILocation(line: 5, column: 8, scope: !7)
!21 = !DILocalVariable(name: "array", scope: !7, file: !1, line: 6, type: !22)
!22 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 320, elements: !23)
!23 = !{!24}
!24 = !DISubrange(count: 10)
!25 = !DILocation(line: 6, column: 8, scope: !7)
!26 = !DILocalVariable(name: "found", scope: !7, file: !1, line: 8, type: !10)
!27 = !DILocation(line: 8, column: 8, scope: !7)
!28 = !DILocation(line: 10, column: 10, scope: !7)
!29 = !DILocation(line: 11, column: 11, scope: !7)
!30 = !DILocation(line: 11, column: 13, scope: !7)
!31 = !DILocation(line: 11, column: 9, scope: !7)
!32 = !DILocation(line: 12, column: 14, scope: !7)
!33 = !DILocation(line: 12, column: 20, scope: !7)
!34 = !DILocation(line: 12, column: 19, scope: !7)
!35 = !DILocation(line: 12, column: 25, scope: !7)
!36 = !DILocation(line: 12, column: 11, scope: !7)
!37 = !DILocation(line: 14, column: 4, scope: !7)
!38 = !DILocation(line: 14, column: 11, scope: !7)
!39 = !DILocation(line: 14, column: 20, scope: !7)
!40 = !DILocation(line: 14, column: 17, scope: !7)
!41 = !DILocation(line: 17, column: 14, scope: !42)
!42 = distinct !DILexicalBlock(scope: !7, file: !1, line: 14, column: 26)
!43 = !DILocation(line: 17, column: 24, scope: !42)
!44 = !DILocation(line: 17, column: 21, scope: !42)
!45 = !DILocation(line: 17, column: 7, scope: !42)
!46 = !DILocation(line: 18, column: 14, scope: !42)
!47 = !DILocation(line: 18, column: 24, scope: !42)
!48 = !DILocation(line: 18, column: 21, scope: !42)
!49 = !DILocation(line: 18, column: 7, scope: !42)
!50 = !DILocation(line: 20, column: 17, scope: !51)
!51 = distinct !DILexicalBlock(scope: !42, file: !1, line: 20, column: 11)
!52 = !DILocation(line: 20, column: 11, scope: !51)
!53 = !DILocation(line: 20, column: 27, scope: !51)
!54 = !DILocation(line: 20, column: 25, scope: !51)
!55 = !DILocation(line: 20, column: 11, scope: !42)
!56 = !DILocation(line: 21, column: 18, scope: !51)
!57 = !DILocation(line: 21, column: 25, scope: !51)
!58 = !DILocation(line: 21, column: 16, scope: !51)
!59 = !DILocation(line: 21, column: 10, scope: !51)
!60 = !DILocation(line: 23, column: 22, scope: !61)
!61 = distinct !DILexicalBlock(scope: !51, file: !1, line: 23, column: 16)
!62 = !DILocation(line: 23, column: 16, scope: !61)
!63 = !DILocation(line: 23, column: 33, scope: !61)
!64 = !DILocation(line: 23, column: 30, scope: !61)
!65 = !DILocation(line: 23, column: 16, scope: !51)
!66 = !DILocation(line: 24, column: 18, scope: !67)
!67 = distinct !DILexicalBlock(scope: !61, file: !1, line: 23, column: 41)
!68 = !DILocation(line: 24, column: 24, scope: !67)
!69 = !DILocation(line: 24, column: 16, scope: !67)
!70 = !DILocation(line: 25, column: 10, scope: !67)
!71 = !DILocation(line: 28, column: 17, scope: !61)
!72 = !DILocation(line: 28, column: 24, scope: !61)
!73 = !DILocation(line: 28, column: 15, scope: !61)
!74 = !DILocation(line: 30, column: 17, scope: !42)
!75 = !DILocation(line: 30, column: 25, scope: !42)
!76 = !DILocation(line: 30, column: 23, scope: !42)
!77 = !DILocation(line: 30, column: 30, scope: !42)
!78 = !DILocation(line: 30, column: 14, scope: !42)
!79 = distinct !{!79, !37, !80}
!80 = !DILocation(line: 32, column: 4, scope: !7)
!81 = !DILocalVariable(name: "cmp1", scope: !7, file: !1, line: 33, type: !10)
!82 = !DILocation(line: 33, column: 9, scope: !7)
!83 = !DILocation(line: 33, column: 17, scope: !7)
!84 = !DILocation(line: 33, column: 25, scope: !7)
!85 = !DILocation(line: 33, column: 23, scope: !7)
!86 = !DILocation(line: 34, column: 8, scope: !87)
!87 = distinct !DILexicalBlock(scope: !7, file: !1, line: 34, column: 8)
!88 = !DILocation(line: 34, column: 16, scope: !87)
!89 = !DILocation(line: 34, column: 14, scope: !87)
!90 = !DILocation(line: 34, column: 8, scope: !7)
!91 = !DILocation(line: 35, column: 12, scope: !92)
!92 = distinct !DILexicalBlock(scope: !93, file: !1, line: 35, column: 12)
!93 = distinct !DILexicalBlock(scope: !87, file: !1, line: 34, column: 21)
!94 = !DILocation(line: 35, column: 18, scope: !92)
!95 = !DILocation(line: 35, column: 12, scope: !93)
!96 = !DILocation(line: 36, column: 13, scope: !92)
!97 = !DILocation(line: 38, column: 13, scope: !92)
!98 = !DILocation(line: 39, column: 5, scope: !93)
!99 = !DILocation(line: 41, column: 12, scope: !100)
!100 = distinct !DILexicalBlock(scope: !101, file: !1, line: 41, column: 12)
!101 = distinct !DILexicalBlock(scope: !87, file: !1, line: 40, column: 8)
!102 = !DILocation(line: 41, column: 18, scope: !100)
!103 = !DILocation(line: 41, column: 12, scope: !101)
!104 = !DILocation(line: 42, column: 13, scope: !100)
!105 = !DILocation(line: 44, column: 13, scope: !100)
!106 = !DILocation(line: 47, column: 4, scope: !7)

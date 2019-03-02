; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %arr1 = alloca [3 x [3 x i32]], align 16
  %arr2 = alloca [3 x [3 x i32]], align 16
  %x = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %arr3 = alloca [3 x [3 x i32]], align 16
  %i14 = alloca i32, align 4
  %j18 = alloca i32, align 4
  %i40 = alloca i32, align 4
  %j44 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata [3 x [3 x i32]]* %arr1, metadata !11, metadata !DIExpression()), !dbg !15
  call void @llvm.dbg.declare(metadata [3 x [3 x i32]]* %arr2, metadata !16, metadata !DIExpression()), !dbg !17
  call void @llvm.dbg.declare(metadata i32* %x, metadata !18, metadata !DIExpression()), !dbg !19
  store i32 1, i32* %x, align 4, !dbg !19
  call void @llvm.dbg.declare(metadata i32* %i, metadata !20, metadata !DIExpression()), !dbg !22
  store i32 0, i32* %i, align 4, !dbg !22
  br label %for.cond, !dbg !23

for.cond:                                         ; preds = %for.inc11, %entry
  %0 = load i32, i32* %i, align 4, !dbg !24
  %cmp = icmp slt i32 %0, 3, !dbg !26
  br i1 %cmp, label %for.body, label %for.end13, !dbg !27

for.body:                                         ; preds = %for.cond
  call void @llvm.dbg.declare(metadata i32* %j, metadata !28, metadata !DIExpression()), !dbg !31
  store i32 0, i32* %j, align 4, !dbg !31
  br label %for.cond1, !dbg !32

for.cond1:                                        ; preds = %for.inc, %for.body
  %1 = load i32, i32* %j, align 4, !dbg !33
  %cmp2 = icmp slt i32 %1, 3, !dbg !35
  br i1 %cmp2, label %for.body3, label %for.end, !dbg !36

for.body3:                                        ; preds = %for.cond1
  %2 = load i32, i32* %x, align 4, !dbg !37
  %3 = load i32, i32* %i, align 4, !dbg !39
  %idxprom = sext i32 %3 to i64, !dbg !40
  %arrayidx = getelementptr inbounds [3 x [3 x i32]], [3 x [3 x i32]]* %arr1, i64 0, i64 %idxprom, !dbg !40
  %4 = load i32, i32* %j, align 4, !dbg !41
  %idxprom4 = sext i32 %4 to i64, !dbg !40
  %arrayidx5 = getelementptr inbounds [3 x i32], [3 x i32]* %arrayidx, i64 0, i64 %idxprom4, !dbg !40
  store i32 %2, i32* %arrayidx5, align 4, !dbg !42
  %5 = load i32, i32* %x, align 4, !dbg !43
  %6 = load i32, i32* %i, align 4, !dbg !44
  %idxprom6 = sext i32 %6 to i64, !dbg !45
  %arrayidx7 = getelementptr inbounds [3 x [3 x i32]], [3 x [3 x i32]]* %arr2, i64 0, i64 %idxprom6, !dbg !45
  %7 = load i32, i32* %j, align 4, !dbg !46
  %idxprom8 = sext i32 %7 to i64, !dbg !45
  %arrayidx9 = getelementptr inbounds [3 x i32], [3 x i32]* %arrayidx7, i64 0, i64 %idxprom8, !dbg !45
  store i32 %5, i32* %arrayidx9, align 4, !dbg !47
  %8 = load i32, i32* %x, align 4, !dbg !48
  %inc = add nsw i32 %8, 1, !dbg !48
  store i32 %inc, i32* %x, align 4, !dbg !48
  br label %for.inc, !dbg !49

for.inc:                                          ; preds = %for.body3
  %9 = load i32, i32* %j, align 4, !dbg !50
  %inc10 = add nsw i32 %9, 1, !dbg !50
  store i32 %inc10, i32* %j, align 4, !dbg !50
  br label %for.cond1, !dbg !51, !llvm.loop !52

for.end:                                          ; preds = %for.cond1
  br label %for.inc11, !dbg !54

for.inc11:                                        ; preds = %for.end
  %10 = load i32, i32* %i, align 4, !dbg !55
  %inc12 = add nsw i32 %10, 1, !dbg !55
  store i32 %inc12, i32* %i, align 4, !dbg !55
  br label %for.cond, !dbg !56, !llvm.loop !57

for.end13:                                        ; preds = %for.cond
  call void @llvm.dbg.declare(metadata [3 x [3 x i32]]* %arr3, metadata !59, metadata !DIExpression()), !dbg !60
  call void @llvm.dbg.declare(metadata i32* %i14, metadata !61, metadata !DIExpression()), !dbg !63
  store i32 0, i32* %i14, align 4, !dbg !63
  br label %for.cond15, !dbg !64

for.cond15:                                       ; preds = %for.inc37, %for.end13
  %11 = load i32, i32* %i14, align 4, !dbg !65
  %cmp16 = icmp slt i32 %11, 3, !dbg !67
  br i1 %cmp16, label %for.body17, label %for.end39, !dbg !68

for.body17:                                       ; preds = %for.cond15
  call void @llvm.dbg.declare(metadata i32* %j18, metadata !69, metadata !DIExpression()), !dbg !72
  store i32 0, i32* %j18, align 4, !dbg !72
  br label %for.cond19, !dbg !73

for.cond19:                                       ; preds = %for.inc34, %for.body17
  %12 = load i32, i32* %j18, align 4, !dbg !74
  %cmp20 = icmp slt i32 %12, 3, !dbg !76
  br i1 %cmp20, label %for.body21, label %for.end36, !dbg !77

for.body21:                                       ; preds = %for.cond19
  %13 = load i32, i32* %i14, align 4, !dbg !78
  %idxprom22 = sext i32 %13 to i64, !dbg !80
  %arrayidx23 = getelementptr inbounds [3 x [3 x i32]], [3 x [3 x i32]]* %arr1, i64 0, i64 %idxprom22, !dbg !80
  %14 = load i32, i32* %j18, align 4, !dbg !81
  %idxprom24 = sext i32 %14 to i64, !dbg !80
  %arrayidx25 = getelementptr inbounds [3 x i32], [3 x i32]* %arrayidx23, i64 0, i64 %idxprom24, !dbg !80
  %15 = load i32, i32* %arrayidx25, align 4, !dbg !80
  %16 = load i32, i32* %i14, align 4, !dbg !82
  %idxprom26 = sext i32 %16 to i64, !dbg !83
  %arrayidx27 = getelementptr inbounds [3 x [3 x i32]], [3 x [3 x i32]]* %arr2, i64 0, i64 %idxprom26, !dbg !83
  %17 = load i32, i32* %j18, align 4, !dbg !84
  %idxprom28 = sext i32 %17 to i64, !dbg !83
  %arrayidx29 = getelementptr inbounds [3 x i32], [3 x i32]* %arrayidx27, i64 0, i64 %idxprom28, !dbg !83
  %18 = load i32, i32* %arrayidx29, align 4, !dbg !83
  %add = add nsw i32 %15, %18, !dbg !85
  %19 = load i32, i32* %i14, align 4, !dbg !86
  %idxprom30 = sext i32 %19 to i64, !dbg !87
  %arrayidx31 = getelementptr inbounds [3 x [3 x i32]], [3 x [3 x i32]]* %arr3, i64 0, i64 %idxprom30, !dbg !87
  %20 = load i32, i32* %j18, align 4, !dbg !88
  %idxprom32 = sext i32 %20 to i64, !dbg !87
  %arrayidx33 = getelementptr inbounds [3 x i32], [3 x i32]* %arrayidx31, i64 0, i64 %idxprom32, !dbg !87
  store i32 %add, i32* %arrayidx33, align 4, !dbg !89
  br label %for.inc34, !dbg !90

for.inc34:                                        ; preds = %for.body21
  %21 = load i32, i32* %j18, align 4, !dbg !91
  %inc35 = add nsw i32 %21, 1, !dbg !91
  store i32 %inc35, i32* %j18, align 4, !dbg !91
  br label %for.cond19, !dbg !92, !llvm.loop !93

for.end36:                                        ; preds = %for.cond19
  br label %for.inc37, !dbg !95

for.inc37:                                        ; preds = %for.end36
  %22 = load i32, i32* %i14, align 4, !dbg !96
  %inc38 = add nsw i32 %22, 1, !dbg !96
  store i32 %inc38, i32* %i14, align 4, !dbg !96
  br label %for.cond15, !dbg !97, !llvm.loop !98

for.end39:                                        ; preds = %for.cond15
  call void @llvm.dbg.declare(metadata i32* %i40, metadata !100, metadata !DIExpression()), !dbg !102
  store i32 0, i32* %i40, align 4, !dbg !102
  br label %for.cond41, !dbg !103

for.cond41:                                       ; preds = %for.inc60, %for.end39
  %23 = load i32, i32* %i40, align 4, !dbg !104
  %cmp42 = icmp slt i32 %23, 3, !dbg !106
  br i1 %cmp42, label %for.body43, label %for.end62, !dbg !107

for.body43:                                       ; preds = %for.cond41
  call void @llvm.dbg.declare(metadata i32* %j44, metadata !108, metadata !DIExpression()), !dbg !111
  store i32 0, i32* %j44, align 4, !dbg !111
  br label %for.cond45, !dbg !112

for.cond45:                                       ; preds = %for.inc57, %for.body43
  %24 = load i32, i32* %j44, align 4, !dbg !113
  %cmp46 = icmp slt i32 %24, 3, !dbg !115
  br i1 %cmp46, label %for.body47, label %for.end59, !dbg !116

for.body47:                                       ; preds = %for.cond45
  %25 = load i32, i32* %i40, align 4, !dbg !117
  %idxprom48 = sext i32 %25 to i64, !dbg !119
  %arrayidx49 = getelementptr inbounds [3 x [3 x i32]], [3 x [3 x i32]]* %arr3, i64 0, i64 %idxprom48, !dbg !119
  %26 = load i32, i32* %j44, align 4, !dbg !120
  %idxprom50 = sext i32 %26 to i64, !dbg !119
  %arrayidx51 = getelementptr inbounds [3 x i32], [3 x i32]* %arrayidx49, i64 0, i64 %idxprom50, !dbg !119
  %27 = load i32, i32* %arrayidx51, align 4, !dbg !119
  %28 = load i32, i32* %i40, align 4, !dbg !121
  %idxprom52 = sext i32 %28 to i64, !dbg !122
  %arrayidx53 = getelementptr inbounds [3 x [3 x i32]], [3 x [3 x i32]]* %arr1, i64 0, i64 %idxprom52, !dbg !122
  %29 = load i32, i32* %j44, align 4, !dbg !123
  %idxprom54 = sext i32 %29 to i64, !dbg !122
  %arrayidx55 = getelementptr inbounds [3 x i32], [3 x i32]* %arrayidx53, i64 0, i64 %idxprom54, !dbg !122
  %30 = load i32, i32* %arrayidx55, align 4, !dbg !122
  %mul = mul nsw i32 2, %30, !dbg !124
  %cmp56 = icmp ne i32 %27, %mul, !dbg !125
  %conv = zext i1 %cmp56 to i32, !dbg !125
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !126
  br label %for.inc57, !dbg !127

for.inc57:                                        ; preds = %for.body47
  %31 = load i32, i32* %j44, align 4, !dbg !128
  %inc58 = add nsw i32 %31, 1, !dbg !128
  store i32 %inc58, i32* %j44, align 4, !dbg !128
  br label %for.cond45, !dbg !129, !llvm.loop !130

for.end59:                                        ; preds = %for.cond45
  br label %for.inc60, !dbg !132

for.inc60:                                        ; preds = %for.end59
  %32 = load i32, i32* %i40, align 4, !dbg !133
  %inc61 = add nsw i32 %32, 1, !dbg !133
  store i32 %inc61, i32* %i40, align 4, !dbg !133
  br label %for.cond41, !dbg !134, !llvm.loop !135

for.end62:                                        ; preds = %for.cond41
  ret i32 0, !dbg !137
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
!1 = !DIFile(filename: "main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression/2d_array")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 8.0.0 "}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 3, type: !8, scopeLine: 4, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "arr1", scope: !7, file: !1, line: 5, type: !12)
!12 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 288, elements: !13)
!13 = !{!14, !14}
!14 = !DISubrange(count: 3)
!15 = !DILocation(line: 5, column: 6, scope: !7)
!16 = !DILocalVariable(name: "arr2", scope: !7, file: !1, line: 6, type: !12)
!17 = !DILocation(line: 6, column: 6, scope: !7)
!18 = !DILocalVariable(name: "x", scope: !7, file: !1, line: 8, type: !10)
!19 = !DILocation(line: 8, column: 6, scope: !7)
!20 = !DILocalVariable(name: "i", scope: !21, file: !1, line: 9, type: !10)
!21 = distinct !DILexicalBlock(scope: !7, file: !1, line: 9, column: 2)
!22 = !DILocation(line: 9, column: 10, scope: !21)
!23 = !DILocation(line: 9, column: 6, scope: !21)
!24 = !DILocation(line: 9, column: 16, scope: !25)
!25 = distinct !DILexicalBlock(scope: !21, file: !1, line: 9, column: 2)
!26 = !DILocation(line: 9, column: 17, scope: !25)
!27 = !DILocation(line: 9, column: 2, scope: !21)
!28 = !DILocalVariable(name: "j", scope: !29, file: !1, line: 11, type: !10)
!29 = distinct !DILexicalBlock(scope: !30, file: !1, line: 11, column: 3)
!30 = distinct !DILexicalBlock(scope: !25, file: !1, line: 10, column: 2)
!31 = !DILocation(line: 11, column: 11, scope: !29)
!32 = !DILocation(line: 11, column: 7, scope: !29)
!33 = !DILocation(line: 11, column: 17, scope: !34)
!34 = distinct !DILexicalBlock(scope: !29, file: !1, line: 11, column: 3)
!35 = !DILocation(line: 11, column: 18, scope: !34)
!36 = !DILocation(line: 11, column: 3, scope: !29)
!37 = !DILocation(line: 13, column: 15, scope: !38)
!38 = distinct !DILexicalBlock(scope: !34, file: !1, line: 12, column: 3)
!39 = !DILocation(line: 13, column: 9, scope: !38)
!40 = !DILocation(line: 13, column: 4, scope: !38)
!41 = !DILocation(line: 13, column: 12, scope: !38)
!42 = !DILocation(line: 13, column: 14, scope: !38)
!43 = !DILocation(line: 14, column: 15, scope: !38)
!44 = !DILocation(line: 14, column: 9, scope: !38)
!45 = !DILocation(line: 14, column: 4, scope: !38)
!46 = !DILocation(line: 14, column: 12, scope: !38)
!47 = !DILocation(line: 14, column: 14, scope: !38)
!48 = !DILocation(line: 15, column: 5, scope: !38)
!49 = !DILocation(line: 16, column: 3, scope: !38)
!50 = !DILocation(line: 11, column: 24, scope: !34)
!51 = !DILocation(line: 11, column: 3, scope: !34)
!52 = distinct !{!52, !36, !53}
!53 = !DILocation(line: 16, column: 3, scope: !29)
!54 = !DILocation(line: 17, column: 2, scope: !30)
!55 = !DILocation(line: 9, column: 23, scope: !25)
!56 = !DILocation(line: 9, column: 2, scope: !25)
!57 = distinct !{!57, !27, !58}
!58 = !DILocation(line: 17, column: 2, scope: !21)
!59 = !DILocalVariable(name: "arr3", scope: !7, file: !1, line: 19, type: !12)
!60 = !DILocation(line: 19, column: 6, scope: !7)
!61 = !DILocalVariable(name: "i", scope: !62, file: !1, line: 22, type: !10)
!62 = distinct !DILexicalBlock(scope: !7, file: !1, line: 22, column: 2)
!63 = !DILocation(line: 22, column: 10, scope: !62)
!64 = !DILocation(line: 22, column: 6, scope: !62)
!65 = !DILocation(line: 22, column: 16, scope: !66)
!66 = distinct !DILexicalBlock(scope: !62, file: !1, line: 22, column: 2)
!67 = !DILocation(line: 22, column: 17, scope: !66)
!68 = !DILocation(line: 22, column: 2, scope: !62)
!69 = !DILocalVariable(name: "j", scope: !70, file: !1, line: 24, type: !10)
!70 = distinct !DILexicalBlock(scope: !71, file: !1, line: 24, column: 3)
!71 = distinct !DILexicalBlock(scope: !66, file: !1, line: 23, column: 2)
!72 = !DILocation(line: 24, column: 11, scope: !70)
!73 = !DILocation(line: 24, column: 7, scope: !70)
!74 = !DILocation(line: 24, column: 17, scope: !75)
!75 = distinct !DILexicalBlock(scope: !70, file: !1, line: 24, column: 3)
!76 = !DILocation(line: 24, column: 18, scope: !75)
!77 = !DILocation(line: 24, column: 3, scope: !70)
!78 = !DILocation(line: 26, column: 22, scope: !79)
!79 = distinct !DILexicalBlock(scope: !75, file: !1, line: 25, column: 3)
!80 = !DILocation(line: 26, column: 17, scope: !79)
!81 = !DILocation(line: 26, column: 25, scope: !79)
!82 = !DILocation(line: 26, column: 35, scope: !79)
!83 = !DILocation(line: 26, column: 30, scope: !79)
!84 = !DILocation(line: 26, column: 38, scope: !79)
!85 = !DILocation(line: 26, column: 28, scope: !79)
!86 = !DILocation(line: 26, column: 9, scope: !79)
!87 = !DILocation(line: 26, column: 4, scope: !79)
!88 = !DILocation(line: 26, column: 12, scope: !79)
!89 = !DILocation(line: 26, column: 15, scope: !79)
!90 = !DILocation(line: 27, column: 3, scope: !79)
!91 = !DILocation(line: 24, column: 24, scope: !75)
!92 = !DILocation(line: 24, column: 3, scope: !75)
!93 = distinct !{!93, !77, !94}
!94 = !DILocation(line: 27, column: 3, scope: !70)
!95 = !DILocation(line: 28, column: 2, scope: !71)
!96 = !DILocation(line: 22, column: 23, scope: !66)
!97 = !DILocation(line: 22, column: 2, scope: !66)
!98 = distinct !{!98, !68, !99}
!99 = !DILocation(line: 28, column: 2, scope: !62)
!100 = !DILocalVariable(name: "i", scope: !101, file: !1, line: 31, type: !10)
!101 = distinct !DILexicalBlock(scope: !7, file: !1, line: 31, column: 2)
!102 = !DILocation(line: 31, column: 10, scope: !101)
!103 = !DILocation(line: 31, column: 6, scope: !101)
!104 = !DILocation(line: 31, column: 15, scope: !105)
!105 = distinct !DILexicalBlock(scope: !101, file: !1, line: 31, column: 2)
!106 = !DILocation(line: 31, column: 16, scope: !105)
!107 = !DILocation(line: 31, column: 2, scope: !101)
!108 = !DILocalVariable(name: "j", scope: !109, file: !1, line: 33, type: !10)
!109 = distinct !DILexicalBlock(scope: !110, file: !1, line: 33, column: 3)
!110 = distinct !DILexicalBlock(scope: !105, file: !1, line: 32, column: 2)
!111 = !DILocation(line: 33, column: 11, scope: !109)
!112 = !DILocation(line: 33, column: 7, scope: !109)
!113 = !DILocation(line: 33, column: 17, scope: !114)
!114 = distinct !DILexicalBlock(scope: !109, file: !1, line: 33, column: 3)
!115 = !DILocation(line: 33, column: 18, scope: !114)
!116 = !DILocation(line: 33, column: 3, scope: !109)
!117 = !DILocation(line: 35, column: 16, scope: !118)
!118 = distinct !DILexicalBlock(scope: !114, file: !1, line: 34, column: 3)
!119 = !DILocation(line: 35, column: 11, scope: !118)
!120 = !DILocation(line: 35, column: 19, scope: !118)
!121 = !DILocation(line: 35, column: 32, scope: !118)
!122 = !DILocation(line: 35, column: 27, scope: !118)
!123 = !DILocation(line: 35, column: 35, scope: !118)
!124 = !DILocation(line: 35, column: 26, scope: !118)
!125 = !DILocation(line: 35, column: 22, scope: !118)
!126 = !DILocation(line: 35, column: 4, scope: !118)
!127 = !DILocation(line: 36, column: 3, scope: !118)
!128 = !DILocation(line: 33, column: 24, scope: !114)
!129 = !DILocation(line: 33, column: 3, scope: !114)
!130 = distinct !{!130, !116, !131}
!131 = !DILocation(line: 36, column: 3, scope: !109)
!132 = !DILocation(line: 37, column: 2, scope: !110)
!133 = !DILocation(line: 31, column: 21, scope: !105)
!134 = !DILocation(line: 31, column: 2, scope: !105)
!135 = distinct !{!135, !107, !136}
!136 = !DILocation(line: 37, column: 2, scope: !101)
!137 = !DILocation(line: 41, column: 2, scope: !7)

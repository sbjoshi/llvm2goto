; ModuleID = 'akash_struct_3/main.c'
source_filename = "akash_struct_3/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.S2 = type { i8, i8, %struct.S1 }
%struct.S1 = type { i32, i32 }

@objects = common dso_local global [3 x %struct.S2] zeroinitializer, align 16, !dbg !0

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !25 {
entry:
  %retval = alloca i32, align 4
  %v1 = alloca i32, align 4
  %v2 = alloca i32, align 4
  %i = alloca i32, align 4
  %c1 = alloca i8, align 1
  %c2 = alloca i8, align 1
  %i18 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %v1, metadata !28, metadata !DIExpression()), !dbg !29
  call void @llvm.dbg.declare(metadata i32* %v2, metadata !30, metadata !DIExpression()), !dbg !31
  store i32 48, i32* %v1, align 4, !dbg !32
  store i32 49, i32* %v2, align 4, !dbg !33
  call void @llvm.dbg.declare(metadata i32* %i, metadata !34, metadata !DIExpression()), !dbg !36
  store i32 0, i32* %i, align 4, !dbg !36
  br label %for.cond, !dbg !37

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4, !dbg !38
  %cmp = icmp slt i32 %0, 3, !dbg !40
  br i1 %cmp, label %for.body, label %for.end, !dbg !41

for.body:                                         ; preds = %for.cond
  %1 = load i32, i32* %v1, align 4, !dbg !42
  %2 = load i32, i32* %i, align 4, !dbg !44
  %idxprom = sext i32 %2 to i64, !dbg !45
  %arrayidx = getelementptr inbounds [3 x %struct.S2], [3 x %struct.S2]* @objects, i64 0, i64 %idxprom, !dbg !45
  %s2_s1 = getelementptr inbounds %struct.S2, %struct.S2* %arrayidx, i32 0, i32 2, !dbg !46
  %s1_a = getelementptr inbounds %struct.S1, %struct.S1* %s2_s1, i32 0, i32 0, !dbg !47
  store i32 %1, i32* %s1_a, align 4, !dbg !48
  %3 = load i32, i32* %v2, align 4, !dbg !49
  %4 = load i32, i32* %i, align 4, !dbg !50
  %idxprom1 = sext i32 %4 to i64, !dbg !51
  %arrayidx2 = getelementptr inbounds [3 x %struct.S2], [3 x %struct.S2]* @objects, i64 0, i64 %idxprom1, !dbg !51
  %s2_s13 = getelementptr inbounds %struct.S2, %struct.S2* %arrayidx2, i32 0, i32 2, !dbg !52
  %s1_b = getelementptr inbounds %struct.S1, %struct.S1* %s2_s13, i32 0, i32 1, !dbg !53
  store i32 %3, i32* %s1_b, align 4, !dbg !54
  %5 = load i32, i32* %i, align 4, !dbg !55
  %idxprom4 = sext i32 %5 to i64, !dbg !56
  %arrayidx5 = getelementptr inbounds [3 x %struct.S2], [3 x %struct.S2]* @objects, i64 0, i64 %idxprom4, !dbg !56
  %s2_s16 = getelementptr inbounds %struct.S2, %struct.S2* %arrayidx5, i32 0, i32 2, !dbg !57
  %s1_a7 = getelementptr inbounds %struct.S1, %struct.S1* %s2_s16, i32 0, i32 0, !dbg !58
  %6 = load i32, i32* %s1_a7, align 4, !dbg !58
  %7 = load i32, i32* %v1, align 4, !dbg !59
  %cmp8 = icmp eq i32 %6, %7, !dbg !60
  %conv = zext i1 %cmp8 to i32, !dbg !60
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !61
  %8 = load i32, i32* %i, align 4, !dbg !62
  %idxprom9 = sext i32 %8 to i64, !dbg !63
  %arrayidx10 = getelementptr inbounds [3 x %struct.S2], [3 x %struct.S2]* @objects, i64 0, i64 %idxprom9, !dbg !63
  %s2_s111 = getelementptr inbounds %struct.S2, %struct.S2* %arrayidx10, i32 0, i32 2, !dbg !64
  %s1_b12 = getelementptr inbounds %struct.S1, %struct.S1* %s2_s111, i32 0, i32 1, !dbg !65
  %9 = load i32, i32* %s1_b12, align 4, !dbg !65
  %10 = load i32, i32* %v2, align 4, !dbg !66
  %cmp13 = icmp eq i32 %9, %10, !dbg !67
  %conv14 = zext i1 %cmp13 to i32, !dbg !67
  %call15 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv14), !dbg !68
  %11 = load i32, i32* %v1, align 4, !dbg !69
  %inc = add nsw i32 %11, 1, !dbg !69
  store i32 %inc, i32* %v1, align 4, !dbg !69
  %12 = load i32, i32* %v2, align 4, !dbg !70
  %inc16 = add nsw i32 %12, 1, !dbg !70
  store i32 %inc16, i32* %v2, align 4, !dbg !70
  br label %for.inc, !dbg !71

for.inc:                                          ; preds = %for.body
  %13 = load i32, i32* %i, align 4, !dbg !72
  %inc17 = add nsw i32 %13, 1, !dbg !72
  store i32 %inc17, i32* %i, align 4, !dbg !72
  br label %for.cond, !dbg !73, !llvm.loop !74

for.end:                                          ; preds = %for.cond
  call void @llvm.dbg.declare(metadata i8* %c1, metadata !76, metadata !DIExpression()), !dbg !77
  store i8 48, i8* %c1, align 1, !dbg !77
  call void @llvm.dbg.declare(metadata i8* %c2, metadata !78, metadata !DIExpression()), !dbg !79
  store i8 49, i8* %c2, align 1, !dbg !79
  call void @llvm.dbg.declare(metadata i32* %i18, metadata !80, metadata !DIExpression()), !dbg !82
  store i32 0, i32* %i18, align 4, !dbg !82
  br label %for.cond19, !dbg !83

for.cond19:                                       ; preds = %for.inc55, %for.end
  %14 = load i32, i32* %i18, align 4, !dbg !84
  %cmp20 = icmp slt i32 %14, 3, !dbg !86
  br i1 %cmp20, label %for.body22, label %for.end57, !dbg !87

for.body22:                                       ; preds = %for.cond19
  %15 = load i32, i32* %i18, align 4, !dbg !88
  %idxprom23 = sext i32 %15 to i64, !dbg !90
  %arrayidx24 = getelementptr inbounds [3 x %struct.S2], [3 x %struct.S2]* @objects, i64 0, i64 %idxprom23, !dbg !90
  %s2_s125 = getelementptr inbounds %struct.S2, %struct.S2* %arrayidx24, i32 0, i32 2, !dbg !91
  %s1_a26 = getelementptr inbounds %struct.S1, %struct.S1* %s2_s125, i32 0, i32 0, !dbg !92
  %16 = load i32, i32* %s1_a26, align 4, !dbg !92
  %conv27 = trunc i32 %16 to i8, !dbg !93
  %17 = load i32, i32* %i18, align 4, !dbg !94
  %idxprom28 = sext i32 %17 to i64, !dbg !95
  %arrayidx29 = getelementptr inbounds [3 x %struct.S2], [3 x %struct.S2]* @objects, i64 0, i64 %idxprom28, !dbg !95
  %s2_a = getelementptr inbounds %struct.S2, %struct.S2* %arrayidx29, i32 0, i32 0, !dbg !96
  store i8 %conv27, i8* %s2_a, align 4, !dbg !97
  %18 = load i32, i32* %i18, align 4, !dbg !98
  %idxprom30 = sext i32 %18 to i64, !dbg !99
  %arrayidx31 = getelementptr inbounds [3 x %struct.S2], [3 x %struct.S2]* @objects, i64 0, i64 %idxprom30, !dbg !99
  %s2_s132 = getelementptr inbounds %struct.S2, %struct.S2* %arrayidx31, i32 0, i32 2, !dbg !100
  %s1_b33 = getelementptr inbounds %struct.S1, %struct.S1* %s2_s132, i32 0, i32 1, !dbg !101
  %19 = load i32, i32* %s1_b33, align 4, !dbg !101
  %conv34 = trunc i32 %19 to i8, !dbg !102
  %20 = load i32, i32* %i18, align 4, !dbg !103
  %idxprom35 = sext i32 %20 to i64, !dbg !104
  %arrayidx36 = getelementptr inbounds [3 x %struct.S2], [3 x %struct.S2]* @objects, i64 0, i64 %idxprom35, !dbg !104
  %s2_b = getelementptr inbounds %struct.S2, %struct.S2* %arrayidx36, i32 0, i32 1, !dbg !105
  store i8 %conv34, i8* %s2_b, align 1, !dbg !106
  %21 = load i32, i32* %i18, align 4, !dbg !107
  %idxprom37 = sext i32 %21 to i64, !dbg !108
  %arrayidx38 = getelementptr inbounds [3 x %struct.S2], [3 x %struct.S2]* @objects, i64 0, i64 %idxprom37, !dbg !108
  %s2_a39 = getelementptr inbounds %struct.S2, %struct.S2* %arrayidx38, i32 0, i32 0, !dbg !109
  %22 = load i8, i8* %s2_a39, align 4, !dbg !109
  %conv40 = sext i8 %22 to i32, !dbg !108
  %23 = load i8, i8* %c1, align 1, !dbg !110
  %conv41 = sext i8 %23 to i32, !dbg !110
  %cmp42 = icmp eq i32 %conv40, %conv41, !dbg !111
  %conv43 = zext i1 %cmp42 to i32, !dbg !111
  %call44 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv43), !dbg !112
  %24 = load i32, i32* %i18, align 4, !dbg !113
  %idxprom45 = sext i32 %24 to i64, !dbg !114
  %arrayidx46 = getelementptr inbounds [3 x %struct.S2], [3 x %struct.S2]* @objects, i64 0, i64 %idxprom45, !dbg !114
  %s2_b47 = getelementptr inbounds %struct.S2, %struct.S2* %arrayidx46, i32 0, i32 1, !dbg !115
  %25 = load i8, i8* %s2_b47, align 1, !dbg !115
  %conv48 = sext i8 %25 to i32, !dbg !114
  %26 = load i8, i8* %c2, align 1, !dbg !116
  %conv49 = sext i8 %26 to i32, !dbg !116
  %cmp50 = icmp eq i32 %conv48, %conv49, !dbg !117
  %conv51 = zext i1 %cmp50 to i32, !dbg !117
  %call52 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv51), !dbg !118
  %27 = load i8, i8* %c1, align 1, !dbg !119
  %inc53 = add i8 %27, 1, !dbg !119
  store i8 %inc53, i8* %c1, align 1, !dbg !119
  %28 = load i8, i8* %c2, align 1, !dbg !120
  %inc54 = add i8 %28, 1, !dbg !120
  store i8 %inc54, i8* %c2, align 1, !dbg !120
  br label %for.inc55, !dbg !121

for.inc55:                                        ; preds = %for.body22
  %29 = load i32, i32* %i18, align 4, !dbg !122
  %inc56 = add nsw i32 %29, 1, !dbg !122
  store i32 %inc56, i32* %i18, align 4, !dbg !122
  br label %for.cond19, !dbg !123, !llvm.loop !124

for.end57:                                        ; preds = %for.cond19
  ret i32 0, !dbg !126
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!21, !22, !23}
!llvm.ident = !{!24}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "objects", scope: !2, file: !3, line: 14, type: !8, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 8.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !5, globals: !7, nameTableKind: None)
!3 = !DIFile(filename: "akash_struct_3/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!4 = !{}
!5 = !{!6}
!6 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!7 = !{!0}
!8 = !DICompositeType(tag: DW_TAG_array_type, baseType: !9, size: 288, elements: !19)
!9 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "S2", file: !3, line: 9, size: 96, elements: !10)
!10 = !{!11, !12, !13}
!11 = !DIDerivedType(tag: DW_TAG_member, name: "s2_a", scope: !9, file: !3, line: 10, baseType: !6, size: 8)
!12 = !DIDerivedType(tag: DW_TAG_member, name: "s2_b", scope: !9, file: !3, line: 11, baseType: !6, size: 8, offset: 8)
!13 = !DIDerivedType(tag: DW_TAG_member, name: "s2_s1", scope: !9, file: !3, line: 13, baseType: !14, size: 64, offset: 32)
!14 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "S1", file: !3, line: 4, size: 64, elements: !15)
!15 = !{!16, !18}
!16 = !DIDerivedType(tag: DW_TAG_member, name: "s1_a", scope: !14, file: !3, line: 5, baseType: !17, size: 32)
!17 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!18 = !DIDerivedType(tag: DW_TAG_member, name: "s1_b", scope: !14, file: !3, line: 6, baseType: !17, size: 32, offset: 32)
!19 = !{!20}
!20 = !DISubrange(count: 3)
!21 = !{i32 2, !"Dwarf Version", i32 4}
!22 = !{i32 2, !"Debug Info Version", i32 3}
!23 = !{i32 1, !"wchar_size", i32 4}
!24 = !{!"clang version 8.0.0 "}
!25 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 16, type: !26, scopeLine: 16, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!26 = !DISubroutineType(types: !27)
!27 = !{!17}
!28 = !DILocalVariable(name: "v1", scope: !25, file: !3, line: 17, type: !17)
!29 = !DILocation(line: 17, column: 7, scope: !25)
!30 = !DILocalVariable(name: "v2", scope: !25, file: !3, line: 17, type: !17)
!31 = !DILocation(line: 17, column: 11, scope: !25)
!32 = !DILocation(line: 18, column: 6, scope: !25)
!33 = !DILocation(line: 19, column: 6, scope: !25)
!34 = !DILocalVariable(name: "i", scope: !35, file: !3, line: 21, type: !17)
!35 = distinct !DILexicalBlock(scope: !25, file: !3, line: 21, column: 3)
!36 = !DILocation(line: 21, column: 12, scope: !35)
!37 = !DILocation(line: 21, column: 8, scope: !35)
!38 = !DILocation(line: 21, column: 19, scope: !39)
!39 = distinct !DILexicalBlock(scope: !35, file: !3, line: 21, column: 3)
!40 = !DILocation(line: 21, column: 21, scope: !39)
!41 = !DILocation(line: 21, column: 3, scope: !35)
!42 = !DILocation(line: 22, column: 29, scope: !43)
!43 = distinct !DILexicalBlock(scope: !39, file: !3, line: 21, column: 31)
!44 = !DILocation(line: 22, column: 13, scope: !43)
!45 = !DILocation(line: 22, column: 5, scope: !43)
!46 = !DILocation(line: 22, column: 16, scope: !43)
!47 = !DILocation(line: 22, column: 22, scope: !43)
!48 = !DILocation(line: 22, column: 27, scope: !43)
!49 = !DILocation(line: 23, column: 29, scope: !43)
!50 = !DILocation(line: 23, column: 13, scope: !43)
!51 = !DILocation(line: 23, column: 5, scope: !43)
!52 = !DILocation(line: 23, column: 16, scope: !43)
!53 = !DILocation(line: 23, column: 22, scope: !43)
!54 = !DILocation(line: 23, column: 27, scope: !43)
!55 = !DILocation(line: 25, column: 20, scope: !43)
!56 = !DILocation(line: 25, column: 12, scope: !43)
!57 = !DILocation(line: 25, column: 23, scope: !43)
!58 = !DILocation(line: 25, column: 29, scope: !43)
!59 = !DILocation(line: 25, column: 37, scope: !43)
!60 = !DILocation(line: 25, column: 34, scope: !43)
!61 = !DILocation(line: 25, column: 5, scope: !43)
!62 = !DILocation(line: 26, column: 20, scope: !43)
!63 = !DILocation(line: 26, column: 12, scope: !43)
!64 = !DILocation(line: 26, column: 23, scope: !43)
!65 = !DILocation(line: 26, column: 29, scope: !43)
!66 = !DILocation(line: 26, column: 37, scope: !43)
!67 = !DILocation(line: 26, column: 34, scope: !43)
!68 = !DILocation(line: 26, column: 5, scope: !43)
!69 = !DILocation(line: 27, column: 7, scope: !43)
!70 = !DILocation(line: 28, column: 7, scope: !43)
!71 = !DILocation(line: 29, column: 3, scope: !43)
!72 = !DILocation(line: 21, column: 27, scope: !39)
!73 = !DILocation(line: 21, column: 3, scope: !39)
!74 = distinct !{!74, !41, !75}
!75 = !DILocation(line: 29, column: 3, scope: !35)
!76 = !DILocalVariable(name: "c1", scope: !25, file: !3, line: 30, type: !6)
!77 = !DILocation(line: 30, column: 8, scope: !25)
!78 = !DILocalVariable(name: "c2", scope: !25, file: !3, line: 31, type: !6)
!79 = !DILocation(line: 31, column: 8, scope: !25)
!80 = !DILocalVariable(name: "i", scope: !81, file: !3, line: 32, type: !17)
!81 = distinct !DILexicalBlock(scope: !25, file: !3, line: 32, column: 3)
!82 = !DILocation(line: 32, column: 12, scope: !81)
!83 = !DILocation(line: 32, column: 8, scope: !81)
!84 = !DILocation(line: 32, column: 19, scope: !85)
!85 = distinct !DILexicalBlock(scope: !81, file: !3, line: 32, column: 3)
!86 = !DILocation(line: 32, column: 21, scope: !85)
!87 = !DILocation(line: 32, column: 3, scope: !81)
!88 = !DILocation(line: 33, column: 38, scope: !89)
!89 = distinct !DILexicalBlock(scope: !85, file: !3, line: 32, column: 31)
!90 = !DILocation(line: 33, column: 30, scope: !89)
!91 = !DILocation(line: 33, column: 41, scope: !89)
!92 = !DILocation(line: 33, column: 47, scope: !89)
!93 = !DILocation(line: 33, column: 23, scope: !89)
!94 = !DILocation(line: 33, column: 13, scope: !89)
!95 = !DILocation(line: 33, column: 5, scope: !89)
!96 = !DILocation(line: 33, column: 16, scope: !89)
!97 = !DILocation(line: 33, column: 21, scope: !89)
!98 = !DILocation(line: 34, column: 38, scope: !89)
!99 = !DILocation(line: 34, column: 30, scope: !89)
!100 = !DILocation(line: 34, column: 41, scope: !89)
!101 = !DILocation(line: 34, column: 47, scope: !89)
!102 = !DILocation(line: 34, column: 23, scope: !89)
!103 = !DILocation(line: 34, column: 13, scope: !89)
!104 = !DILocation(line: 34, column: 5, scope: !89)
!105 = !DILocation(line: 34, column: 16, scope: !89)
!106 = !DILocation(line: 34, column: 21, scope: !89)
!107 = !DILocation(line: 36, column: 20, scope: !89)
!108 = !DILocation(line: 36, column: 12, scope: !89)
!109 = !DILocation(line: 36, column: 23, scope: !89)
!110 = !DILocation(line: 36, column: 31, scope: !89)
!111 = !DILocation(line: 36, column: 28, scope: !89)
!112 = !DILocation(line: 36, column: 5, scope: !89)
!113 = !DILocation(line: 37, column: 20, scope: !89)
!114 = !DILocation(line: 37, column: 12, scope: !89)
!115 = !DILocation(line: 37, column: 23, scope: !89)
!116 = !DILocation(line: 37, column: 31, scope: !89)
!117 = !DILocation(line: 37, column: 28, scope: !89)
!118 = !DILocation(line: 37, column: 5, scope: !89)
!119 = !DILocation(line: 39, column: 7, scope: !89)
!120 = !DILocation(line: 40, column: 7, scope: !89)
!121 = !DILocation(line: 41, column: 3, scope: !89)
!122 = !DILocation(line: 32, column: 27, scope: !85)
!123 = !DILocation(line: 32, column: 3, scope: !85)
!124 = distinct !{!124, !87, !125}
!125 = !DILocation(line: 41, column: 3, scope: !81)
!126 = !DILocation(line: 43, column: 3, scope: !25)

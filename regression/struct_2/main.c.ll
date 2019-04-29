; ModuleID = 'struct_2/main.c'
source_filename = "struct_2/main.c"
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
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %v1, metadata !28, metadata !DIExpression()), !dbg !29
  call void @llvm.dbg.declare(metadata i32* %v2, metadata !30, metadata !DIExpression()), !dbg !31
  store i32 48, i32* %v1, align 4, !dbg !32
  store i32 49, i32* %v2, align 4, !dbg !33
  call void @llvm.dbg.declare(metadata i32* %i, metadata !34, metadata !DIExpression()), !dbg !35
  store i32 0, i32* %i, align 4, !dbg !35
  br label %while.cond, !dbg !36

while.cond:                                       ; preds = %land.end, %entry
  %0 = load i32, i32* %i, align 4, !dbg !37
  %cmp = icmp slt i32 %0, 3, !dbg !38
  br i1 %cmp, label %while.body, label %while.end, !dbg !36

while.body:                                       ; preds = %while.cond
  %1 = load i32, i32* %v1, align 4, !dbg !39
  %2 = load i32, i32* %i, align 4, !dbg !41
  %idxprom = sext i32 %2 to i64, !dbg !42
  %arrayidx = getelementptr inbounds [3 x %struct.S2], [3 x %struct.S2]* @objects, i64 0, i64 %idxprom, !dbg !42
  %s2_s1 = getelementptr inbounds %struct.S2, %struct.S2* %arrayidx, i32 0, i32 2, !dbg !43
  %s1_a = getelementptr inbounds %struct.S1, %struct.S1* %s2_s1, i32 0, i32 0, !dbg !44
  store i32 %1, i32* %s1_a, align 4, !dbg !45
  %3 = load i32, i32* %v2, align 4, !dbg !46
  %4 = load i32, i32* %i, align 4, !dbg !47
  %idxprom1 = sext i32 %4 to i64, !dbg !48
  %arrayidx2 = getelementptr inbounds [3 x %struct.S2], [3 x %struct.S2]* @objects, i64 0, i64 %idxprom1, !dbg !48
  %s2_s13 = getelementptr inbounds %struct.S2, %struct.S2* %arrayidx2, i32 0, i32 2, !dbg !49
  %s1_b = getelementptr inbounds %struct.S1, %struct.S1* %s2_s13, i32 0, i32 1, !dbg !50
  store i32 %3, i32* %s1_b, align 4, !dbg !51
  %5 = load i32, i32* %v1, align 4, !dbg !52
  %inc = add nsw i32 %5, 1, !dbg !52
  store i32 %inc, i32* %v1, align 4, !dbg !52
  %6 = load i32, i32* %v2, align 4, !dbg !53
  %inc4 = add nsw i32 %6, 1, !dbg !53
  store i32 %inc4, i32* %v2, align 4, !dbg !53
  %7 = load i32, i32* %i, align 4, !dbg !54
  %idxprom5 = sext i32 %7 to i64, !dbg !55
  %arrayidx6 = getelementptr inbounds [3 x %struct.S2], [3 x %struct.S2]* @objects, i64 0, i64 %idxprom5, !dbg !55
  %s2_s17 = getelementptr inbounds %struct.S2, %struct.S2* %arrayidx6, i32 0, i32 2, !dbg !56
  %s1_a8 = getelementptr inbounds %struct.S1, %struct.S1* %s2_s17, i32 0, i32 0, !dbg !57
  %8 = load i32, i32* %s1_a8, align 4, !dbg !57
  %9 = load i32, i32* %v1, align 4, !dbg !58
  %sub = sub nsw i32 %9, 1, !dbg !59
  %cmp9 = icmp eq i32 %8, %sub, !dbg !60
  br i1 %cmp9, label %land.rhs, label %land.end, !dbg !61

land.rhs:                                         ; preds = %while.body
  %10 = load i32, i32* %i, align 4, !dbg !62
  %idxprom10 = sext i32 %10 to i64, !dbg !63
  %arrayidx11 = getelementptr inbounds [3 x %struct.S2], [3 x %struct.S2]* @objects, i64 0, i64 %idxprom10, !dbg !63
  %s2_s112 = getelementptr inbounds %struct.S2, %struct.S2* %arrayidx11, i32 0, i32 2, !dbg !64
  %s1_b13 = getelementptr inbounds %struct.S1, %struct.S1* %s2_s112, i32 0, i32 1, !dbg !65
  %11 = load i32, i32* %s1_b13, align 4, !dbg !65
  %12 = load i32, i32* %v2, align 4, !dbg !66
  %sub14 = sub nsw i32 %12, 1, !dbg !67
  %cmp15 = icmp eq i32 %11, %sub14, !dbg !68
  br label %land.end

land.end:                                         ; preds = %land.rhs, %while.body
  %13 = phi i1 [ false, %while.body ], [ %cmp15, %land.rhs ], !dbg !69
  %land.ext = zext i1 %13 to i32, !dbg !61
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %land.ext), !dbg !70
  %14 = load i32, i32* %i, align 4, !dbg !71
  %inc16 = add nsw i32 %14, 1, !dbg !71
  store i32 %inc16, i32* %i, align 4, !dbg !71
  br label %while.cond, !dbg !36, !llvm.loop !72

while.end:                                        ; preds = %while.cond
  store i32 0, i32* %i, align 4, !dbg !74
  call void @llvm.dbg.declare(metadata i8* %c1, metadata !75, metadata !DIExpression()), !dbg !76
  store i8 48, i8* %c1, align 1, !dbg !76
  call void @llvm.dbg.declare(metadata i8* %c2, metadata !77, metadata !DIExpression()), !dbg !78
  store i8 49, i8* %c2, align 1, !dbg !78
  br label %while.cond17, !dbg !79

while.cond17:                                     ; preds = %land.end48, %while.end
  %15 = load i32, i32* %i, align 4, !dbg !80
  %cmp18 = icmp slt i32 %15, 3, !dbg !81
  br i1 %cmp18, label %while.body19, label %while.end54, !dbg !79

while.body19:                                     ; preds = %while.cond17
  %16 = load i32, i32* %i, align 4, !dbg !82
  %idxprom20 = sext i32 %16 to i64, !dbg !84
  %arrayidx21 = getelementptr inbounds [3 x %struct.S2], [3 x %struct.S2]* @objects, i64 0, i64 %idxprom20, !dbg !84
  %s2_s122 = getelementptr inbounds %struct.S2, %struct.S2* %arrayidx21, i32 0, i32 2, !dbg !85
  %s1_a23 = getelementptr inbounds %struct.S1, %struct.S1* %s2_s122, i32 0, i32 0, !dbg !86
  %17 = load i32, i32* %s1_a23, align 4, !dbg !86
  %conv = trunc i32 %17 to i8, !dbg !87
  %18 = load i32, i32* %i, align 4, !dbg !88
  %idxprom24 = sext i32 %18 to i64, !dbg !89
  %arrayidx25 = getelementptr inbounds [3 x %struct.S2], [3 x %struct.S2]* @objects, i64 0, i64 %idxprom24, !dbg !89
  %s2_a = getelementptr inbounds %struct.S2, %struct.S2* %arrayidx25, i32 0, i32 0, !dbg !90
  store i8 %conv, i8* %s2_a, align 4, !dbg !91
  %19 = load i32, i32* %i, align 4, !dbg !92
  %idxprom26 = sext i32 %19 to i64, !dbg !93
  %arrayidx27 = getelementptr inbounds [3 x %struct.S2], [3 x %struct.S2]* @objects, i64 0, i64 %idxprom26, !dbg !93
  %s2_s128 = getelementptr inbounds %struct.S2, %struct.S2* %arrayidx27, i32 0, i32 2, !dbg !94
  %s1_b29 = getelementptr inbounds %struct.S1, %struct.S1* %s2_s128, i32 0, i32 1, !dbg !95
  %20 = load i32, i32* %s1_b29, align 4, !dbg !95
  %conv30 = trunc i32 %20 to i8, !dbg !96
  %21 = load i32, i32* %i, align 4, !dbg !97
  %idxprom31 = sext i32 %21 to i64, !dbg !98
  %arrayidx32 = getelementptr inbounds [3 x %struct.S2], [3 x %struct.S2]* @objects, i64 0, i64 %idxprom31, !dbg !98
  %s2_b = getelementptr inbounds %struct.S2, %struct.S2* %arrayidx32, i32 0, i32 1, !dbg !99
  store i8 %conv30, i8* %s2_b, align 1, !dbg !100
  %22 = load i32, i32* %i, align 4, !dbg !101
  %idxprom33 = sext i32 %22 to i64, !dbg !102
  %arrayidx34 = getelementptr inbounds [3 x %struct.S2], [3 x %struct.S2]* @objects, i64 0, i64 %idxprom33, !dbg !102
  %s2_a35 = getelementptr inbounds %struct.S2, %struct.S2* %arrayidx34, i32 0, i32 0, !dbg !103
  %23 = load i8, i8* %s2_a35, align 4, !dbg !103
  %conv36 = sext i8 %23 to i32, !dbg !102
  %24 = load i8, i8* %c1, align 1, !dbg !104
  %conv37 = sext i8 %24 to i32, !dbg !104
  %cmp38 = icmp eq i32 %conv36, %conv37, !dbg !105
  br i1 %cmp38, label %land.rhs40, label %land.end48, !dbg !106

land.rhs40:                                       ; preds = %while.body19
  %25 = load i32, i32* %i, align 4, !dbg !107
  %idxprom41 = sext i32 %25 to i64, !dbg !108
  %arrayidx42 = getelementptr inbounds [3 x %struct.S2], [3 x %struct.S2]* @objects, i64 0, i64 %idxprom41, !dbg !108
  %s2_b43 = getelementptr inbounds %struct.S2, %struct.S2* %arrayidx42, i32 0, i32 1, !dbg !109
  %26 = load i8, i8* %s2_b43, align 1, !dbg !109
  %conv44 = sext i8 %26 to i32, !dbg !108
  %27 = load i8, i8* %c2, align 1, !dbg !110
  %conv45 = sext i8 %27 to i32, !dbg !110
  %cmp46 = icmp eq i32 %conv44, %conv45, !dbg !111
  br label %land.end48

land.end48:                                       ; preds = %land.rhs40, %while.body19
  %28 = phi i1 [ false, %while.body19 ], [ %cmp46, %land.rhs40 ], !dbg !112
  %land.ext49 = zext i1 %28 to i32, !dbg !106
  %call50 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %land.ext49), !dbg !113
  %29 = load i8, i8* %c1, align 1, !dbg !114
  %inc51 = add i8 %29, 1, !dbg !114
  store i8 %inc51, i8* %c1, align 1, !dbg !114
  %30 = load i8, i8* %c2, align 1, !dbg !115
  %inc52 = add i8 %30, 1, !dbg !115
  store i8 %inc52, i8* %c2, align 1, !dbg !115
  %31 = load i32, i32* %i, align 4, !dbg !116
  %inc53 = add nsw i32 %31, 1, !dbg !116
  store i32 %inc53, i32* %i, align 4, !dbg !116
  br label %while.cond17, !dbg !79, !llvm.loop !117

while.end54:                                      ; preds = %while.cond17
  ret i32 0, !dbg !119
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
!1 = distinct !DIGlobalVariable(name: "objects", scope: !2, file: !3, line: 16, type: !8, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 8.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !5, globals: !7, nameTableKind: None)
!3 = !DIFile(filename: "struct_2/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!4 = !{}
!5 = !{!6}
!6 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!7 = !{!0}
!8 = !DICompositeType(tag: DW_TAG_array_type, baseType: !9, size: 288, elements: !19)
!9 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "S2", file: !3, line: 10, size: 96, elements: !10)
!10 = !{!11, !12, !13}
!11 = !DIDerivedType(tag: DW_TAG_member, name: "s2_a", scope: !9, file: !3, line: 12, baseType: !6, size: 8)
!12 = !DIDerivedType(tag: DW_TAG_member, name: "s2_b", scope: !9, file: !3, line: 13, baseType: !6, size: 8, offset: 8)
!13 = !DIDerivedType(tag: DW_TAG_member, name: "s2_s1", scope: !9, file: !3, line: 15, baseType: !14, size: 64, offset: 32)
!14 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "S1", file: !3, line: 4, size: 64, elements: !15)
!15 = !{!16, !18}
!16 = !DIDerivedType(tag: DW_TAG_member, name: "s1_a", scope: !14, file: !3, line: 6, baseType: !17, size: 32)
!17 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!18 = !DIDerivedType(tag: DW_TAG_member, name: "s1_b", scope: !14, file: !3, line: 7, baseType: !17, size: 32, offset: 32)
!19 = !{!20}
!20 = !DISubrange(count: 3)
!21 = !{i32 2, !"Dwarf Version", i32 4}
!22 = !{i32 2, !"Debug Info Version", i32 3}
!23 = !{i32 1, !"wchar_size", i32 4}
!24 = !{!"clang version 8.0.0 "}
!25 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 18, type: !26, scopeLine: 19, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!26 = !DISubroutineType(types: !27)
!27 = !{!17}
!28 = !DILocalVariable(name: "v1", scope: !25, file: !3, line: 20, type: !17)
!29 = !DILocation(line: 20, column: 6, scope: !25)
!30 = !DILocalVariable(name: "v2", scope: !25, file: !3, line: 20, type: !17)
!31 = !DILocation(line: 20, column: 10, scope: !25)
!32 = !DILocation(line: 21, column: 5, scope: !25)
!33 = !DILocation(line: 22, column: 5, scope: !25)
!34 = !DILocalVariable(name: "i", scope: !25, file: !3, line: 24, type: !17)
!35 = !DILocation(line: 24, column: 6, scope: !25)
!36 = !DILocation(line: 25, column: 2, scope: !25)
!37 = !DILocation(line: 25, column: 8, scope: !25)
!38 = !DILocation(line: 25, column: 9, scope: !25)
!39 = !DILocation(line: 27, column: 27, scope: !40)
!40 = distinct !DILexicalBlock(scope: !25, file: !3, line: 26, column: 2)
!41 = !DILocation(line: 27, column: 11, scope: !40)
!42 = !DILocation(line: 27, column: 3, scope: !40)
!43 = !DILocation(line: 27, column: 14, scope: !40)
!44 = !DILocation(line: 27, column: 20, scope: !40)
!45 = !DILocation(line: 27, column: 25, scope: !40)
!46 = !DILocation(line: 28, column: 27, scope: !40)
!47 = !DILocation(line: 28, column: 11, scope: !40)
!48 = !DILocation(line: 28, column: 3, scope: !40)
!49 = !DILocation(line: 28, column: 14, scope: !40)
!50 = !DILocation(line: 28, column: 20, scope: !40)
!51 = !DILocation(line: 28, column: 25, scope: !40)
!52 = !DILocation(line: 29, column: 5, scope: !40)
!53 = !DILocation(line: 30, column: 5, scope: !40)
!54 = !DILocation(line: 32, column: 18, scope: !40)
!55 = !DILocation(line: 32, column: 10, scope: !40)
!56 = !DILocation(line: 32, column: 21, scope: !40)
!57 = !DILocation(line: 32, column: 27, scope: !40)
!58 = !DILocation(line: 32, column: 36, scope: !40)
!59 = !DILocation(line: 32, column: 38, scope: !40)
!60 = !DILocation(line: 32, column: 32, scope: !40)
!61 = !DILocation(line: 32, column: 42, scope: !40)
!62 = !DILocation(line: 32, column: 53, scope: !40)
!63 = !DILocation(line: 32, column: 45, scope: !40)
!64 = !DILocation(line: 32, column: 56, scope: !40)
!65 = !DILocation(line: 32, column: 62, scope: !40)
!66 = !DILocation(line: 32, column: 71, scope: !40)
!67 = !DILocation(line: 32, column: 73, scope: !40)
!68 = !DILocation(line: 32, column: 67, scope: !40)
!69 = !DILocation(line: 0, scope: !40)
!70 = !DILocation(line: 32, column: 3, scope: !40)
!71 = !DILocation(line: 33, column: 4, scope: !40)
!72 = distinct !{!72, !36, !73}
!73 = !DILocation(line: 34, column: 2, scope: !25)
!74 = !DILocation(line: 36, column: 3, scope: !25)
!75 = !DILocalVariable(name: "c1", scope: !25, file: !3, line: 37, type: !6)
!76 = !DILocation(line: 37, column: 7, scope: !25)
!77 = !DILocalVariable(name: "c2", scope: !25, file: !3, line: 38, type: !6)
!78 = !DILocation(line: 38, column: 7, scope: !25)
!79 = !DILocation(line: 40, column: 2, scope: !25)
!80 = !DILocation(line: 40, column: 8, scope: !25)
!81 = !DILocation(line: 40, column: 9, scope: !25)
!82 = !DILocation(line: 42, column: 36, scope: !83)
!83 = distinct !DILexicalBlock(scope: !25, file: !3, line: 41, column: 2)
!84 = !DILocation(line: 42, column: 28, scope: !83)
!85 = !DILocation(line: 42, column: 39, scope: !83)
!86 = !DILocation(line: 42, column: 45, scope: !83)
!87 = !DILocation(line: 42, column: 21, scope: !83)
!88 = !DILocation(line: 42, column: 11, scope: !83)
!89 = !DILocation(line: 42, column: 3, scope: !83)
!90 = !DILocation(line: 42, column: 14, scope: !83)
!91 = !DILocation(line: 42, column: 19, scope: !83)
!92 = !DILocation(line: 43, column: 36, scope: !83)
!93 = !DILocation(line: 43, column: 28, scope: !83)
!94 = !DILocation(line: 43, column: 39, scope: !83)
!95 = !DILocation(line: 43, column: 45, scope: !83)
!96 = !DILocation(line: 43, column: 21, scope: !83)
!97 = !DILocation(line: 43, column: 11, scope: !83)
!98 = !DILocation(line: 43, column: 3, scope: !83)
!99 = !DILocation(line: 43, column: 14, scope: !83)
!100 = !DILocation(line: 43, column: 19, scope: !83)
!101 = !DILocation(line: 45, column: 18, scope: !83)
!102 = !DILocation(line: 45, column: 10, scope: !83)
!103 = !DILocation(line: 45, column: 21, scope: !83)
!104 = !DILocation(line: 45, column: 29, scope: !83)
!105 = !DILocation(line: 45, column: 26, scope: !83)
!106 = !DILocation(line: 45, column: 32, scope: !83)
!107 = !DILocation(line: 45, column: 43, scope: !83)
!108 = !DILocation(line: 45, column: 35, scope: !83)
!109 = !DILocation(line: 45, column: 46, scope: !83)
!110 = !DILocation(line: 45, column: 54, scope: !83)
!111 = !DILocation(line: 45, column: 51, scope: !83)
!112 = !DILocation(line: 0, scope: !83)
!113 = !DILocation(line: 45, column: 3, scope: !83)
!114 = !DILocation(line: 47, column: 5, scope: !83)
!115 = !DILocation(line: 48, column: 5, scope: !83)
!116 = !DILocation(line: 49, column: 4, scope: !83)
!117 = distinct !{!117, !79, !118}
!118 = !DILocation(line: 50, column: 2, scope: !25)
!119 = !DILocation(line: 53, column: 2, scope: !25)

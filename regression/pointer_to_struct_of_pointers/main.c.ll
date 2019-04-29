; ModuleID = 'pointer_to_struct_of_pointers/main.c'
source_filename = "pointer_to_struct_of_pointers/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.S = type { [3 x i32*] }

@s_arr = common dso_local global [3 x %struct.S] zeroinitializer, align 16, !dbg !0

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !19 {
entry:
  %retval = alloca i32, align 4
  %array = alloca [3 x [3 x i32]], align 16
  %temp = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %s_ptr = alloca %struct.S*, align 8
  %i10 = alloca i32, align 4
  %j14 = alloca i32, align 4
  %x = alloca i32, align 4
  %i31 = alloca i32, align 4
  %j35 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata [3 x [3 x i32]]* %array, metadata !22, metadata !DIExpression()), !dbg !25
  call void @llvm.dbg.declare(metadata i32* %temp, metadata !26, metadata !DIExpression()), !dbg !27
  store i32 11, i32* %temp, align 4, !dbg !27
  call void @llvm.dbg.declare(metadata i32* %i, metadata !28, metadata !DIExpression()), !dbg !30
  store i32 0, i32* %i, align 4, !dbg !30
  br label %for.cond, !dbg !31

for.cond:                                         ; preds = %for.inc7, %entry
  %0 = load i32, i32* %i, align 4, !dbg !32
  %cmp = icmp slt i32 %0, 3, !dbg !34
  br i1 %cmp, label %for.body, label %for.end9, !dbg !35

for.body:                                         ; preds = %for.cond
  call void @llvm.dbg.declare(metadata i32* %j, metadata !36, metadata !DIExpression()), !dbg !39
  store i32 0, i32* %j, align 4, !dbg !39
  br label %for.cond1, !dbg !40

for.cond1:                                        ; preds = %for.inc, %for.body
  %1 = load i32, i32* %j, align 4, !dbg !41
  %cmp2 = icmp slt i32 %1, 3, !dbg !43
  br i1 %cmp2, label %for.body3, label %for.end, !dbg !44

for.body3:                                        ; preds = %for.cond1
  %2 = load i32, i32* %temp, align 4, !dbg !45
  %3 = load i32, i32* %i, align 4, !dbg !47
  %idxprom = sext i32 %3 to i64, !dbg !48
  %arrayidx = getelementptr inbounds [3 x [3 x i32]], [3 x [3 x i32]]* %array, i64 0, i64 %idxprom, !dbg !48
  %4 = load i32, i32* %j, align 4, !dbg !49
  %idxprom4 = sext i32 %4 to i64, !dbg !48
  %arrayidx5 = getelementptr inbounds [3 x i32], [3 x i32]* %arrayidx, i64 0, i64 %idxprom4, !dbg !48
  store i32 %2, i32* %arrayidx5, align 4, !dbg !50
  %5 = load i32, i32* %temp, align 4, !dbg !51
  %inc = add nsw i32 %5, 1, !dbg !51
  store i32 %inc, i32* %temp, align 4, !dbg !51
  br label %for.inc, !dbg !52

for.inc:                                          ; preds = %for.body3
  %6 = load i32, i32* %j, align 4, !dbg !53
  %inc6 = add nsw i32 %6, 1, !dbg !53
  store i32 %inc6, i32* %j, align 4, !dbg !53
  br label %for.cond1, !dbg !54, !llvm.loop !55

for.end:                                          ; preds = %for.cond1
  br label %for.inc7, !dbg !57

for.inc7:                                         ; preds = %for.end
  %7 = load i32, i32* %i, align 4, !dbg !58
  %inc8 = add nsw i32 %7, 1, !dbg !58
  store i32 %inc8, i32* %i, align 4, !dbg !58
  br label %for.cond, !dbg !59, !llvm.loop !60

for.end9:                                         ; preds = %for.cond
  call void @llvm.dbg.declare(metadata %struct.S** %s_ptr, metadata !62, metadata !DIExpression()), !dbg !64
  store %struct.S* getelementptr inbounds ([3 x %struct.S], [3 x %struct.S]* @s_arr, i32 0, i32 0), %struct.S** %s_ptr, align 8, !dbg !65
  call void @llvm.dbg.declare(metadata i32* %i10, metadata !66, metadata !DIExpression()), !dbg !68
  store i32 0, i32* %i10, align 4, !dbg !68
  br label %for.cond11, !dbg !69

for.cond11:                                       ; preds = %for.inc28, %for.end9
  %8 = load i32, i32* %i10, align 4, !dbg !70
  %cmp12 = icmp slt i32 %8, 3, !dbg !72
  br i1 %cmp12, label %for.body13, label %for.end30, !dbg !73

for.body13:                                       ; preds = %for.cond11
  call void @llvm.dbg.declare(metadata i32* %j14, metadata !74, metadata !DIExpression()), !dbg !77
  store i32 0, i32* %j14, align 4, !dbg !77
  br label %for.cond15, !dbg !78

for.cond15:                                       ; preds = %for.inc25, %for.body13
  %9 = load i32, i32* %j14, align 4, !dbg !79
  %cmp16 = icmp slt i32 %9, 3, !dbg !81
  br i1 %cmp16, label %for.body17, label %for.end27, !dbg !82

for.body17:                                       ; preds = %for.cond15
  %arraydecay = getelementptr inbounds [3 x [3 x i32]], [3 x [3 x i32]]* %array, i32 0, i32 0, !dbg !83
  %10 = load i32, i32* %i10, align 4, !dbg !85
  %idx.ext = sext i32 %10 to i64, !dbg !86
  %add.ptr = getelementptr inbounds [3 x i32], [3 x i32]* %arraydecay, i64 %idx.ext, !dbg !86
  %arraydecay18 = getelementptr inbounds [3 x i32], [3 x i32]* %add.ptr, i32 0, i32 0, !dbg !87
  %11 = load i32, i32* %j14, align 4, !dbg !88
  %idx.ext19 = sext i32 %11 to i64, !dbg !89
  %add.ptr20 = getelementptr inbounds i32, i32* %arraydecay18, i64 %idx.ext19, !dbg !89
  %12 = load i32, i32* %i10, align 4, !dbg !90
  %idxprom21 = sext i32 %12 to i64, !dbg !91
  %arrayidx22 = getelementptr inbounds [3 x %struct.S], [3 x %struct.S]* @s_arr, i64 0, i64 %idxprom21, !dbg !91
  %ptrs = getelementptr inbounds %struct.S, %struct.S* %arrayidx22, i32 0, i32 0, !dbg !92
  %13 = load i32, i32* %j14, align 4, !dbg !93
  %idxprom23 = sext i32 %13 to i64, !dbg !91
  %arrayidx24 = getelementptr inbounds [3 x i32*], [3 x i32*]* %ptrs, i64 0, i64 %idxprom23, !dbg !91
  store i32* %add.ptr20, i32** %arrayidx24, align 8, !dbg !94
  br label %for.inc25, !dbg !95

for.inc25:                                        ; preds = %for.body17
  %14 = load i32, i32* %j14, align 4, !dbg !96
  %inc26 = add nsw i32 %14, 1, !dbg !96
  store i32 %inc26, i32* %j14, align 4, !dbg !96
  br label %for.cond15, !dbg !97, !llvm.loop !98

for.end27:                                        ; preds = %for.cond15
  br label %for.inc28, !dbg !100

for.inc28:                                        ; preds = %for.end27
  %15 = load i32, i32* %i10, align 4, !dbg !101
  %inc29 = add nsw i32 %15, 1, !dbg !101
  store i32 %inc29, i32* %i10, align 4, !dbg !101
  br label %for.cond11, !dbg !102, !llvm.loop !103

for.end30:                                        ; preds = %for.cond11
  call void @llvm.dbg.declare(metadata i32* %x, metadata !105, metadata !DIExpression()), !dbg !106
  store i32 11, i32* %x, align 4, !dbg !106
  call void @llvm.dbg.declare(metadata i32* %i31, metadata !107, metadata !DIExpression()), !dbg !109
  store i32 0, i32* %i31, align 4, !dbg !109
  br label %for.cond32, !dbg !110

for.cond32:                                       ; preds = %for.inc49, %for.end30
  %16 = load i32, i32* %i31, align 4, !dbg !111
  %cmp33 = icmp slt i32 %16, 3, !dbg !113
  br i1 %cmp33, label %for.body34, label %for.end51, !dbg !114

for.body34:                                       ; preds = %for.cond32
  call void @llvm.dbg.declare(metadata i32* %j35, metadata !115, metadata !DIExpression()), !dbg !118
  store i32 0, i32* %j35, align 4, !dbg !118
  br label %for.cond36, !dbg !119

for.cond36:                                       ; preds = %for.inc46, %for.body34
  %17 = load i32, i32* %j35, align 4, !dbg !120
  %cmp37 = icmp slt i32 %17, 3, !dbg !122
  br i1 %cmp37, label %for.body38, label %for.end48, !dbg !123

for.body38:                                       ; preds = %for.cond36
  %18 = load %struct.S*, %struct.S** %s_ptr, align 8, !dbg !124
  %19 = load i32, i32* %i31, align 4, !dbg !126
  %idx.ext39 = sext i32 %19 to i64, !dbg !127
  %add.ptr40 = getelementptr inbounds %struct.S, %struct.S* %18, i64 %idx.ext39, !dbg !127
  %ptrs41 = getelementptr inbounds %struct.S, %struct.S* %add.ptr40, i32 0, i32 0, !dbg !128
  %20 = load i32, i32* %j35, align 4, !dbg !129
  %idxprom42 = sext i32 %20 to i64, !dbg !130
  %arrayidx43 = getelementptr inbounds [3 x i32*], [3 x i32*]* %ptrs41, i64 0, i64 %idxprom42, !dbg !130
  %21 = load i32*, i32** %arrayidx43, align 8, !dbg !130
  %22 = load i32, i32* %21, align 4, !dbg !131
  %23 = load i32, i32* %x, align 4, !dbg !132
  %cmp44 = icmp eq i32 %22, %23, !dbg !133
  %conv = zext i1 %cmp44 to i32, !dbg !133
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !134
  %24 = load i32, i32* %x, align 4, !dbg !135
  %inc45 = add nsw i32 %24, 1, !dbg !135
  store i32 %inc45, i32* %x, align 4, !dbg !135
  br label %for.inc46, !dbg !136

for.inc46:                                        ; preds = %for.body38
  %25 = load i32, i32* %j35, align 4, !dbg !137
  %inc47 = add nsw i32 %25, 1, !dbg !137
  store i32 %inc47, i32* %j35, align 4, !dbg !137
  br label %for.cond36, !dbg !138, !llvm.loop !139

for.end48:                                        ; preds = %for.cond36
  br label %for.inc49, !dbg !141

for.inc49:                                        ; preds = %for.end48
  %26 = load i32, i32* %i31, align 4, !dbg !142
  %inc50 = add nsw i32 %26, 1, !dbg !142
  store i32 %inc50, i32* %i31, align 4, !dbg !142
  br label %for.cond32, !dbg !143, !llvm.loop !144

for.end51:                                        ; preds = %for.cond32
  ret i32 0, !dbg !146
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!15, !16, !17}
!llvm.ident = !{!18}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "s_arr", scope: !2, file: !3, line: 4, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 8.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5, nameTableKind: None)
!3 = !DIFile(filename: "pointer_to_struct_of_pointers/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!4 = !{}
!5 = !{!0}
!6 = !DICompositeType(tag: DW_TAG_array_type, baseType: !7, size: 576, elements: !13)
!7 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "S", file: !3, line: 1, size: 192, elements: !8)
!8 = !{!9}
!9 = !DIDerivedType(tag: DW_TAG_member, name: "ptrs", scope: !7, file: !3, line: 3, baseType: !10, size: 192)
!10 = !DICompositeType(tag: DW_TAG_array_type, baseType: !11, size: 192, elements: !13)
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !{!14}
!14 = !DISubrange(count: 3)
!15 = !{i32 2, !"Dwarf Version", i32 4}
!16 = !{i32 2, !"Debug Info Version", i32 3}
!17 = !{i32 1, !"wchar_size", i32 4}
!18 = !{!"clang version 8.0.0 "}
!19 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 6, type: !20, scopeLine: 7, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!20 = !DISubroutineType(types: !21)
!21 = !{!12}
!22 = !DILocalVariable(name: "array", scope: !19, file: !3, line: 8, type: !23)
!23 = !DICompositeType(tag: DW_TAG_array_type, baseType: !12, size: 288, elements: !24)
!24 = !{!14, !14}
!25 = !DILocation(line: 8, column: 6, scope: !19)
!26 = !DILocalVariable(name: "temp", scope: !19, file: !3, line: 9, type: !12)
!27 = !DILocation(line: 9, column: 6, scope: !19)
!28 = !DILocalVariable(name: "i", scope: !29, file: !3, line: 11, type: !12)
!29 = distinct !DILexicalBlock(scope: !19, file: !3, line: 11, column: 2)
!30 = !DILocation(line: 11, column: 10, scope: !29)
!31 = !DILocation(line: 11, column: 6, scope: !29)
!32 = !DILocation(line: 11, column: 16, scope: !33)
!33 = distinct !DILexicalBlock(scope: !29, file: !3, line: 11, column: 2)
!34 = !DILocation(line: 11, column: 17, scope: !33)
!35 = !DILocation(line: 11, column: 2, scope: !29)
!36 = !DILocalVariable(name: "j", scope: !37, file: !3, line: 13, type: !12)
!37 = distinct !DILexicalBlock(scope: !38, file: !3, line: 13, column: 4)
!38 = distinct !DILexicalBlock(scope: !33, file: !3, line: 12, column: 2)
!39 = !DILocation(line: 13, column: 12, scope: !37)
!40 = !DILocation(line: 13, column: 8, scope: !37)
!41 = !DILocation(line: 13, column: 18, scope: !42)
!42 = distinct !DILexicalBlock(scope: !37, file: !3, line: 13, column: 4)
!43 = !DILocation(line: 13, column: 19, scope: !42)
!44 = !DILocation(line: 13, column: 4, scope: !37)
!45 = !DILocation(line: 15, column: 30, scope: !46)
!46 = distinct !DILexicalBlock(scope: !42, file: !3, line: 14, column: 4)
!47 = !DILocation(line: 15, column: 22, scope: !46)
!48 = !DILocation(line: 15, column: 16, scope: !46)
!49 = !DILocation(line: 15, column: 25, scope: !46)
!50 = !DILocation(line: 15, column: 28, scope: !46)
!51 = !DILocation(line: 16, column: 20, scope: !46)
!52 = !DILocation(line: 17, column: 11, scope: !46)
!53 = !DILocation(line: 13, column: 25, scope: !42)
!54 = !DILocation(line: 13, column: 4, scope: !42)
!55 = distinct !{!55, !44, !56}
!56 = !DILocation(line: 17, column: 11, scope: !37)
!57 = !DILocation(line: 18, column: 9, scope: !38)
!58 = !DILocation(line: 11, column: 23, scope: !33)
!59 = !DILocation(line: 11, column: 2, scope: !33)
!60 = distinct !{!60, !35, !61}
!61 = !DILocation(line: 18, column: 9, scope: !29)
!62 = !DILocalVariable(name: "s_ptr", scope: !19, file: !3, line: 20, type: !63)
!63 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!64 = !DILocation(line: 20, column: 13, scope: !19)
!65 = !DILocation(line: 21, column: 8, scope: !19)
!66 = !DILocalVariable(name: "i", scope: !67, file: !3, line: 23, type: !12)
!67 = distinct !DILexicalBlock(scope: !19, file: !3, line: 23, column: 2)
!68 = !DILocation(line: 23, column: 10, scope: !67)
!69 = !DILocation(line: 23, column: 6, scope: !67)
!70 = !DILocation(line: 23, column: 16, scope: !71)
!71 = distinct !DILexicalBlock(scope: !67, file: !3, line: 23, column: 2)
!72 = !DILocation(line: 23, column: 17, scope: !71)
!73 = !DILocation(line: 23, column: 2, scope: !67)
!74 = !DILocalVariable(name: "j", scope: !75, file: !3, line: 25, type: !12)
!75 = distinct !DILexicalBlock(scope: !76, file: !3, line: 25, column: 3)
!76 = distinct !DILexicalBlock(scope: !71, file: !3, line: 24, column: 2)
!77 = !DILocation(line: 25, column: 11, scope: !75)
!78 = !DILocation(line: 25, column: 7, scope: !75)
!79 = !DILocation(line: 25, column: 17, scope: !80)
!80 = distinct !DILexicalBlock(scope: !75, file: !3, line: 25, column: 3)
!81 = !DILocation(line: 25, column: 18, scope: !80)
!82 = !DILocation(line: 25, column: 3, scope: !75)
!83 = !DILocation(line: 27, column: 26, scope: !84)
!84 = distinct !DILexicalBlock(scope: !80, file: !3, line: 26, column: 3)
!85 = !DILocation(line: 27, column: 32, scope: !84)
!86 = !DILocation(line: 27, column: 31, scope: !84)
!87 = !DILocation(line: 27, column: 24, scope: !84)
!88 = !DILocation(line: 27, column: 35, scope: !84)
!89 = !DILocation(line: 27, column: 34, scope: !84)
!90 = !DILocation(line: 27, column: 10, scope: !84)
!91 = !DILocation(line: 27, column: 4, scope: !84)
!92 = !DILocation(line: 27, column: 13, scope: !84)
!93 = !DILocation(line: 27, column: 18, scope: !84)
!94 = !DILocation(line: 27, column: 21, scope: !84)
!95 = !DILocation(line: 28, column: 3, scope: !84)
!96 = !DILocation(line: 25, column: 23, scope: !80)
!97 = !DILocation(line: 25, column: 3, scope: !80)
!98 = distinct !{!98, !82, !99}
!99 = !DILocation(line: 28, column: 3, scope: !75)
!100 = !DILocation(line: 29, column: 2, scope: !76)
!101 = !DILocation(line: 23, column: 23, scope: !71)
!102 = !DILocation(line: 23, column: 2, scope: !71)
!103 = distinct !{!103, !73, !104}
!104 = !DILocation(line: 29, column: 2, scope: !67)
!105 = !DILocalVariable(name: "x", scope: !19, file: !3, line: 31, type: !12)
!106 = !DILocation(line: 31, column: 6, scope: !19)
!107 = !DILocalVariable(name: "i", scope: !108, file: !3, line: 32, type: !12)
!108 = distinct !DILexicalBlock(scope: !19, file: !3, line: 32, column: 2)
!109 = !DILocation(line: 32, column: 10, scope: !108)
!110 = !DILocation(line: 32, column: 6, scope: !108)
!111 = !DILocation(line: 32, column: 16, scope: !112)
!112 = distinct !DILexicalBlock(scope: !108, file: !3, line: 32, column: 2)
!113 = !DILocation(line: 32, column: 17, scope: !112)
!114 = !DILocation(line: 32, column: 2, scope: !108)
!115 = !DILocalVariable(name: "j", scope: !116, file: !3, line: 34, type: !12)
!116 = distinct !DILexicalBlock(scope: !117, file: !3, line: 34, column: 3)
!117 = distinct !DILexicalBlock(scope: !112, file: !3, line: 33, column: 2)
!118 = !DILocation(line: 34, column: 11, scope: !116)
!119 = !DILocation(line: 34, column: 7, scope: !116)
!120 = !DILocation(line: 34, column: 17, scope: !121)
!121 = distinct !DILexicalBlock(scope: !116, file: !3, line: 34, column: 3)
!122 = !DILocation(line: 34, column: 18, scope: !121)
!123 = !DILocation(line: 34, column: 3, scope: !116)
!124 = !DILocation(line: 36, column: 16, scope: !125)
!125 = distinct !DILexicalBlock(scope: !121, file: !3, line: 35, column: 3)
!126 = !DILocation(line: 36, column: 22, scope: !125)
!127 = !DILocation(line: 36, column: 21, scope: !125)
!128 = !DILocation(line: 36, column: 26, scope: !125)
!129 = !DILocation(line: 36, column: 31, scope: !125)
!130 = !DILocation(line: 36, column: 13, scope: !125)
!131 = !DILocation(line: 36, column: 11, scope: !125)
!132 = !DILocation(line: 36, column: 38, scope: !125)
!133 = !DILocation(line: 36, column: 35, scope: !125)
!134 = !DILocation(line: 36, column: 4, scope: !125)
!135 = !DILocation(line: 37, column: 5, scope: !125)
!136 = !DILocation(line: 38, column: 3, scope: !125)
!137 = !DILocation(line: 34, column: 24, scope: !121)
!138 = !DILocation(line: 34, column: 3, scope: !121)
!139 = distinct !{!139, !123, !140}
!140 = !DILocation(line: 38, column: 3, scope: !116)
!141 = !DILocation(line: 39, column: 2, scope: !117)
!142 = !DILocation(line: 32, column: 23, scope: !112)
!143 = !DILocation(line: 32, column: 2, scope: !112)
!144 = distinct !{!144, !114, !145}
!145 = !DILocation(line: 39, column: 2, scope: !108)
!146 = !DILocation(line: 41, column: 2, scope: !19)

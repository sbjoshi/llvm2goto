; ModuleID = 'Multi_Dimensional_Array3/main.c'
source_filename = "Multi_Dimensional_Array3/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@x = common global i32 0, align 4, !dbg !0
@y = common global i32 0, align 4, !dbg !6
@z = common global i32 0, align 4, !dbg !9

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !14 {
entry:
  %retval = alloca i32, align 4
  %array = alloca [3 x [3 x i32*]], align 16
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %p = alloca i32*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata [3 x [3 x i32*]]* %array, metadata !17, metadata !23), !dbg !24
  call void @llvm.dbg.declare(metadata i32* %i, metadata !25, metadata !23), !dbg !27
  store i32 0, i32* %i, align 4, !dbg !27
  br label %for.cond, !dbg !28

for.cond:                                         ; preds = %for.inc14, %entry
  %0 = load i32, i32* %i, align 4, !dbg !29
  %cmp = icmp slt i32 %0, 3, !dbg !32
  br i1 %cmp, label %for.body, label %for.end16, !dbg !33

for.body:                                         ; preds = %for.cond
  call void @llvm.dbg.declare(metadata i32* %j, metadata !35, metadata !23), !dbg !38
  store i32 0, i32* %j, align 4, !dbg !38
  br label %for.cond1, !dbg !39

for.cond1:                                        ; preds = %for.inc11, %for.body
  %1 = load i32, i32* %j, align 4, !dbg !40
  %cmp2 = icmp slt i32 %1, 3, !dbg !43
  br i1 %cmp2, label %for.body3, label %for.end13, !dbg !44

for.body3:                                        ; preds = %for.cond1
  call void @llvm.dbg.declare(metadata i32* %k, metadata !46, metadata !23), !dbg !49
  store i32 0, i32* %k, align 4, !dbg !49
  br label %for.cond4, !dbg !50

for.cond4:                                        ; preds = %for.inc, %for.body3
  %2 = load i32, i32* %k, align 4, !dbg !51
  %cmp5 = icmp slt i32 %2, 3, !dbg !54
  br i1 %cmp5, label %for.body6, label %for.end, !dbg !55

for.body6:                                        ; preds = %for.cond4
  %3 = load i32, i32* %i, align 4, !dbg !57
  %idxprom = sext i32 %3 to i64, !dbg !59
  %arrayidx = getelementptr inbounds [3 x [3 x i32*]], [3 x [3 x i32*]]* %array, i64 0, i64 %idxprom, !dbg !59
  %4 = load i32, i32* %j, align 4, !dbg !60
  %idxprom7 = sext i32 %4 to i64, !dbg !59
  %arrayidx8 = getelementptr inbounds [3 x i32*], [3 x i32*]* %arrayidx, i64 0, i64 %idxprom7, !dbg !59
  %5 = load i32*, i32** %arrayidx8, align 8, !dbg !59
  %6 = load i32, i32* %k, align 4, !dbg !61
  %idxprom9 = sext i32 %6 to i64, !dbg !59
  %arrayidx10 = getelementptr inbounds i32, i32* %5, i64 %idxprom9, !dbg !59
  store i32 0, i32* %arrayidx10, align 4, !dbg !62
  br label %for.inc, !dbg !63

for.inc:                                          ; preds = %for.body6
  %7 = load i32, i32* %k, align 4, !dbg !64
  %inc = add nsw i32 %7, 1, !dbg !64
  store i32 %inc, i32* %k, align 4, !dbg !64
  br label %for.cond4, !dbg !66, !llvm.loop !67

for.end:                                          ; preds = %for.cond4
  br label %for.inc11, !dbg !70

for.inc11:                                        ; preds = %for.end
  %8 = load i32, i32* %j, align 4, !dbg !71
  %inc12 = add nsw i32 %8, 1, !dbg !71
  store i32 %inc12, i32* %j, align 4, !dbg !71
  br label %for.cond1, !dbg !73, !llvm.loop !74

for.end13:                                        ; preds = %for.cond1
  br label %for.inc14, !dbg !77

for.inc14:                                        ; preds = %for.end13
  %9 = load i32, i32* %i, align 4, !dbg !78
  %inc15 = add nsw i32 %9, 1, !dbg !78
  store i32 %inc15, i32* %i, align 4, !dbg !78
  br label %for.cond, !dbg !80, !llvm.loop !81

for.end16:                                        ; preds = %for.cond
  %arrayidx17 = getelementptr inbounds [3 x [3 x i32*]], [3 x [3 x i32*]]* %array, i64 0, i64 1, !dbg !84
  %arrayidx18 = getelementptr inbounds [3 x i32*], [3 x i32*]* %arrayidx17, i64 0, i64 0, !dbg !84
  %10 = load i32*, i32** %arrayidx18, align 8, !dbg !84
  %arrayidx19 = getelementptr inbounds i32, i32* %10, i64 0, !dbg !84
  store i32 ptrtoint (i32* @x to i32), i32* %arrayidx19, align 4, !dbg !85
  %arrayidx20 = getelementptr inbounds [3 x [3 x i32*]], [3 x [3 x i32*]]* %array, i64 0, i64 2, !dbg !86
  %arrayidx21 = getelementptr inbounds [3 x i32*], [3 x i32*]* %arrayidx20, i64 0, i64 0, !dbg !86
  %11 = load i32*, i32** %arrayidx21, align 16, !dbg !86
  %arrayidx22 = getelementptr inbounds i32, i32* %11, i64 0, !dbg !86
  store i32 ptrtoint (i32* @y to i32), i32* %arrayidx22, align 4, !dbg !87
  %arrayidx23 = getelementptr inbounds [3 x [3 x i32*]], [3 x [3 x i32*]]* %array, i64 0, i64 3, !dbg !88
  %arrayidx24 = getelementptr inbounds [3 x i32*], [3 x i32*]* %arrayidx23, i64 0, i64 0, !dbg !88
  %12 = load i32*, i32** %arrayidx24, align 8, !dbg !88
  %arrayidx25 = getelementptr inbounds i32, i32* %12, i64 0, !dbg !88
  store i32 ptrtoint (i32* @z to i32), i32* %arrayidx25, align 4, !dbg !89
  call void @llvm.dbg.declare(metadata i32* %a, metadata !90, metadata !23), !dbg !92
  call void @llvm.dbg.declare(metadata i32* %b, metadata !93, metadata !23), !dbg !94
  %call = call i32 (...) @nondet_uint(), !dbg !95
  store i32 %call, i32* %a, align 4, !dbg !96
  %call26 = call i32 (...) @nondet_uint(), !dbg !97
  store i32 %call26, i32* %b, align 4, !dbg !98
  %13 = load i32, i32* %a, align 4, !dbg !99
  %cmp27 = icmp ult i32 %13, 3, !dbg !100
  br i1 %cmp27, label %land.rhs, label %land.end, !dbg !101

land.rhs:                                         ; preds = %for.end16
  %14 = load i32, i32* %b, align 4, !dbg !102
  %cmp28 = icmp ult i32 %14, 3, !dbg !104
  br label %land.end

land.end:                                         ; preds = %land.rhs, %for.end16
  %15 = phi i1 [ false, %for.end16 ], [ %cmp28, %land.rhs ]
  %land.ext = zext i1 %15 to i32, !dbg !105
  %call29 = call i32 (i32, ...) bitcast (i32 (...)* @assume to i32 (i32, ...)*)(i32 %land.ext), !dbg !107
  %16 = load i32, i32* %a, align 4, !dbg !108
  %idxprom30 = zext i32 %16 to i64, !dbg !109
  %arrayidx31 = getelementptr inbounds [3 x [3 x i32*]], [3 x [3 x i32*]]* %array, i64 0, i64 %idxprom30, !dbg !109
  %17 = load i32, i32* %b, align 4, !dbg !110
  %idxprom32 = zext i32 %17 to i64, !dbg !109
  %arrayidx33 = getelementptr inbounds [3 x i32*], [3 x i32*]* %arrayidx31, i64 0, i64 %idxprom32, !dbg !109
  store i32* @z, i32** %arrayidx33, align 8, !dbg !111
  call void @llvm.dbg.declare(metadata i32** %p, metadata !112, metadata !23), !dbg !113
  %18 = load i32, i32* %a, align 4, !dbg !114
  %idxprom34 = zext i32 %18 to i64, !dbg !115
  %arrayidx35 = getelementptr inbounds [3 x [3 x i32*]], [3 x [3 x i32*]]* %array, i64 0, i64 %idxprom34, !dbg !115
  %19 = load i32, i32* %b, align 4, !dbg !116
  %idxprom36 = zext i32 %19 to i64, !dbg !115
  %arrayidx37 = getelementptr inbounds [3 x i32*], [3 x i32*]* %arrayidx35, i64 0, i64 %idxprom36, !dbg !115
  %20 = load i32*, i32** %arrayidx37, align 8, !dbg !115
  store i32* %20, i32** %p, align 8, !dbg !117
  %21 = load i32*, i32** %p, align 8, !dbg !118
  store i32 1, i32* %21, align 4, !dbg !119
  %22 = load i32, i32* @z, align 4, !dbg !120
  %cmp38 = icmp eq i32 %22, 1, !dbg !121
  %conv = zext i1 %cmp38 to i32, !dbg !121
  %call39 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !122
  %23 = load i32, i32* %retval, align 4, !dbg !123
  ret i32 %23, !dbg !123
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @nondet_uint(...) #2

declare i32 @assume(...) #2

declare i32 @assert(...) #2

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!11, !12}
!llvm.ident = !{!13}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "x", scope: !2, file: !3, line: 5, type: !8, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.0 (trunk 295264)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "Multi_Dimensional_Array3/main.c", directory: "/home/rasika/llvm2goto/llvm2goto-regression-master")
!4 = !{}
!5 = !{!0, !6, !9}
!6 = !DIGlobalVariableExpression(var: !7)
!7 = distinct !DIGlobalVariable(name: "y", scope: !2, file: !3, line: 5, type: !8, isLocal: false, isDefinition: true)
!8 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!9 = !DIGlobalVariableExpression(var: !10)
!10 = distinct !DIGlobalVariable(name: "z", scope: !2, file: !3, line: 5, type: !8, isLocal: false, isDefinition: true)
!11 = !{i32 2, !"Dwarf Version", i32 4}
!12 = !{i32 2, !"Debug Info Version", i32 3}
!13 = !{!"clang version 5.0.0 (trunk 295264)"}
!14 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 7, type: !15, isLocal: false, isDefinition: true, scopeLine: 8, isOptimized: false, unit: !2, variables: !4)
!15 = !DISubroutineType(types: !16)
!16 = !{!8}
!17 = !DILocalVariable(name: "array", scope: !14, file: !3, line: 12, type: !18)
!18 = !DICompositeType(tag: DW_TAG_array_type, baseType: !19, size: 576, elements: !21)
!19 = !DIDerivedType(tag: DW_TAG_typedef, name: "iptr", file: !3, line: 3, baseType: !20)
!20 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!21 = !{!22, !22}
!22 = !DISubrange(count: 3)
!23 = !DIExpression()
!24 = !DILocation(line: 12, column: 8, scope: !14)
!25 = !DILocalVariable(name: "i", scope: !26, file: !3, line: 14, type: !8)
!26 = distinct !DILexicalBlock(scope: !14, file: !3, line: 14, column: 3)
!27 = !DILocation(line: 14, column: 11, scope: !26)
!28 = !DILocation(line: 14, column: 7, scope: !26)
!29 = !DILocation(line: 14, column: 17, scope: !30)
!30 = !DILexicalBlockFile(scope: !31, file: !3, discriminator: 2)
!31 = distinct !DILexicalBlock(scope: !26, file: !3, line: 14, column: 3)
!32 = !DILocation(line: 14, column: 18, scope: !30)
!33 = !DILocation(line: 14, column: 3, scope: !34)
!34 = !DILexicalBlockFile(scope: !26, file: !3, discriminator: 2)
!35 = !DILocalVariable(name: "j", scope: !36, file: !3, line: 16, type: !8)
!36 = distinct !DILexicalBlock(scope: !37, file: !3, line: 16, column: 6)
!37 = distinct !DILexicalBlock(scope: !31, file: !3, line: 15, column: 3)
!38 = !DILocation(line: 16, column: 14, scope: !36)
!39 = !DILocation(line: 16, column: 10, scope: !36)
!40 = !DILocation(line: 16, column: 20, scope: !41)
!41 = !DILexicalBlockFile(scope: !42, file: !3, discriminator: 2)
!42 = distinct !DILexicalBlock(scope: !36, file: !3, line: 16, column: 6)
!43 = !DILocation(line: 16, column: 21, scope: !41)
!44 = !DILocation(line: 16, column: 6, scope: !45)
!45 = !DILexicalBlockFile(scope: !36, file: !3, discriminator: 2)
!46 = !DILocalVariable(name: "k", scope: !47, file: !3, line: 18, type: !8)
!47 = distinct !DILexicalBlock(scope: !48, file: !3, line: 18, column: 8)
!48 = distinct !DILexicalBlock(scope: !42, file: !3, line: 17, column: 6)
!49 = !DILocation(line: 18, column: 16, scope: !47)
!50 = !DILocation(line: 18, column: 12, scope: !47)
!51 = !DILocation(line: 18, column: 22, scope: !52)
!52 = !DILexicalBlockFile(scope: !53, file: !3, discriminator: 2)
!53 = distinct !DILexicalBlock(scope: !47, file: !3, line: 18, column: 8)
!54 = !DILocation(line: 18, column: 23, scope: !52)
!55 = !DILocation(line: 18, column: 8, scope: !56)
!56 = !DILexicalBlockFile(scope: !47, file: !3, discriminator: 2)
!57 = !DILocation(line: 20, column: 18, scope: !58)
!58 = distinct !DILexicalBlock(scope: !53, file: !3, line: 19, column: 2)
!59 = !DILocation(line: 20, column: 12, scope: !58)
!60 = !DILocation(line: 20, column: 21, scope: !58)
!61 = !DILocation(line: 20, column: 24, scope: !58)
!62 = !DILocation(line: 20, column: 27, scope: !58)
!63 = !DILocation(line: 21, column: 9, scope: !58)
!64 = !DILocation(line: 18, column: 29, scope: !65)
!65 = !DILexicalBlockFile(scope: !53, file: !3, discriminator: 4)
!66 = !DILocation(line: 18, column: 8, scope: !65)
!67 = distinct !{!67, !68, !69}
!68 = !DILocation(line: 18, column: 8, scope: !47)
!69 = !DILocation(line: 21, column: 9, scope: !47)
!70 = !DILocation(line: 22, column: 6, scope: !48)
!71 = !DILocation(line: 16, column: 27, scope: !72)
!72 = !DILexicalBlockFile(scope: !42, file: !3, discriminator: 4)
!73 = !DILocation(line: 16, column: 6, scope: !72)
!74 = distinct !{!74, !75, !76}
!75 = !DILocation(line: 16, column: 6, scope: !36)
!76 = !DILocation(line: 22, column: 6, scope: !36)
!77 = !DILocation(line: 23, column: 4, scope: !37)
!78 = !DILocation(line: 14, column: 23, scope: !79)
!79 = !DILexicalBlockFile(scope: !31, file: !3, discriminator: 4)
!80 = !DILocation(line: 14, column: 3, scope: !79)
!81 = distinct !{!81, !82, !83}
!82 = !DILocation(line: 14, column: 3, scope: !26)
!83 = !DILocation(line: 23, column: 4, scope: !26)
!84 = !DILocation(line: 25, column: 3, scope: !14)
!85 = !DILocation(line: 25, column: 18, scope: !14)
!86 = !DILocation(line: 26, column: 3, scope: !14)
!87 = !DILocation(line: 26, column: 18, scope: !14)
!88 = !DILocation(line: 27, column: 3, scope: !14)
!89 = !DILocation(line: 27, column: 18, scope: !14)
!90 = !DILocalVariable(name: "a", scope: !14, file: !3, line: 30, type: !91)
!91 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!92 = !DILocation(line: 30, column: 16, scope: !14)
!93 = !DILocalVariable(name: "b", scope: !14, file: !3, line: 30, type: !91)
!94 = !DILocation(line: 30, column: 19, scope: !14)
!95 = !DILocation(line: 31, column: 7, scope: !14)
!96 = !DILocation(line: 31, column: 5, scope: !14)
!97 = !DILocation(line: 32, column: 7, scope: !14)
!98 = !DILocation(line: 32, column: 5, scope: !14)
!99 = !DILocation(line: 34, column: 11, scope: !14)
!100 = !DILocation(line: 34, column: 13, scope: !14)
!101 = !DILocation(line: 34, column: 17, scope: !14)
!102 = !DILocation(line: 34, column: 20, scope: !103)
!103 = !DILexicalBlockFile(scope: !14, file: !3, discriminator: 2)
!104 = !DILocation(line: 34, column: 22, scope: !103)
!105 = !DILocation(line: 34, column: 17, scope: !106)
!106 = !DILexicalBlockFile(scope: !14, file: !3, discriminator: 4)
!107 = !DILocation(line: 34, column: 3, scope: !106)
!108 = !DILocation(line: 36, column: 9, scope: !14)
!109 = !DILocation(line: 36, column: 3, scope: !14)
!110 = !DILocation(line: 36, column: 12, scope: !14)
!111 = !DILocation(line: 36, column: 15, scope: !14)
!112 = !DILocalVariable(name: "p", scope: !14, file: !3, line: 38, type: !19)
!113 = !DILocation(line: 38, column: 8, scope: !14)
!114 = !DILocation(line: 39, column: 11, scope: !14)
!115 = !DILocation(line: 39, column: 5, scope: !14)
!116 = !DILocation(line: 39, column: 14, scope: !14)
!117 = !DILocation(line: 39, column: 4, scope: !14)
!118 = !DILocation(line: 41, column: 4, scope: !14)
!119 = !DILocation(line: 41, column: 5, scope: !14)
!120 = !DILocation(line: 43, column: 10, scope: !14)
!121 = !DILocation(line: 43, column: 11, scope: !14)
!122 = !DILocation(line: 43, column: 3, scope: !14)
!123 = !DILocation(line: 44, column: 1, scope: !14)

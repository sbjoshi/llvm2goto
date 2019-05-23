; ModuleID = 'Multi_Dimensional_Array3/main.c'
source_filename = "Multi_Dimensional_Array3/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@x = common dso_local global i32 0, align 4, !dbg !0
@y = common dso_local global i32 0, align 4, !dbg !6
@z = common dso_local global i32 0, align 4, !dbg !9

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !15 {
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
  call void @llvm.dbg.declare(metadata [3 x [3 x i32*]]* %array, metadata !18, metadata !DIExpression()), !dbg !24
  call void @llvm.dbg.declare(metadata i32* %i, metadata !25, metadata !DIExpression()), !dbg !27
  store i32 0, i32* %i, align 4, !dbg !27
  br label %for.cond, !dbg !28

for.cond:                                         ; preds = %for.inc14, %entry
  %0 = load i32, i32* %i, align 4, !dbg !29
  %cmp = icmp slt i32 %0, 3, !dbg !31
  br i1 %cmp, label %for.body, label %for.end16, !dbg !32

for.body:                                         ; preds = %for.cond
  call void @llvm.dbg.declare(metadata i32* %j, metadata !33, metadata !DIExpression()), !dbg !36
  store i32 0, i32* %j, align 4, !dbg !36
  br label %for.cond1, !dbg !37

for.cond1:                                        ; preds = %for.inc11, %for.body
  %1 = load i32, i32* %j, align 4, !dbg !38
  %cmp2 = icmp slt i32 %1, 3, !dbg !40
  br i1 %cmp2, label %for.body3, label %for.end13, !dbg !41

for.body3:                                        ; preds = %for.cond1
  call void @llvm.dbg.declare(metadata i32* %k, metadata !42, metadata !DIExpression()), !dbg !45
  store i32 0, i32* %k, align 4, !dbg !45
  br label %for.cond4, !dbg !46

for.cond4:                                        ; preds = %for.inc, %for.body3
  %2 = load i32, i32* %k, align 4, !dbg !47
  %cmp5 = icmp slt i32 %2, 3, !dbg !49
  br i1 %cmp5, label %for.body6, label %for.end, !dbg !50

for.body6:                                        ; preds = %for.cond4
  %3 = load i32, i32* %i, align 4, !dbg !51
  %idxprom = sext i32 %3 to i64, !dbg !53
  %arrayidx = getelementptr inbounds [3 x [3 x i32*]], [3 x [3 x i32*]]* %array, i64 0, i64 %idxprom, !dbg !53
  %4 = load i32, i32* %j, align 4, !dbg !54
  %idxprom7 = sext i32 %4 to i64, !dbg !53
  %arrayidx8 = getelementptr inbounds [3 x i32*], [3 x i32*]* %arrayidx, i64 0, i64 %idxprom7, !dbg !53
  %5 = load i32*, i32** %arrayidx8, align 8, !dbg !53
  %6 = load i32, i32* %k, align 4, !dbg !55
  %idxprom9 = sext i32 %6 to i64, !dbg !53
  %arrayidx10 = getelementptr inbounds i32, i32* %5, i64 %idxprom9, !dbg !53
  store i32 0, i32* %arrayidx10, align 4, !dbg !56
  br label %for.inc, !dbg !57

for.inc:                                          ; preds = %for.body6
  %7 = load i32, i32* %k, align 4, !dbg !58
  %inc = add nsw i32 %7, 1, !dbg !58
  store i32 %inc, i32* %k, align 4, !dbg !58
  br label %for.cond4, !dbg !59, !llvm.loop !60

for.end:                                          ; preds = %for.cond4
  br label %for.inc11, !dbg !62

for.inc11:                                        ; preds = %for.end
  %8 = load i32, i32* %j, align 4, !dbg !63
  %inc12 = add nsw i32 %8, 1, !dbg !63
  store i32 %inc12, i32* %j, align 4, !dbg !63
  br label %for.cond1, !dbg !64, !llvm.loop !65

for.end13:                                        ; preds = %for.cond1
  br label %for.inc14, !dbg !67

for.inc14:                                        ; preds = %for.end13
  %9 = load i32, i32* %i, align 4, !dbg !68
  %inc15 = add nsw i32 %9, 1, !dbg !68
  store i32 %inc15, i32* %i, align 4, !dbg !68
  br label %for.cond, !dbg !69, !llvm.loop !70

for.end16:                                        ; preds = %for.cond
  %arrayidx17 = getelementptr inbounds [3 x [3 x i32*]], [3 x [3 x i32*]]* %array, i64 0, i64 1, !dbg !72
  %arrayidx18 = getelementptr inbounds [3 x i32*], [3 x i32*]* %arrayidx17, i64 0, i64 0, !dbg !72
  %10 = load i32*, i32** %arrayidx18, align 8, !dbg !72
  %arrayidx19 = getelementptr inbounds i32, i32* %10, i64 0, !dbg !72
  store i32 ptrtoint (i32* @x to i32), i32* %arrayidx19, align 4, !dbg !73
  %arrayidx20 = getelementptr inbounds [3 x [3 x i32*]], [3 x [3 x i32*]]* %array, i64 0, i64 2, !dbg !74
  %arrayidx21 = getelementptr inbounds [3 x i32*], [3 x i32*]* %arrayidx20, i64 0, i64 0, !dbg !74
  %11 = load i32*, i32** %arrayidx21, align 16, !dbg !74
  %arrayidx22 = getelementptr inbounds i32, i32* %11, i64 0, !dbg !74
  store i32 ptrtoint (i32* @y to i32), i32* %arrayidx22, align 4, !dbg !75
  %arrayidx23 = getelementptr inbounds [3 x [3 x i32*]], [3 x [3 x i32*]]* %array, i64 0, i64 3, !dbg !76
  %arrayidx24 = getelementptr inbounds [3 x i32*], [3 x i32*]* %arrayidx23, i64 0, i64 0, !dbg !76
  %12 = load i32*, i32** %arrayidx24, align 8, !dbg !76
  %arrayidx25 = getelementptr inbounds i32, i32* %12, i64 0, !dbg !76
  store i32 ptrtoint (i32* @z to i32), i32* %arrayidx25, align 4, !dbg !77
  call void @llvm.dbg.declare(metadata i32* %a, metadata !78, metadata !DIExpression()), !dbg !80
  call void @llvm.dbg.declare(metadata i32* %b, metadata !81, metadata !DIExpression()), !dbg !82
  %call = call i32 (...) @nondet_uint(), !dbg !83
  store i32 %call, i32* %a, align 4, !dbg !84
  %call26 = call i32 (...) @nondet_uint(), !dbg !85
  store i32 %call26, i32* %b, align 4, !dbg !86
  %13 = load i32, i32* %a, align 4, !dbg !87
  %cmp27 = icmp ult i32 %13, 3, !dbg !88
  %conv = zext i1 %cmp27 to i32, !dbg !88
  %call28 = call i32 (i32, ...) bitcast (i32 (...)* @assume to i32 (i32, ...)*)(i32 %conv), !dbg !89
  %14 = load i32, i32* %b, align 4, !dbg !90
  %cmp29 = icmp ult i32 %14, 3, !dbg !91
  %conv30 = zext i1 %cmp29 to i32, !dbg !91
  %call31 = call i32 (i32, ...) bitcast (i32 (...)* @assume to i32 (i32, ...)*)(i32 %conv30), !dbg !92
  %15 = load i32, i32* %a, align 4, !dbg !93
  %idxprom32 = zext i32 %15 to i64, !dbg !94
  %arrayidx33 = getelementptr inbounds [3 x [3 x i32*]], [3 x [3 x i32*]]* %array, i64 0, i64 %idxprom32, !dbg !94
  %16 = load i32, i32* %b, align 4, !dbg !95
  %idxprom34 = zext i32 %16 to i64, !dbg !94
  %arrayidx35 = getelementptr inbounds [3 x i32*], [3 x i32*]* %arrayidx33, i64 0, i64 %idxprom34, !dbg !94
  store i32* @z, i32** %arrayidx35, align 8, !dbg !96
  call void @llvm.dbg.declare(metadata i32** %p, metadata !97, metadata !DIExpression()), !dbg !98
  %17 = load i32, i32* %a, align 4, !dbg !99
  %idxprom36 = zext i32 %17 to i64, !dbg !100
  %arrayidx37 = getelementptr inbounds [3 x [3 x i32*]], [3 x [3 x i32*]]* %array, i64 0, i64 %idxprom36, !dbg !100
  %18 = load i32, i32* %b, align 4, !dbg !101
  %idxprom38 = zext i32 %18 to i64, !dbg !100
  %arrayidx39 = getelementptr inbounds [3 x i32*], [3 x i32*]* %arrayidx37, i64 0, i64 %idxprom38, !dbg !100
  %19 = load i32*, i32** %arrayidx39, align 8, !dbg !100
  store i32* %19, i32** %p, align 8, !dbg !102
  %20 = load i32*, i32** %p, align 8, !dbg !103
  store i32 1, i32* %20, align 4, !dbg !104
  %21 = load i32, i32* @z, align 4, !dbg !105
  %cmp40 = icmp eq i32 %21, 1, !dbg !106
  %conv41 = zext i1 %cmp40 to i32, !dbg !106
  %call42 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv41), !dbg !107
  %22 = load i32, i32* %retval, align 4, !dbg !108
  ret i32 %22, !dbg !108
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @nondet_uint(...) #2

declare dso_local i32 @assume(...) #2

declare dso_local i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!11, !12, !13}
!llvm.ident = !{!14}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "x", scope: !2, file: !3, line: 5, type: !8, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 8.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5, nameTableKind: None)
!3 = !DIFile(filename: "Multi_Dimensional_Array3/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!4 = !{}
!5 = !{!0, !6, !9}
!6 = !DIGlobalVariableExpression(var: !7, expr: !DIExpression())
!7 = distinct !DIGlobalVariable(name: "y", scope: !2, file: !3, line: 5, type: !8, isLocal: false, isDefinition: true)
!8 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!9 = !DIGlobalVariableExpression(var: !10, expr: !DIExpression())
!10 = distinct !DIGlobalVariable(name: "z", scope: !2, file: !3, line: 5, type: !8, isLocal: false, isDefinition: true)
!11 = !{i32 2, !"Dwarf Version", i32 4}
!12 = !{i32 2, !"Debug Info Version", i32 3}
!13 = !{i32 1, !"wchar_size", i32 4}
!14 = !{!"clang version 8.0.0 "}
!15 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 7, type: !16, scopeLine: 8, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!16 = !DISubroutineType(types: !17)
!17 = !{!8}
!18 = !DILocalVariable(name: "array", scope: !15, file: !3, line: 12, type: !19)
!19 = !DICompositeType(tag: DW_TAG_array_type, baseType: !20, size: 576, elements: !22)
!20 = !DIDerivedType(tag: DW_TAG_typedef, name: "iptr", file: !3, line: 3, baseType: !21)
!21 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!22 = !{!23, !23}
!23 = !DISubrange(count: 3)
!24 = !DILocation(line: 12, column: 8, scope: !15)
!25 = !DILocalVariable(name: "i", scope: !26, file: !3, line: 14, type: !8)
!26 = distinct !DILexicalBlock(scope: !15, file: !3, line: 14, column: 3)
!27 = !DILocation(line: 14, column: 11, scope: !26)
!28 = !DILocation(line: 14, column: 7, scope: !26)
!29 = !DILocation(line: 14, column: 17, scope: !30)
!30 = distinct !DILexicalBlock(scope: !26, file: !3, line: 14, column: 3)
!31 = !DILocation(line: 14, column: 18, scope: !30)
!32 = !DILocation(line: 14, column: 3, scope: !26)
!33 = !DILocalVariable(name: "j", scope: !34, file: !3, line: 16, type: !8)
!34 = distinct !DILexicalBlock(scope: !35, file: !3, line: 16, column: 6)
!35 = distinct !DILexicalBlock(scope: !30, file: !3, line: 15, column: 3)
!36 = !DILocation(line: 16, column: 14, scope: !34)
!37 = !DILocation(line: 16, column: 10, scope: !34)
!38 = !DILocation(line: 16, column: 20, scope: !39)
!39 = distinct !DILexicalBlock(scope: !34, file: !3, line: 16, column: 6)
!40 = !DILocation(line: 16, column: 21, scope: !39)
!41 = !DILocation(line: 16, column: 6, scope: !34)
!42 = !DILocalVariable(name: "k", scope: !43, file: !3, line: 18, type: !8)
!43 = distinct !DILexicalBlock(scope: !44, file: !3, line: 18, column: 8)
!44 = distinct !DILexicalBlock(scope: !39, file: !3, line: 17, column: 6)
!45 = !DILocation(line: 18, column: 16, scope: !43)
!46 = !DILocation(line: 18, column: 12, scope: !43)
!47 = !DILocation(line: 18, column: 22, scope: !48)
!48 = distinct !DILexicalBlock(scope: !43, file: !3, line: 18, column: 8)
!49 = !DILocation(line: 18, column: 23, scope: !48)
!50 = !DILocation(line: 18, column: 8, scope: !43)
!51 = !DILocation(line: 20, column: 18, scope: !52)
!52 = distinct !DILexicalBlock(scope: !48, file: !3, line: 19, column: 2)
!53 = !DILocation(line: 20, column: 12, scope: !52)
!54 = !DILocation(line: 20, column: 21, scope: !52)
!55 = !DILocation(line: 20, column: 24, scope: !52)
!56 = !DILocation(line: 20, column: 27, scope: !52)
!57 = !DILocation(line: 21, column: 9, scope: !52)
!58 = !DILocation(line: 18, column: 29, scope: !48)
!59 = !DILocation(line: 18, column: 8, scope: !48)
!60 = distinct !{!60, !50, !61}
!61 = !DILocation(line: 21, column: 9, scope: !43)
!62 = !DILocation(line: 22, column: 6, scope: !44)
!63 = !DILocation(line: 16, column: 27, scope: !39)
!64 = !DILocation(line: 16, column: 6, scope: !39)
!65 = distinct !{!65, !41, !66}
!66 = !DILocation(line: 22, column: 6, scope: !34)
!67 = !DILocation(line: 23, column: 4, scope: !35)
!68 = !DILocation(line: 14, column: 23, scope: !30)
!69 = !DILocation(line: 14, column: 3, scope: !30)
!70 = distinct !{!70, !32, !71}
!71 = !DILocation(line: 23, column: 4, scope: !26)
!72 = !DILocation(line: 25, column: 3, scope: !15)
!73 = !DILocation(line: 25, column: 18, scope: !15)
!74 = !DILocation(line: 26, column: 3, scope: !15)
!75 = !DILocation(line: 26, column: 18, scope: !15)
!76 = !DILocation(line: 27, column: 3, scope: !15)
!77 = !DILocation(line: 27, column: 18, scope: !15)
!78 = !DILocalVariable(name: "a", scope: !15, file: !3, line: 30, type: !79)
!79 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!80 = !DILocation(line: 30, column: 16, scope: !15)
!81 = !DILocalVariable(name: "b", scope: !15, file: !3, line: 30, type: !79)
!82 = !DILocation(line: 30, column: 19, scope: !15)
!83 = !DILocation(line: 31, column: 7, scope: !15)
!84 = !DILocation(line: 31, column: 5, scope: !15)
!85 = !DILocation(line: 32, column: 7, scope: !15)
!86 = !DILocation(line: 32, column: 5, scope: !15)
!87 = !DILocation(line: 34, column: 11, scope: !15)
!88 = !DILocation(line: 34, column: 13, scope: !15)
!89 = !DILocation(line: 34, column: 3, scope: !15)
!90 = !DILocation(line: 35, column: 10, scope: !15)
!91 = !DILocation(line: 35, column: 11, scope: !15)
!92 = !DILocation(line: 35, column: 3, scope: !15)
!93 = !DILocation(line: 37, column: 9, scope: !15)
!94 = !DILocation(line: 37, column: 3, scope: !15)
!95 = !DILocation(line: 37, column: 12, scope: !15)
!96 = !DILocation(line: 37, column: 15, scope: !15)
!97 = !DILocalVariable(name: "p", scope: !15, file: !3, line: 39, type: !20)
!98 = !DILocation(line: 39, column: 8, scope: !15)
!99 = !DILocation(line: 40, column: 11, scope: !15)
!100 = !DILocation(line: 40, column: 5, scope: !15)
!101 = !DILocation(line: 40, column: 14, scope: !15)
!102 = !DILocation(line: 40, column: 4, scope: !15)
!103 = !DILocation(line: 42, column: 4, scope: !15)
!104 = !DILocation(line: 42, column: 5, scope: !15)
!105 = !DILocation(line: 44, column: 10, scope: !15)
!106 = !DILocation(line: 44, column: 11, scope: !15)
!107 = !DILocation(line: 44, column: 3, scope: !15)
!108 = !DILocation(line: 45, column: 1, scope: !15)

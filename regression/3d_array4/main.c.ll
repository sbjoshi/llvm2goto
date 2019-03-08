; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %array = alloca [2 x [2 x [2 x i32]]], align 16
  %product = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata [2 x [2 x [2 x i32]]]* %array, metadata !11, metadata !DIExpression()), !dbg !15
  call void @llvm.dbg.declare(metadata i32* %product, metadata !16, metadata !DIExpression()), !dbg !17
  store i32 1, i32* %product, align 4, !dbg !17
  call void @llvm.dbg.declare(metadata i32* %i, metadata !18, metadata !DIExpression()), !dbg !20
  store i32 0, i32* %i, align 4, !dbg !20
  br label %for.cond, !dbg !21

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4, !dbg !22
  %cmp = icmp slt i32 %0, 2, !dbg !24
  br i1 %cmp, label %for.body, label %for.end, !dbg !25

for.body:                                         ; preds = %for.cond
  call void @llvm.dbg.declare(metadata i32* %j, metadata !26, metadata !DIExpression()), !dbg !28
  store i32 0, i32* %j, align 4, !dbg !28
  br label %while.cond, !dbg !29

while.cond:                                       ; preds = %while.end, %for.body
  %1 = load i32, i32* %j, align 4, !dbg !30
  %cmp1 = icmp slt i32 %1, 2, !dbg !31
  br i1 %cmp1, label %while.body, label %while.end16, !dbg !29

while.body:                                       ; preds = %while.cond
  call void @llvm.dbg.declare(metadata i32* %k, metadata !32, metadata !DIExpression()), !dbg !34
  store i32 0, i32* %k, align 4, !dbg !34
  br label %while.cond2, !dbg !35

while.cond2:                                      ; preds = %while.body4, %while.body
  %2 = load i32, i32* %k, align 4, !dbg !36
  %cmp3 = icmp slt i32 %2, 2, !dbg !37
  br i1 %cmp3, label %while.body4, label %while.end, !dbg !35

while.body4:                                      ; preds = %while.cond2
  %3 = load i32, i32* %i, align 4, !dbg !38
  %idxprom = sext i32 %3 to i64, !dbg !40
  %arrayidx = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 %idxprom, !dbg !40
  %4 = load i32, i32* %j, align 4, !dbg !41
  %idxprom5 = sext i32 %4 to i64, !dbg !40
  %arrayidx6 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx, i64 0, i64 %idxprom5, !dbg !40
  %5 = load i32, i32* %k, align 4, !dbg !42
  %idxprom7 = sext i32 %5 to i64, !dbg !40
  %arrayidx8 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx6, i64 0, i64 %idxprom7, !dbg !40
  store i32 2, i32* %arrayidx8, align 4, !dbg !43
  %6 = load i32, i32* %i, align 4, !dbg !44
  %idxprom9 = sext i32 %6 to i64, !dbg !45
  %arrayidx10 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 %idxprom9, !dbg !45
  %7 = load i32, i32* %j, align 4, !dbg !46
  %idxprom11 = sext i32 %7 to i64, !dbg !45
  %arrayidx12 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx10, i64 0, i64 %idxprom11, !dbg !45
  %8 = load i32, i32* %k, align 4, !dbg !47
  %idxprom13 = sext i32 %8 to i64, !dbg !45
  %arrayidx14 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx12, i64 0, i64 %idxprom13, !dbg !45
  %9 = load i32, i32* %arrayidx14, align 4, !dbg !45
  %10 = load i32, i32* %product, align 4, !dbg !48
  %mul = mul nsw i32 %9, %10, !dbg !49
  store i32 %mul, i32* %product, align 4, !dbg !50
  %11 = load i32, i32* %k, align 4, !dbg !51
  %inc = add nsw i32 %11, 1, !dbg !51
  store i32 %inc, i32* %k, align 4, !dbg !51
  br label %while.cond2, !dbg !35, !llvm.loop !52

while.end:                                        ; preds = %while.cond2
  %12 = load i32, i32* %j, align 4, !dbg !54
  %inc15 = add nsw i32 %12, 1, !dbg !54
  store i32 %inc15, i32* %j, align 4, !dbg !54
  br label %while.cond, !dbg !29, !llvm.loop !55

while.end16:                                      ; preds = %while.cond
  br label %for.inc, !dbg !57

for.inc:                                          ; preds = %while.end16
  %13 = load i32, i32* %i, align 4, !dbg !58
  %inc17 = add nsw i32 %13, 1, !dbg !58
  store i32 %inc17, i32* %i, align 4, !dbg !58
  br label %for.cond, !dbg !59, !llvm.loop !60

for.end:                                          ; preds = %for.cond
  %14 = load i32, i32* %product, align 4, !dbg !62
  %arrayidx18 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 0, !dbg !63
  %arrayidx19 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx18, i64 0, i64 0, !dbg !63
  %arrayidx20 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx19, i64 0, i64 0, !dbg !63
  %15 = load i32, i32* %arrayidx20, align 16, !dbg !63
  %arrayidx21 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 0, !dbg !64
  %arrayidx22 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx21, i64 0, i64 0, !dbg !64
  %arrayidx23 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx22, i64 0, i64 0, !dbg !64
  %16 = load i32, i32* %arrayidx23, align 16, !dbg !64
  %mul24 = mul nsw i32 %15, %16, !dbg !65
  %arrayidx25 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 0, !dbg !66
  %arrayidx26 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx25, i64 0, i64 0, !dbg !66
  %arrayidx27 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx26, i64 0, i64 0, !dbg !66
  %17 = load i32, i32* %arrayidx27, align 16, !dbg !66
  %mul28 = mul nsw i32 %mul24, %17, !dbg !67
  %arrayidx29 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 0, !dbg !68
  %arrayidx30 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx29, i64 0, i64 0, !dbg !68
  %arrayidx31 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx30, i64 0, i64 0, !dbg !68
  %18 = load i32, i32* %arrayidx31, align 16, !dbg !68
  %mul32 = mul nsw i32 %mul28, %18, !dbg !69
  %arrayidx33 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 0, !dbg !70
  %arrayidx34 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx33, i64 0, i64 0, !dbg !70
  %arrayidx35 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx34, i64 0, i64 0, !dbg !70
  %19 = load i32, i32* %arrayidx35, align 16, !dbg !70
  %mul36 = mul nsw i32 %mul32, %19, !dbg !71
  %arrayidx37 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 0, !dbg !72
  %arrayidx38 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx37, i64 0, i64 0, !dbg !72
  %arrayidx39 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx38, i64 0, i64 0, !dbg !72
  %20 = load i32, i32* %arrayidx39, align 16, !dbg !72
  %mul40 = mul nsw i32 %mul36, %20, !dbg !73
  %arrayidx41 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 0, !dbg !74
  %arrayidx42 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx41, i64 0, i64 0, !dbg !74
  %arrayidx43 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx42, i64 0, i64 0, !dbg !74
  %21 = load i32, i32* %arrayidx43, align 16, !dbg !74
  %mul44 = mul nsw i32 %mul40, %21, !dbg !75
  %arrayidx45 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 0, !dbg !76
  %arrayidx46 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx45, i64 0, i64 0, !dbg !76
  %arrayidx47 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx46, i64 0, i64 0, !dbg !76
  %22 = load i32, i32* %arrayidx47, align 16, !dbg !76
  %mul48 = mul nsw i32 %mul44, %22, !dbg !77
  %cmp49 = icmp eq i32 %14, %mul48, !dbg !78
  %conv = zext i1 %cmp49 to i32, !dbg !78
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !79
  %23 = load i32, i32* %retval, align 4, !dbg !80
  ret i32 %23, !dbg !80
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
!1 = !DIFile(filename: "main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression/3d_array4")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 8.0.0 "}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 3, type: !8, scopeLine: 4, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "array", scope: !7, file: !1, line: 5, type: !12)
!12 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 256, elements: !13)
!13 = !{!14, !14, !14}
!14 = !DISubrange(count: 2)
!15 = !DILocation(line: 5, column: 6, scope: !7)
!16 = !DILocalVariable(name: "product", scope: !7, file: !1, line: 7, type: !10)
!17 = !DILocation(line: 7, column: 6, scope: !7)
!18 = !DILocalVariable(name: "i", scope: !19, file: !1, line: 9, type: !10)
!19 = distinct !DILexicalBlock(scope: !7, file: !1, line: 9, column: 2)
!20 = !DILocation(line: 9, column: 10, scope: !19)
!21 = !DILocation(line: 9, column: 6, scope: !19)
!22 = !DILocation(line: 9, column: 16, scope: !23)
!23 = distinct !DILexicalBlock(scope: !19, file: !1, line: 9, column: 2)
!24 = !DILocation(line: 9, column: 17, scope: !23)
!25 = !DILocation(line: 9, column: 2, scope: !19)
!26 = !DILocalVariable(name: "j", scope: !27, file: !1, line: 11, type: !10)
!27 = distinct !DILexicalBlock(scope: !23, file: !1, line: 10, column: 2)
!28 = !DILocation(line: 11, column: 7, scope: !27)
!29 = !DILocation(line: 12, column: 3, scope: !27)
!30 = !DILocation(line: 12, column: 9, scope: !27)
!31 = !DILocation(line: 12, column: 10, scope: !27)
!32 = !DILocalVariable(name: "k", scope: !33, file: !1, line: 14, type: !10)
!33 = distinct !DILexicalBlock(scope: !27, file: !1, line: 13, column: 3)
!34 = !DILocation(line: 14, column: 8, scope: !33)
!35 = !DILocation(line: 16, column: 4, scope: !33)
!36 = !DILocation(line: 16, column: 10, scope: !33)
!37 = !DILocation(line: 16, column: 11, scope: !33)
!38 = !DILocation(line: 18, column: 14, scope: !39)
!39 = distinct !DILexicalBlock(scope: !33, file: !1, line: 17, column: 4)
!40 = !DILocation(line: 18, column: 8, scope: !39)
!41 = !DILocation(line: 18, column: 17, scope: !39)
!42 = !DILocation(line: 18, column: 20, scope: !39)
!43 = !DILocation(line: 18, column: 23, scope: !39)
!44 = !DILocation(line: 19, column: 21, scope: !39)
!45 = !DILocation(line: 19, column: 15, scope: !39)
!46 = !DILocation(line: 19, column: 24, scope: !39)
!47 = !DILocation(line: 19, column: 27, scope: !39)
!48 = !DILocation(line: 19, column: 32, scope: !39)
!49 = !DILocation(line: 19, column: 30, scope: !39)
!50 = !DILocation(line: 19, column: 13, scope: !39)
!51 = !DILocation(line: 20, column: 6, scope: !39)
!52 = distinct !{!52, !35, !53}
!53 = !DILocation(line: 21, column: 4, scope: !33)
!54 = !DILocation(line: 23, column: 5, scope: !33)
!55 = distinct !{!55, !29, !56}
!56 = !DILocation(line: 24, column: 3, scope: !27)
!57 = !DILocation(line: 25, column: 2, scope: !27)
!58 = !DILocation(line: 9, column: 23, scope: !23)
!59 = !DILocation(line: 9, column: 2, scope: !23)
!60 = distinct !{!60, !25, !61}
!61 = !DILocation(line: 25, column: 2, scope: !19)
!62 = !DILocation(line: 27, column: 9, scope: !7)
!63 = !DILocation(line: 27, column: 20, scope: !7)
!64 = !DILocation(line: 27, column: 35, scope: !7)
!65 = !DILocation(line: 27, column: 34, scope: !7)
!66 = !DILocation(line: 27, column: 50, scope: !7)
!67 = !DILocation(line: 27, column: 49, scope: !7)
!68 = !DILocation(line: 27, column: 65, scope: !7)
!69 = !DILocation(line: 27, column: 64, scope: !7)
!70 = !DILocation(line: 27, column: 80, scope: !7)
!71 = !DILocation(line: 27, column: 79, scope: !7)
!72 = !DILocation(line: 27, column: 95, scope: !7)
!73 = !DILocation(line: 27, column: 94, scope: !7)
!74 = !DILocation(line: 27, column: 110, scope: !7)
!75 = !DILocation(line: 27, column: 109, scope: !7)
!76 = !DILocation(line: 27, column: 125, scope: !7)
!77 = !DILocation(line: 27, column: 124, scope: !7)
!78 = !DILocation(line: 27, column: 17, scope: !7)
!79 = !DILocation(line: 27, column: 2, scope: !7)
!80 = !DILocation(line: 29, column: 1, scope: !7)

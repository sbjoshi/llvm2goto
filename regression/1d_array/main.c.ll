; ModuleID = '1d_array/main.c'
source_filename = "1d_array/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %arr1 = alloca [3 x i32], align 4
  %arr2 = alloca [3 x i32], align 4
  %x = alloca i32, align 4
  %i = alloca i32, align 4
  %arr3 = alloca [3 x i32], align 4
  %i4 = alloca i32, align 4
  %i17 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata [3 x i32]* %arr1, metadata !11, metadata !DIExpression()), !dbg !15
  call void @llvm.dbg.declare(metadata [3 x i32]* %arr2, metadata !16, metadata !DIExpression()), !dbg !17
  call void @llvm.dbg.declare(metadata i32* %x, metadata !18, metadata !DIExpression()), !dbg !19
  store i32 1, i32* %x, align 4, !dbg !19
  call void @llvm.dbg.declare(metadata i32* %i, metadata !20, metadata !DIExpression()), !dbg !22
  store i32 0, i32* %i, align 4, !dbg !22
  br label %for.cond, !dbg !23

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4, !dbg !24
  %cmp = icmp slt i32 %0, 3, !dbg !26
  br i1 %cmp, label %for.body, label %for.end, !dbg !27

for.body:                                         ; preds = %for.cond
  %1 = load i32, i32* %x, align 4, !dbg !28
  %2 = load i32, i32* %i, align 4, !dbg !30
  %idxprom = sext i32 %2 to i64, !dbg !31
  %arrayidx = getelementptr inbounds [3 x i32], [3 x i32]* %arr1, i64 0, i64 %idxprom, !dbg !31
  store i32 %1, i32* %arrayidx, align 4, !dbg !32
  %3 = load i32, i32* %x, align 4, !dbg !33
  %4 = load i32, i32* %i, align 4, !dbg !34
  %idxprom1 = sext i32 %4 to i64, !dbg !35
  %arrayidx2 = getelementptr inbounds [3 x i32], [3 x i32]* %arr2, i64 0, i64 %idxprom1, !dbg !35
  store i32 %3, i32* %arrayidx2, align 4, !dbg !36
  %5 = load i32, i32* %x, align 4, !dbg !37
  %inc = add nsw i32 %5, 1, !dbg !37
  store i32 %inc, i32* %x, align 4, !dbg !37
  br label %for.inc, !dbg !38

for.inc:                                          ; preds = %for.body
  %6 = load i32, i32* %i, align 4, !dbg !39
  %inc3 = add nsw i32 %6, 1, !dbg !39
  store i32 %inc3, i32* %i, align 4, !dbg !39
  br label %for.cond, !dbg !40, !llvm.loop !41

for.end:                                          ; preds = %for.cond
  call void @llvm.dbg.declare(metadata [3 x i32]* %arr3, metadata !43, metadata !DIExpression()), !dbg !44
  call void @llvm.dbg.declare(metadata i32* %i4, metadata !45, metadata !DIExpression()), !dbg !47
  store i32 0, i32* %i4, align 4, !dbg !47
  br label %for.cond5, !dbg !48

for.cond5:                                        ; preds = %for.inc14, %for.end
  %7 = load i32, i32* %i4, align 4, !dbg !49
  %cmp6 = icmp slt i32 %7, 3, !dbg !51
  br i1 %cmp6, label %for.body7, label %for.end16, !dbg !52

for.body7:                                        ; preds = %for.cond5
  %8 = load i32, i32* %i4, align 4, !dbg !53
  %idxprom8 = sext i32 %8 to i64, !dbg !55
  %arrayidx9 = getelementptr inbounds [3 x i32], [3 x i32]* %arr1, i64 0, i64 %idxprom8, !dbg !55
  %9 = load i32, i32* %arrayidx9, align 4, !dbg !55
  %10 = load i32, i32* %i4, align 4, !dbg !56
  %idxprom10 = sext i32 %10 to i64, !dbg !57
  %arrayidx11 = getelementptr inbounds [3 x i32], [3 x i32]* %arr2, i64 0, i64 %idxprom10, !dbg !57
  %11 = load i32, i32* %arrayidx11, align 4, !dbg !57
  %add = add nsw i32 %9, %11, !dbg !58
  %12 = load i32, i32* %i4, align 4, !dbg !59
  %idxprom12 = sext i32 %12 to i64, !dbg !60
  %arrayidx13 = getelementptr inbounds [3 x i32], [3 x i32]* %arr3, i64 0, i64 %idxprom12, !dbg !60
  store i32 %add, i32* %arrayidx13, align 4, !dbg !61
  br label %for.inc14, !dbg !62

for.inc14:                                        ; preds = %for.body7
  %13 = load i32, i32* %i4, align 4, !dbg !63
  %inc15 = add nsw i32 %13, 1, !dbg !63
  store i32 %inc15, i32* %i4, align 4, !dbg !63
  br label %for.cond5, !dbg !64, !llvm.loop !65

for.end16:                                        ; preds = %for.cond5
  call void @llvm.dbg.declare(metadata i32* %i17, metadata !67, metadata !DIExpression()), !dbg !69
  store i32 0, i32* %i17, align 4, !dbg !69
  br label %for.cond18, !dbg !70

for.cond18:                                       ; preds = %for.inc26, %for.end16
  %14 = load i32, i32* %i17, align 4, !dbg !71
  %cmp19 = icmp slt i32 %14, 3, !dbg !73
  br i1 %cmp19, label %for.body20, label %for.end28, !dbg !74

for.body20:                                       ; preds = %for.cond18
  %15 = load i32, i32* %i17, align 4, !dbg !75
  %idxprom21 = sext i32 %15 to i64, !dbg !77
  %arrayidx22 = getelementptr inbounds [3 x i32], [3 x i32]* %arr3, i64 0, i64 %idxprom21, !dbg !77
  %16 = load i32, i32* %arrayidx22, align 4, !dbg !77
  %17 = load i32, i32* %i17, align 4, !dbg !78
  %idxprom23 = sext i32 %17 to i64, !dbg !79
  %arrayidx24 = getelementptr inbounds [3 x i32], [3 x i32]* %arr1, i64 0, i64 %idxprom23, !dbg !79
  %18 = load i32, i32* %arrayidx24, align 4, !dbg !79
  %mul = mul nsw i32 2, %18, !dbg !80
  %cmp25 = icmp ne i32 %16, %mul, !dbg !81
  %conv = zext i1 %cmp25 to i32, !dbg !81
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !82
  br label %for.inc26, !dbg !83

for.inc26:                                        ; preds = %for.body20
  %19 = load i32, i32* %i17, align 4, !dbg !84
  %inc27 = add nsw i32 %19, 1, !dbg !84
  store i32 %inc27, i32* %i17, align 4, !dbg !84
  br label %for.cond18, !dbg !85, !llvm.loop !86

for.end28:                                        ; preds = %for.cond18
  ret i32 0, !dbg !88
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 7.0.1 (https://github.com/llvm-mirror/clang.git 4519e2637fcc4bf6e3049a0a80e6a5e7b97667cb) (https://github.com/llvm-mirror/llvm.git cd98f42d0747826062fc3d2d2fad383aedf58dd6)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "1d_array/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 7.0.1 (https://github.com/llvm-mirror/clang.git 4519e2637fcc4bf6e3049a0a80e6a5e7b97667cb) (https://github.com/llvm-mirror/llvm.git cd98f42d0747826062fc3d2d2fad383aedf58dd6)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 3, type: !8, isLocal: false, isDefinition: true, scopeLine: 4, isOptimized: false, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "arr1", scope: !7, file: !1, line: 5, type: !12)
!12 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 96, elements: !13)
!13 = !{!14}
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
!28 = !DILocation(line: 11, column: 14, scope: !29)
!29 = distinct !DILexicalBlock(scope: !25, file: !1, line: 10, column: 2)
!30 = !DILocation(line: 11, column: 11, scope: !29)
!31 = !DILocation(line: 11, column: 6, scope: !29)
!32 = !DILocation(line: 11, column: 13, scope: !29)
!33 = !DILocation(line: 12, column: 14, scope: !29)
!34 = !DILocation(line: 12, column: 11, scope: !29)
!35 = !DILocation(line: 12, column: 6, scope: !29)
!36 = !DILocation(line: 12, column: 13, scope: !29)
!37 = !DILocation(line: 13, column: 7, scope: !29)
!38 = !DILocation(line: 14, column: 2, scope: !29)
!39 = !DILocation(line: 9, column: 23, scope: !25)
!40 = !DILocation(line: 9, column: 2, scope: !25)
!41 = distinct !{!41, !27, !42}
!42 = !DILocation(line: 14, column: 2, scope: !21)
!43 = !DILocalVariable(name: "arr3", scope: !7, file: !1, line: 16, type: !12)
!44 = !DILocation(line: 16, column: 6, scope: !7)
!45 = !DILocalVariable(name: "i", scope: !46, file: !1, line: 19, type: !10)
!46 = distinct !DILexicalBlock(scope: !7, file: !1, line: 19, column: 2)
!47 = !DILocation(line: 19, column: 10, scope: !46)
!48 = !DILocation(line: 19, column: 6, scope: !46)
!49 = !DILocation(line: 19, column: 16, scope: !50)
!50 = distinct !DILexicalBlock(scope: !46, file: !1, line: 19, column: 2)
!51 = !DILocation(line: 19, column: 17, scope: !50)
!52 = !DILocation(line: 19, column: 2, scope: !46)
!53 = !DILocation(line: 21, column: 18, scope: !54)
!54 = distinct !DILexicalBlock(scope: !50, file: !1, line: 20, column: 2)
!55 = !DILocation(line: 21, column: 13, scope: !54)
!56 = !DILocation(line: 21, column: 28, scope: !54)
!57 = !DILocation(line: 21, column: 23, scope: !54)
!58 = !DILocation(line: 21, column: 21, scope: !54)
!59 = !DILocation(line: 21, column: 8, scope: !54)
!60 = !DILocation(line: 21, column: 3, scope: !54)
!61 = !DILocation(line: 21, column: 11, scope: !54)
!62 = !DILocation(line: 22, column: 2, scope: !54)
!63 = !DILocation(line: 19, column: 23, scope: !50)
!64 = !DILocation(line: 19, column: 2, scope: !50)
!65 = distinct !{!65, !52, !66}
!66 = !DILocation(line: 22, column: 2, scope: !46)
!67 = !DILocalVariable(name: "i", scope: !68, file: !1, line: 25, type: !10)
!68 = distinct !DILexicalBlock(scope: !7, file: !1, line: 25, column: 2)
!69 = !DILocation(line: 25, column: 10, scope: !68)
!70 = !DILocation(line: 25, column: 6, scope: !68)
!71 = !DILocation(line: 25, column: 15, scope: !72)
!72 = distinct !DILexicalBlock(scope: !68, file: !1, line: 25, column: 2)
!73 = !DILocation(line: 25, column: 16, scope: !72)
!74 = !DILocation(line: 25, column: 2, scope: !68)
!75 = !DILocation(line: 27, column: 15, scope: !76)
!76 = distinct !DILexicalBlock(scope: !72, file: !1, line: 26, column: 2)
!77 = !DILocation(line: 27, column: 10, scope: !76)
!78 = !DILocation(line: 27, column: 28, scope: !76)
!79 = !DILocation(line: 27, column: 23, scope: !76)
!80 = !DILocation(line: 27, column: 22, scope: !76)
!81 = !DILocation(line: 27, column: 18, scope: !76)
!82 = !DILocation(line: 27, column: 3, scope: !76)
!83 = !DILocation(line: 28, column: 2, scope: !76)
!84 = !DILocation(line: 25, column: 21, scope: !72)
!85 = !DILocation(line: 25, column: 2, scope: !72)
!86 = distinct !{!86, !74, !87}
!87 = !DILocation(line: 28, column: 2, scope: !68)
!88 = !DILocation(line: 29, column: 2, scope: !7)

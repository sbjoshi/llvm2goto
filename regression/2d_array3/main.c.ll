; ModuleID = '2d_array3/main.c'
source_filename = "2d_array3/main.c"
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
  %i14 = alloca i32, align 4
  %j18 = alloca i32, align 4
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
  call void @llvm.dbg.declare(metadata i32* %i14, metadata !59, metadata !DIExpression()), !dbg !61
  store i32 0, i32* %i14, align 4, !dbg !61
  br label %for.cond15, !dbg !62

for.cond15:                                       ; preds = %for.inc34, %for.end13
  %11 = load i32, i32* %i14, align 4, !dbg !63
  %cmp16 = icmp slt i32 %11, 3, !dbg !65
  br i1 %cmp16, label %for.body17, label %for.end36, !dbg !66

for.body17:                                       ; preds = %for.cond15
  call void @llvm.dbg.declare(metadata i32* %j18, metadata !67, metadata !DIExpression()), !dbg !70
  store i32 0, i32* %j18, align 4, !dbg !70
  br label %for.cond19, !dbg !71

for.cond19:                                       ; preds = %for.inc31, %for.body17
  %12 = load i32, i32* %j18, align 4, !dbg !72
  %cmp20 = icmp slt i32 %12, 3, !dbg !74
  br i1 %cmp20, label %for.body21, label %for.end33, !dbg !75

for.body21:                                       ; preds = %for.cond19
  %13 = load i32, i32* %i14, align 4, !dbg !76
  %idxprom22 = sext i32 %13 to i64, !dbg !78
  %arrayidx23 = getelementptr inbounds [3 x [3 x i32]], [3 x [3 x i32]]* %arr1, i64 0, i64 %idxprom22, !dbg !78
  %14 = load i32, i32* %j18, align 4, !dbg !79
  %idxprom24 = sext i32 %14 to i64, !dbg !78
  %arrayidx25 = getelementptr inbounds [3 x i32], [3 x i32]* %arrayidx23, i64 0, i64 %idxprom24, !dbg !78
  %15 = load i32, i32* %arrayidx25, align 4, !dbg !78
  %16 = load i32, i32* %i14, align 4, !dbg !80
  %idxprom26 = sext i32 %16 to i64, !dbg !81
  %arrayidx27 = getelementptr inbounds [3 x [3 x i32]], [3 x [3 x i32]]* %arr2, i64 0, i64 %idxprom26, !dbg !81
  %17 = load i32, i32* %j18, align 4, !dbg !82
  %idxprom28 = sext i32 %17 to i64, !dbg !81
  %arrayidx29 = getelementptr inbounds [3 x i32], [3 x i32]* %arrayidx27, i64 0, i64 %idxprom28, !dbg !81
  %18 = load i32, i32* %arrayidx29, align 4, !dbg !81
  %cmp30 = icmp ne i32 %15, %18, !dbg !83
  %conv = zext i1 %cmp30 to i32, !dbg !83
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !84
  br label %for.inc31, !dbg !85

for.inc31:                                        ; preds = %for.body21
  %19 = load i32, i32* %j18, align 4, !dbg !86
  %inc32 = add nsw i32 %19, 1, !dbg !86
  store i32 %inc32, i32* %j18, align 4, !dbg !86
  br label %for.cond19, !dbg !87, !llvm.loop !88

for.end33:                                        ; preds = %for.cond19
  br label %for.inc34, !dbg !90

for.inc34:                                        ; preds = %for.end33
  %20 = load i32, i32* %i14, align 4, !dbg !91
  %inc35 = add nsw i32 %20, 1, !dbg !91
  store i32 %inc35, i32* %i14, align 4, !dbg !91
  br label %for.cond15, !dbg !92, !llvm.loop !93

for.end36:                                        ; preds = %for.cond15
  ret i32 0, !dbg !95
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
!1 = !DIFile(filename: "2d_array3/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 7.0.1 (https://github.com/llvm-mirror/clang.git 4519e2637fcc4bf6e3049a0a80e6a5e7b97667cb) (https://github.com/llvm-mirror/llvm.git cd98f42d0747826062fc3d2d2fad383aedf58dd6)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 1, type: !8, isLocal: false, isDefinition: true, scopeLine: 2, isOptimized: false, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "arr1", scope: !7, file: !1, line: 3, type: !12)
!12 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 288, elements: !13)
!13 = !{!14, !14}
!14 = !DISubrange(count: 3)
!15 = !DILocation(line: 3, column: 6, scope: !7)
!16 = !DILocalVariable(name: "arr2", scope: !7, file: !1, line: 4, type: !12)
!17 = !DILocation(line: 4, column: 6, scope: !7)
!18 = !DILocalVariable(name: "x", scope: !7, file: !1, line: 6, type: !10)
!19 = !DILocation(line: 6, column: 6, scope: !7)
!20 = !DILocalVariable(name: "i", scope: !21, file: !1, line: 7, type: !10)
!21 = distinct !DILexicalBlock(scope: !7, file: !1, line: 7, column: 2)
!22 = !DILocation(line: 7, column: 10, scope: !21)
!23 = !DILocation(line: 7, column: 6, scope: !21)
!24 = !DILocation(line: 7, column: 16, scope: !25)
!25 = distinct !DILexicalBlock(scope: !21, file: !1, line: 7, column: 2)
!26 = !DILocation(line: 7, column: 17, scope: !25)
!27 = !DILocation(line: 7, column: 2, scope: !21)
!28 = !DILocalVariable(name: "j", scope: !29, file: !1, line: 9, type: !10)
!29 = distinct !DILexicalBlock(scope: !30, file: !1, line: 9, column: 3)
!30 = distinct !DILexicalBlock(scope: !25, file: !1, line: 8, column: 2)
!31 = !DILocation(line: 9, column: 11, scope: !29)
!32 = !DILocation(line: 9, column: 7, scope: !29)
!33 = !DILocation(line: 9, column: 17, scope: !34)
!34 = distinct !DILexicalBlock(scope: !29, file: !1, line: 9, column: 3)
!35 = !DILocation(line: 9, column: 18, scope: !34)
!36 = !DILocation(line: 9, column: 3, scope: !29)
!37 = !DILocation(line: 11, column: 15, scope: !38)
!38 = distinct !DILexicalBlock(scope: !34, file: !1, line: 10, column: 3)
!39 = !DILocation(line: 11, column: 9, scope: !38)
!40 = !DILocation(line: 11, column: 4, scope: !38)
!41 = !DILocation(line: 11, column: 12, scope: !38)
!42 = !DILocation(line: 11, column: 14, scope: !38)
!43 = !DILocation(line: 12, column: 15, scope: !38)
!44 = !DILocation(line: 12, column: 9, scope: !38)
!45 = !DILocation(line: 12, column: 4, scope: !38)
!46 = !DILocation(line: 12, column: 12, scope: !38)
!47 = !DILocation(line: 12, column: 14, scope: !38)
!48 = !DILocation(line: 13, column: 5, scope: !38)
!49 = !DILocation(line: 14, column: 3, scope: !38)
!50 = !DILocation(line: 9, column: 24, scope: !34)
!51 = !DILocation(line: 9, column: 3, scope: !34)
!52 = distinct !{!52, !36, !53}
!53 = !DILocation(line: 14, column: 3, scope: !29)
!54 = !DILocation(line: 15, column: 2, scope: !30)
!55 = !DILocation(line: 7, column: 23, scope: !25)
!56 = !DILocation(line: 7, column: 2, scope: !25)
!57 = distinct !{!57, !27, !58}
!58 = !DILocation(line: 15, column: 2, scope: !21)
!59 = !DILocalVariable(name: "i", scope: !60, file: !1, line: 16, type: !10)
!60 = distinct !DILexicalBlock(scope: !7, file: !1, line: 16, column: 2)
!61 = !DILocation(line: 16, column: 10, scope: !60)
!62 = !DILocation(line: 16, column: 6, scope: !60)
!63 = !DILocation(line: 16, column: 16, scope: !64)
!64 = distinct !DILexicalBlock(scope: !60, file: !1, line: 16, column: 2)
!65 = !DILocation(line: 16, column: 17, scope: !64)
!66 = !DILocation(line: 16, column: 2, scope: !60)
!67 = !DILocalVariable(name: "j", scope: !68, file: !1, line: 18, type: !10)
!68 = distinct !DILexicalBlock(scope: !69, file: !1, line: 18, column: 3)
!69 = distinct !DILexicalBlock(scope: !64, file: !1, line: 17, column: 2)
!70 = !DILocation(line: 18, column: 11, scope: !68)
!71 = !DILocation(line: 18, column: 7, scope: !68)
!72 = !DILocation(line: 18, column: 17, scope: !73)
!73 = distinct !DILexicalBlock(scope: !68, file: !1, line: 18, column: 3)
!74 = !DILocation(line: 18, column: 18, scope: !73)
!75 = !DILocation(line: 18, column: 3, scope: !68)
!76 = !DILocation(line: 20, column: 16, scope: !77)
!77 = distinct !DILexicalBlock(scope: !73, file: !1, line: 19, column: 3)
!78 = !DILocation(line: 20, column: 11, scope: !77)
!79 = !DILocation(line: 20, column: 19, scope: !77)
!80 = !DILocation(line: 20, column: 30, scope: !77)
!81 = !DILocation(line: 20, column: 25, scope: !77)
!82 = !DILocation(line: 20, column: 33, scope: !77)
!83 = !DILocation(line: 20, column: 22, scope: !77)
!84 = !DILocation(line: 20, column: 4, scope: !77)
!85 = !DILocation(line: 21, column: 3, scope: !77)
!86 = !DILocation(line: 18, column: 24, scope: !73)
!87 = !DILocation(line: 18, column: 3, scope: !73)
!88 = distinct !{!88, !75, !89}
!89 = !DILocation(line: 21, column: 3, scope: !68)
!90 = !DILocation(line: 22, column: 2, scope: !69)
!91 = !DILocation(line: 16, column: 23, scope: !64)
!92 = !DILocation(line: 16, column: 2, scope: !64)
!93 = distinct !{!93, !66, !94}
!94 = !DILocation(line: 22, column: 2, scope: !60)
!95 = !DILocation(line: 23, column: 5, scope: !7)

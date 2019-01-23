; ModuleID = '3d_array_fail/main.c'
source_filename = "3d_array_fail/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@main.array = private unnamed_addr constant [2 x [2 x [2 x i32]]] [[2 x [2 x i32]] [[2 x i32] [i32 2, i32 2], [2 x i32] [i32 2, i32 2]], [2 x [2 x i32]] [[2 x i32] [i32 2, i32 2], [2 x i32] [i32 3, i32 2]]], align 16

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
  %0 = bitcast [2 x [2 x [2 x i32]]]* %array to i8*, !dbg !15
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %0, i8* align 16 bitcast ([2 x [2 x [2 x i32]]]* @main.array to i8*), i64 32, i1 false), !dbg !15
  call void @llvm.dbg.declare(metadata i32* %product, metadata !16, metadata !DIExpression()), !dbg !17
  store i32 1, i32* %product, align 4, !dbg !17
  call void @llvm.dbg.declare(metadata i32* %i, metadata !18, metadata !DIExpression()), !dbg !20
  store i32 0, i32* %i, align 4, !dbg !20
  br label %for.cond, !dbg !21

for.cond:                                         ; preds = %for.inc, %entry
  %1 = load i32, i32* %i, align 4, !dbg !22
  %cmp = icmp slt i32 %1, 2, !dbg !24
  br i1 %cmp, label %for.body, label %for.end, !dbg !25

for.body:                                         ; preds = %for.cond
  call void @llvm.dbg.declare(metadata i32* %j, metadata !26, metadata !DIExpression()), !dbg !28
  store i32 0, i32* %j, align 4, !dbg !28
  br label %while.cond, !dbg !29

while.cond:                                       ; preds = %do.end, %for.body
  %2 = load i32, i32* %j, align 4, !dbg !30
  %cmp1 = icmp slt i32 %2, 2, !dbg !31
  br i1 %cmp1, label %while.body, label %while.end, !dbg !29

while.body:                                       ; preds = %while.cond
  call void @llvm.dbg.declare(metadata i32* %k, metadata !32, metadata !DIExpression()), !dbg !34
  store i32 0, i32* %k, align 4, !dbg !34
  br label %do.body, !dbg !35

do.body:                                          ; preds = %do.cond, %while.body
  %3 = load i32, i32* %i, align 4, !dbg !36
  %idxprom = sext i32 %3 to i64, !dbg !38
  %arrayidx = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 %idxprom, !dbg !38
  %4 = load i32, i32* %j, align 4, !dbg !39
  %idxprom2 = sext i32 %4 to i64, !dbg !38
  %arrayidx3 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx, i64 0, i64 %idxprom2, !dbg !38
  %5 = load i32, i32* %k, align 4, !dbg !40
  %idxprom4 = sext i32 %5 to i64, !dbg !38
  %arrayidx5 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx3, i64 0, i64 %idxprom4, !dbg !38
  %6 = load i32, i32* %arrayidx5, align 4, !dbg !38
  %7 = load i32, i32* %product, align 4, !dbg !41
  %mul = mul nsw i32 %6, %7, !dbg !42
  store i32 %mul, i32* %product, align 4, !dbg !43
  %8 = load i32, i32* %k, align 4, !dbg !44
  %inc = add nsw i32 %8, 1, !dbg !44
  store i32 %inc, i32* %k, align 4, !dbg !44
  br label %do.cond, !dbg !45

do.cond:                                          ; preds = %do.body
  %9 = load i32, i32* %k, align 4, !dbg !46
  %cmp6 = icmp slt i32 %9, 2, !dbg !47
  br i1 %cmp6, label %do.body, label %do.end, !dbg !45, !llvm.loop !48

do.end:                                           ; preds = %do.cond
  %10 = load i32, i32* %j, align 4, !dbg !50
  %inc7 = add nsw i32 %10, 1, !dbg !50
  store i32 %inc7, i32* %j, align 4, !dbg !50
  br label %while.cond, !dbg !29, !llvm.loop !51

while.end:                                        ; preds = %while.cond
  br label %for.inc, !dbg !53

for.inc:                                          ; preds = %while.end
  %11 = load i32, i32* %i, align 4, !dbg !54
  %inc8 = add nsw i32 %11, 1, !dbg !54
  store i32 %inc8, i32* %i, align 4, !dbg !54
  br label %for.cond, !dbg !55, !llvm.loop !56

for.end:                                          ; preds = %for.cond
  %12 = load i32, i32* %product, align 4, !dbg !58
  %arrayidx9 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 0, !dbg !59
  %arrayidx10 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx9, i64 0, i64 0, !dbg !59
  %arrayidx11 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx10, i64 0, i64 0, !dbg !59
  %13 = load i32, i32* %arrayidx11, align 16, !dbg !59
  %arrayidx12 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 0, !dbg !60
  %arrayidx13 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx12, i64 0, i64 1, !dbg !60
  %arrayidx14 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx13, i64 0, i64 0, !dbg !60
  %14 = load i32, i32* %arrayidx14, align 8, !dbg !60
  %mul15 = mul nsw i32 %13, %14, !dbg !61
  %arrayidx16 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 0, !dbg !62
  %arrayidx17 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx16, i64 0, i64 1, !dbg !62
  %arrayidx18 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx17, i64 0, i64 0, !dbg !62
  %15 = load i32, i32* %arrayidx18, align 8, !dbg !62
  %mul19 = mul nsw i32 %mul15, %15, !dbg !63
  %arrayidx20 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 0, !dbg !64
  %arrayidx21 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx20, i64 0, i64 1, !dbg !64
  %arrayidx22 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx21, i64 0, i64 0, !dbg !64
  %16 = load i32, i32* %arrayidx22, align 8, !dbg !64
  %mul23 = mul nsw i32 %mul19, %16, !dbg !65
  %arrayidx24 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 0, !dbg !66
  %arrayidx25 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx24, i64 0, i64 0, !dbg !66
  %arrayidx26 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx25, i64 0, i64 0, !dbg !66
  %17 = load i32, i32* %arrayidx26, align 16, !dbg !66
  %mul27 = mul nsw i32 %mul23, %17, !dbg !67
  %arrayidx28 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 0, !dbg !68
  %arrayidx29 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx28, i64 0, i64 0, !dbg !68
  %arrayidx30 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx29, i64 0, i64 0, !dbg !68
  %18 = load i32, i32* %arrayidx30, align 16, !dbg !68
  %mul31 = mul nsw i32 %mul27, %18, !dbg !69
  %arrayidx32 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 0, !dbg !70
  %arrayidx33 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx32, i64 0, i64 0, !dbg !70
  %arrayidx34 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx33, i64 0, i64 0, !dbg !70
  %19 = load i32, i32* %arrayidx34, align 16, !dbg !70
  %mul35 = mul nsw i32 %mul31, %19, !dbg !71
  %arrayidx36 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 0, !dbg !72
  %arrayidx37 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx36, i64 0, i64 0, !dbg !72
  %arrayidx38 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx37, i64 0, i64 0, !dbg !72
  %20 = load i32, i32* %arrayidx38, align 16, !dbg !72
  %mul39 = mul nsw i32 %mul35, %20, !dbg !73
  %cmp40 = icmp eq i32 %12, %mul39, !dbg !74
  %conv = zext i1 %cmp40 to i32, !dbg !74
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !75
  %21 = load i32, i32* %retval, align 4, !dbg !76
  ret i32 %21, !dbg !76
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1) #2

declare dso_local i32 @assert(...) #3

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { argmemonly nounwind }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 7.0.1 (https://github.com/llvm-mirror/clang.git 4519e2637fcc4bf6e3049a0a80e6a5e7b97667cb) (https://github.com/llvm-mirror/llvm.git cd98f42d0747826062fc3d2d2fad383aedf58dd6)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "3d_array_fail/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 7.0.1 (https://github.com/llvm-mirror/clang.git 4519e2637fcc4bf6e3049a0a80e6a5e7b97667cb) (https://github.com/llvm-mirror/llvm.git cd98f42d0747826062fc3d2d2fad383aedf58dd6)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 3, type: !8, isLocal: false, isDefinition: true, scopeLine: 4, isOptimized: false, unit: !0, retainedNodes: !2)
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
!36 = !DILocation(line: 18, column: 21, scope: !37)
!37 = distinct !DILexicalBlock(scope: !33, file: !1, line: 17, column: 4)
!38 = !DILocation(line: 18, column: 15, scope: !37)
!39 = !DILocation(line: 18, column: 24, scope: !37)
!40 = !DILocation(line: 18, column: 27, scope: !37)
!41 = !DILocation(line: 18, column: 32, scope: !37)
!42 = !DILocation(line: 18, column: 30, scope: !37)
!43 = !DILocation(line: 18, column: 13, scope: !37)
!44 = !DILocation(line: 19, column: 6, scope: !37)
!45 = !DILocation(line: 20, column: 4, scope: !37)
!46 = !DILocation(line: 20, column: 11, scope: !33)
!47 = !DILocation(line: 20, column: 12, scope: !33)
!48 = distinct !{!48, !35, !49}
!49 = !DILocation(line: 20, column: 14, scope: !33)
!50 = !DILocation(line: 22, column: 5, scope: !33)
!51 = distinct !{!51, !29, !52}
!52 = !DILocation(line: 23, column: 3, scope: !27)
!53 = !DILocation(line: 24, column: 2, scope: !27)
!54 = !DILocation(line: 9, column: 23, scope: !23)
!55 = !DILocation(line: 9, column: 2, scope: !23)
!56 = distinct !{!56, !25, !57}
!57 = !DILocation(line: 24, column: 2, scope: !19)
!58 = !DILocation(line: 27, column: 9, scope: !7)
!59 = !DILocation(line: 27, column: 20, scope: !7)
!60 = !DILocation(line: 27, column: 35, scope: !7)
!61 = !DILocation(line: 27, column: 34, scope: !7)
!62 = !DILocation(line: 27, column: 50, scope: !7)
!63 = !DILocation(line: 27, column: 49, scope: !7)
!64 = !DILocation(line: 27, column: 65, scope: !7)
!65 = !DILocation(line: 27, column: 64, scope: !7)
!66 = !DILocation(line: 27, column: 80, scope: !7)
!67 = !DILocation(line: 27, column: 79, scope: !7)
!68 = !DILocation(line: 27, column: 95, scope: !7)
!69 = !DILocation(line: 27, column: 94, scope: !7)
!70 = !DILocation(line: 27, column: 110, scope: !7)
!71 = !DILocation(line: 27, column: 109, scope: !7)
!72 = !DILocation(line: 27, column: 125, scope: !7)
!73 = !DILocation(line: 27, column: 124, scope: !7)
!74 = !DILocation(line: 27, column: 17, scope: !7)
!75 = !DILocation(line: 27, column: 2, scope: !7)
!76 = !DILocation(line: 29, column: 1, scope: !7)

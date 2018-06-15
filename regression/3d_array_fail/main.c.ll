; ModuleID = '3d_array_fail/main.c'
source_filename = "3d_array_fail/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@main.array = private unnamed_addr constant [2 x [2 x [2 x i32]]] [[2 x [2 x i32]] [[2 x i32] [i32 2, i32 2], [2 x i32] [i32 2, i32 2]], [2 x [2 x i32]] [[2 x i32] [i32 2, i32 2], [2 x i32] [i32 3, i32 2]]], align 16

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !6 {
entry:
  %retval = alloca i32, align 4
  %array = alloca [2 x [2 x [2 x i32]]], align 16
  %product = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata [2 x [2 x [2 x i32]]]* %array, metadata !10, metadata !14), !dbg !15
  %0 = bitcast [2 x [2 x [2 x i32]]]* %array to i8*, !dbg !15
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* bitcast ([2 x [2 x [2 x i32]]]* @main.array to i8*), i64 32, i32 16, i1 false), !dbg !15
  call void @llvm.dbg.declare(metadata i32* %product, metadata !16, metadata !14), !dbg !17
  store i32 1, i32* %product, align 4, !dbg !17
  call void @llvm.dbg.declare(metadata i32* %i, metadata !18, metadata !14), !dbg !20
  store i32 0, i32* %i, align 4, !dbg !20
  br label %for.cond, !dbg !21

for.cond:                                         ; preds = %for.inc, %entry
  %1 = load i32, i32* %i, align 4, !dbg !22
  %cmp = icmp slt i32 %1, 2, !dbg !25
  br i1 %cmp, label %for.body, label %for.end, !dbg !26

for.body:                                         ; preds = %for.cond
  call void @llvm.dbg.declare(metadata i32* %j, metadata !28, metadata !14), !dbg !30
  store i32 0, i32* %j, align 4, !dbg !30
  br label %while.cond, !dbg !31

while.cond:                                       ; preds = %do.end, %for.body
  %2 = load i32, i32* %j, align 4, !dbg !32
  %cmp1 = icmp slt i32 %2, 2, !dbg !34
  br i1 %cmp1, label %while.body, label %while.end, !dbg !35

while.body:                                       ; preds = %while.cond
  call void @llvm.dbg.declare(metadata i32* %k, metadata !36, metadata !14), !dbg !38
  store i32 0, i32* %k, align 4, !dbg !38
  br label %do.body, !dbg !39, !llvm.loop !40

do.body:                                          ; preds = %do.cond, %while.body
  %3 = load i32, i32* %i, align 4, !dbg !42
  %idxprom = sext i32 %3 to i64, !dbg !44
  %arrayidx = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 %idxprom, !dbg !44
  %4 = load i32, i32* %j, align 4, !dbg !45
  %idxprom2 = sext i32 %4 to i64, !dbg !44
  %arrayidx3 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx, i64 0, i64 %idxprom2, !dbg !44
  %5 = load i32, i32* %k, align 4, !dbg !46
  %idxprom4 = sext i32 %5 to i64, !dbg !44
  %arrayidx5 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx3, i64 0, i64 %idxprom4, !dbg !44
  %6 = load i32, i32* %arrayidx5, align 4, !dbg !44
  %7 = load i32, i32* %product, align 4, !dbg !47
  %mul = mul nsw i32 %6, %7, !dbg !48
  store i32 %mul, i32* %product, align 4, !dbg !49
  %8 = load i32, i32* %k, align 4, !dbg !50
  %inc = add nsw i32 %8, 1, !dbg !50
  store i32 %inc, i32* %k, align 4, !dbg !50
  br label %do.cond, !dbg !51

do.cond:                                          ; preds = %do.body
  %9 = load i32, i32* %k, align 4, !dbg !52
  %cmp6 = icmp slt i32 %9, 2, !dbg !54
  br i1 %cmp6, label %do.body, label %do.end, !dbg !55, !llvm.loop !40

do.end:                                           ; preds = %do.cond
  %10 = load i32, i32* %j, align 4, !dbg !57
  %inc7 = add nsw i32 %10, 1, !dbg !57
  store i32 %inc7, i32* %j, align 4, !dbg !57
  br label %while.cond, !dbg !58, !llvm.loop !60

while.end:                                        ; preds = %while.cond
  br label %for.inc, !dbg !62

for.inc:                                          ; preds = %while.end
  %11 = load i32, i32* %i, align 4, !dbg !63
  %inc8 = add nsw i32 %11, 1, !dbg !63
  store i32 %inc8, i32* %i, align 4, !dbg !63
  br label %for.cond, !dbg !65, !llvm.loop !66

for.end:                                          ; preds = %for.cond
  %12 = load i32, i32* %product, align 4, !dbg !69
  %arrayidx9 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 0, !dbg !70
  %arrayidx10 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx9, i64 0, i64 0, !dbg !70
  %arrayidx11 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx10, i64 0, i64 0, !dbg !70
  %13 = load i32, i32* %arrayidx11, align 16, !dbg !70
  %arrayidx12 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 0, !dbg !71
  %arrayidx13 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx12, i64 0, i64 1, !dbg !71
  %arrayidx14 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx13, i64 0, i64 0, !dbg !71
  %14 = load i32, i32* %arrayidx14, align 8, !dbg !71
  %mul15 = mul nsw i32 %13, %14, !dbg !72
  %arrayidx16 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 0, !dbg !73
  %arrayidx17 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx16, i64 0, i64 1, !dbg !73
  %arrayidx18 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx17, i64 0, i64 0, !dbg !73
  %15 = load i32, i32* %arrayidx18, align 8, !dbg !73
  %mul19 = mul nsw i32 %mul15, %15, !dbg !74
  %arrayidx20 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 0, !dbg !75
  %arrayidx21 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx20, i64 0, i64 1, !dbg !75
  %arrayidx22 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx21, i64 0, i64 0, !dbg !75
  %16 = load i32, i32* %arrayidx22, align 8, !dbg !75
  %mul23 = mul nsw i32 %mul19, %16, !dbg !76
  %arrayidx24 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 0, !dbg !77
  %arrayidx25 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx24, i64 0, i64 0, !dbg !77
  %arrayidx26 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx25, i64 0, i64 0, !dbg !77
  %17 = load i32, i32* %arrayidx26, align 16, !dbg !77
  %mul27 = mul nsw i32 %mul23, %17, !dbg !78
  %arrayidx28 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 0, !dbg !79
  %arrayidx29 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx28, i64 0, i64 0, !dbg !79
  %arrayidx30 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx29, i64 0, i64 0, !dbg !79
  %18 = load i32, i32* %arrayidx30, align 16, !dbg !79
  %mul31 = mul nsw i32 %mul27, %18, !dbg !80
  %arrayidx32 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 0, !dbg !81
  %arrayidx33 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx32, i64 0, i64 0, !dbg !81
  %arrayidx34 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx33, i64 0, i64 0, !dbg !81
  %19 = load i32, i32* %arrayidx34, align 16, !dbg !81
  %mul35 = mul nsw i32 %mul31, %19, !dbg !82
  %arrayidx36 = getelementptr inbounds [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %array, i64 0, i64 0, !dbg !83
  %arrayidx37 = getelementptr inbounds [2 x [2 x i32]], [2 x [2 x i32]]* %arrayidx36, i64 0, i64 0, !dbg !83
  %arrayidx38 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayidx37, i64 0, i64 0, !dbg !83
  %20 = load i32, i32* %arrayidx38, align 16, !dbg !83
  %mul39 = mul nsw i32 %mul35, %20, !dbg !84
  %cmp40 = icmp eq i32 %12, %mul39, !dbg !85
  %conv = zext i1 %cmp40 to i32, !dbg !85
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !86
  %21 = load i32, i32* %retval, align 4, !dbg !87
  ret i32 %21, !dbg !87
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #2

declare i32 @assert(...) #3

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { argmemonly nounwind }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4}
!llvm.ident = !{!5}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (trunk 295264)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "3d_array_fail/main.c", directory: "/home/rasika/llvm2goto/llvm2goto-regression-master")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{!"clang version 5.0.0 (trunk 295264)"}
!6 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 3, type: !7, isLocal: false, isDefinition: true, scopeLine: 4, isOptimized: false, unit: !0, variables: !2)
!7 = !DISubroutineType(types: !8)
!8 = !{!9}
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DILocalVariable(name: "array", scope: !6, file: !1, line: 5, type: !11)
!11 = !DICompositeType(tag: DW_TAG_array_type, baseType: !9, size: 256, elements: !12)
!12 = !{!13, !13, !13}
!13 = !DISubrange(count: 2)
!14 = !DIExpression()
!15 = !DILocation(line: 5, column: 6, scope: !6)
!16 = !DILocalVariable(name: "product", scope: !6, file: !1, line: 7, type: !9)
!17 = !DILocation(line: 7, column: 6, scope: !6)
!18 = !DILocalVariable(name: "i", scope: !19, file: !1, line: 9, type: !9)
!19 = distinct !DILexicalBlock(scope: !6, file: !1, line: 9, column: 2)
!20 = !DILocation(line: 9, column: 10, scope: !19)
!21 = !DILocation(line: 9, column: 6, scope: !19)
!22 = !DILocation(line: 9, column: 16, scope: !23)
!23 = !DILexicalBlockFile(scope: !24, file: !1, discriminator: 2)
!24 = distinct !DILexicalBlock(scope: !19, file: !1, line: 9, column: 2)
!25 = !DILocation(line: 9, column: 17, scope: !23)
!26 = !DILocation(line: 9, column: 2, scope: !27)
!27 = !DILexicalBlockFile(scope: !19, file: !1, discriminator: 2)
!28 = !DILocalVariable(name: "j", scope: !29, file: !1, line: 11, type: !9)
!29 = distinct !DILexicalBlock(scope: !24, file: !1, line: 10, column: 2)
!30 = !DILocation(line: 11, column: 7, scope: !29)
!31 = !DILocation(line: 12, column: 3, scope: !29)
!32 = !DILocation(line: 12, column: 9, scope: !33)
!33 = !DILexicalBlockFile(scope: !29, file: !1, discriminator: 2)
!34 = !DILocation(line: 12, column: 10, scope: !33)
!35 = !DILocation(line: 12, column: 3, scope: !33)
!36 = !DILocalVariable(name: "k", scope: !37, file: !1, line: 14, type: !9)
!37 = distinct !DILexicalBlock(scope: !29, file: !1, line: 13, column: 3)
!38 = !DILocation(line: 14, column: 8, scope: !37)
!39 = !DILocation(line: 16, column: 4, scope: !37)
!40 = distinct !{!40, !39, !41}
!41 = !DILocation(line: 20, column: 14, scope: !37)
!42 = !DILocation(line: 18, column: 21, scope: !43)
!43 = distinct !DILexicalBlock(scope: !37, file: !1, line: 17, column: 4)
!44 = !DILocation(line: 18, column: 15, scope: !43)
!45 = !DILocation(line: 18, column: 24, scope: !43)
!46 = !DILocation(line: 18, column: 27, scope: !43)
!47 = !DILocation(line: 18, column: 32, scope: !43)
!48 = !DILocation(line: 18, column: 30, scope: !43)
!49 = !DILocation(line: 18, column: 13, scope: !43)
!50 = !DILocation(line: 19, column: 6, scope: !43)
!51 = !DILocation(line: 20, column: 4, scope: !43)
!52 = !DILocation(line: 20, column: 11, scope: !53)
!53 = !DILexicalBlockFile(scope: !37, file: !1, discriminator: 2)
!54 = !DILocation(line: 20, column: 12, scope: !53)
!55 = !DILocation(line: 20, column: 4, scope: !56)
!56 = !DILexicalBlockFile(scope: !43, file: !1, discriminator: 2)
!57 = !DILocation(line: 22, column: 5, scope: !37)
!58 = !DILocation(line: 12, column: 3, scope: !59)
!59 = !DILexicalBlockFile(scope: !29, file: !1, discriminator: 4)
!60 = distinct !{!60, !31, !61}
!61 = !DILocation(line: 23, column: 3, scope: !29)
!62 = !DILocation(line: 24, column: 2, scope: !29)
!63 = !DILocation(line: 9, column: 23, scope: !64)
!64 = !DILexicalBlockFile(scope: !24, file: !1, discriminator: 4)
!65 = !DILocation(line: 9, column: 2, scope: !64)
!66 = distinct !{!66, !67, !68}
!67 = !DILocation(line: 9, column: 2, scope: !19)
!68 = !DILocation(line: 24, column: 2, scope: !19)
!69 = !DILocation(line: 27, column: 9, scope: !6)
!70 = !DILocation(line: 27, column: 20, scope: !6)
!71 = !DILocation(line: 27, column: 35, scope: !6)
!72 = !DILocation(line: 27, column: 34, scope: !6)
!73 = !DILocation(line: 27, column: 50, scope: !6)
!74 = !DILocation(line: 27, column: 49, scope: !6)
!75 = !DILocation(line: 27, column: 65, scope: !6)
!76 = !DILocation(line: 27, column: 64, scope: !6)
!77 = !DILocation(line: 27, column: 80, scope: !6)
!78 = !DILocation(line: 27, column: 79, scope: !6)
!79 = !DILocation(line: 27, column: 95, scope: !6)
!80 = !DILocation(line: 27, column: 94, scope: !6)
!81 = !DILocation(line: 27, column: 110, scope: !6)
!82 = !DILocation(line: 27, column: 109, scope: !6)
!83 = !DILocation(line: 27, column: 125, scope: !6)
!84 = !DILocation(line: 27, column: 124, scope: !6)
!85 = !DILocation(line: 27, column: 17, scope: !6)
!86 = !DILocation(line: 27, column: 2, scope: !6)
!87 = !DILocation(line: 29, column: 1, scope: !6)

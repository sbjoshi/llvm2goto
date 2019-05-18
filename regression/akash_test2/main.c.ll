; ModuleID = 'akash_test2/main.c'
source_filename = "akash_test2/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @fill_array(i32* %a, i32 %length) #0 !dbg !7 {
entry:
  %a.addr = alloca i32*, align 8
  %length.addr = alloca i32, align 4
  %i = alloca i32, align 4
  store i32* %a, i32** %a.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %a.addr, metadata !12, metadata !DIExpression()), !dbg !13
  store i32 %length, i32* %length.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %length.addr, metadata !14, metadata !DIExpression()), !dbg !15
  call void @llvm.dbg.declare(metadata i32* %i, metadata !16, metadata !DIExpression()), !dbg !18
  store i32 0, i32* %i, align 4, !dbg !18
  br label %for.cond, !dbg !19

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4, !dbg !20
  %1 = load i32, i32* %length.addr, align 4, !dbg !22
  %cmp = icmp slt i32 %0, %1, !dbg !23
  br i1 %cmp, label %for.body, label %for.end, !dbg !24

for.body:                                         ; preds = %for.cond
  %2 = load i32, i32* %i, align 4, !dbg !25
  %3 = load i32*, i32** %a.addr, align 8, !dbg !27
  %4 = load i32, i32* %i, align 4, !dbg !28
  %idxprom = sext i32 %4 to i64, !dbg !27
  %arrayidx = getelementptr inbounds i32, i32* %3, i64 %idxprom, !dbg !27
  store i32 %2, i32* %arrayidx, align 4, !dbg !29
  br label %for.inc, !dbg !30

for.inc:                                          ; preds = %for.body
  %5 = load i32, i32* %i, align 4, !dbg !31
  %inc = add nsw i32 %5, 1, !dbg !31
  store i32 %inc, i32* %i, align 4, !dbg !31
  br label %for.cond, !dbg !32, !llvm.loop !33

for.end:                                          ; preds = %for.cond
  ret void, !dbg !35
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !36 {
entry:
  %retval = alloca i32, align 4
  %a = alloca [10 x i32], align 16
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata [10 x i32]* %a, metadata !39, metadata !DIExpression()), !dbg !43
  %arraydecay = getelementptr inbounds [10 x i32], [10 x i32]* %a, i32 0, i32 0, !dbg !44
  call void @fill_array(i32* %arraydecay, i32 10), !dbg !45
  call void @llvm.dbg.declare(metadata i32* %x, metadata !46, metadata !DIExpression()), !dbg !47
  call void @llvm.dbg.declare(metadata i32* %y, metadata !48, metadata !DIExpression()), !dbg !49
  %0 = load i32, i32* %x, align 4, !dbg !50
  %cmp = icmp sle i32 0, %0, !dbg !51
  %conv = zext i1 %cmp to i32, !dbg !51
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assume to i32 (i32, ...)*)(i32 %conv), !dbg !52
  %1 = load i32, i32* %x, align 4, !dbg !53
  %cmp1 = icmp slt i32 %1, 10, !dbg !54
  %conv2 = zext i1 %cmp1 to i32, !dbg !54
  %call3 = call i32 (i32, ...) bitcast (i32 (...)* @assume to i32 (i32, ...)*)(i32 %conv2), !dbg !55
  %2 = load i32, i32* %y, align 4, !dbg !56
  %cmp4 = icmp sle i32 0, %2, !dbg !57
  %conv5 = zext i1 %cmp4 to i32, !dbg !57
  %call6 = call i32 (i32, ...) bitcast (i32 (...)* @assume to i32 (i32, ...)*)(i32 %conv5), !dbg !58
  %3 = load i32, i32* %y, align 4, !dbg !59
  %cmp7 = icmp slt i32 %3, 10, !dbg !60
  %conv8 = zext i1 %cmp7 to i32, !dbg !60
  %call9 = call i32 (i32, ...) bitcast (i32 (...)* @assume to i32 (i32, ...)*)(i32 %conv8), !dbg !61
  %4 = load i32, i32* %x, align 4, !dbg !62
  %5 = load i32, i32* %y, align 4, !dbg !63
  %add = add nsw i32 %4, %5, !dbg !64
  %cmp10 = icmp slt i32 %add, 10, !dbg !65
  %conv11 = zext i1 %cmp10 to i32, !dbg !65
  %call12 = call i32 (i32, ...) bitcast (i32 (...)* @assume to i32 (i32, ...)*)(i32 %conv11), !dbg !66
  %6 = load i32, i32* %x, align 4, !dbg !67
  %idxprom = sext i32 %6 to i64, !dbg !68
  %arrayidx = getelementptr inbounds [10 x i32], [10 x i32]* %a, i64 0, i64 %idxprom, !dbg !68
  %7 = load i32, i32* %arrayidx, align 4, !dbg !68
  %8 = load i32, i32* %y, align 4, !dbg !69
  %idxprom13 = sext i32 %8 to i64, !dbg !70
  %arrayidx14 = getelementptr inbounds [10 x i32], [10 x i32]* %a, i64 0, i64 %idxprom13, !dbg !70
  %9 = load i32, i32* %arrayidx14, align 4, !dbg !70
  %add15 = add nsw i32 %7, %9, !dbg !71
  %10 = load i32, i32* %x, align 4, !dbg !72
  %11 = load i32, i32* %y, align 4, !dbg !73
  %add16 = add nsw i32 %10, %11, !dbg !74
  %cmp17 = icmp eq i32 %add15, %add16, !dbg !75
  %conv18 = zext i1 %cmp17 to i32, !dbg !75
  %call19 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv18), !dbg !76
  ret i32 1, !dbg !77
}

declare dso_local i32 @assume(...) #2

declare dso_local i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 8.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "akash_test2/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 8.0.0 "}
!7 = distinct !DISubprogram(name: "fill_array", scope: !1, file: !1, line: 3, type: !8, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10, !11}
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!12 = !DILocalVariable(name: "a", arg: 1, scope: !7, file: !1, line: 3, type: !10)
!13 = !DILocation(line: 3, column: 23, scope: !7)
!14 = !DILocalVariable(name: "length", arg: 2, scope: !7, file: !1, line: 3, type: !11)
!15 = !DILocation(line: 3, column: 30, scope: !7)
!16 = !DILocalVariable(name: "i", scope: !17, file: !1, line: 5, type: !11)
!17 = distinct !DILexicalBlock(scope: !7, file: !1, line: 5, column: 3)
!18 = !DILocation(line: 5, column: 12, scope: !17)
!19 = !DILocation(line: 5, column: 8, scope: !17)
!20 = !DILocation(line: 5, column: 19, scope: !21)
!21 = distinct !DILexicalBlock(scope: !17, file: !1, line: 5, column: 3)
!22 = !DILocation(line: 5, column: 23, scope: !21)
!23 = !DILocation(line: 5, column: 21, scope: !21)
!24 = !DILocation(line: 5, column: 3, scope: !17)
!25 = !DILocation(line: 6, column: 12, scope: !26)
!26 = distinct !DILexicalBlock(scope: !21, file: !1, line: 5, column: 36)
!27 = !DILocation(line: 6, column: 5, scope: !26)
!28 = !DILocation(line: 6, column: 7, scope: !26)
!29 = !DILocation(line: 6, column: 10, scope: !26)
!30 = !DILocation(line: 7, column: 3, scope: !26)
!31 = !DILocation(line: 5, column: 31, scope: !21)
!32 = !DILocation(line: 5, column: 3, scope: !21)
!33 = distinct !{!33, !24, !34}
!34 = !DILocation(line: 7, column: 3, scope: !17)
!35 = !DILocation(line: 8, column: 1, scope: !7)
!36 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 10, type: !37, scopeLine: 11, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!37 = !DISubroutineType(types: !38)
!38 = !{!11}
!39 = !DILocalVariable(name: "a", scope: !36, file: !1, line: 12, type: !40)
!40 = !DICompositeType(tag: DW_TAG_array_type, baseType: !11, size: 320, elements: !41)
!41 = !{!42}
!42 = !DISubrange(count: 10)
!43 = !DILocation(line: 12, column: 7, scope: !36)
!44 = !DILocation(line: 14, column: 14, scope: !36)
!45 = !DILocation(line: 14, column: 3, scope: !36)
!46 = !DILocalVariable(name: "x", scope: !36, file: !1, line: 16, type: !11)
!47 = !DILocation(line: 16, column: 7, scope: !36)
!48 = !DILocalVariable(name: "y", scope: !36, file: !1, line: 17, type: !11)
!49 = !DILocation(line: 17, column: 7, scope: !36)
!50 = !DILocation(line: 19, column: 15, scope: !36)
!51 = !DILocation(line: 19, column: 12, scope: !36)
!52 = !DILocation(line: 19, column: 3, scope: !36)
!53 = !DILocation(line: 20, column: 10, scope: !36)
!54 = !DILocation(line: 20, column: 12, scope: !36)
!55 = !DILocation(line: 20, column: 3, scope: !36)
!56 = !DILocation(line: 21, column: 15, scope: !36)
!57 = !DILocation(line: 21, column: 12, scope: !36)
!58 = !DILocation(line: 21, column: 3, scope: !36)
!59 = !DILocation(line: 22, column: 10, scope: !36)
!60 = !DILocation(line: 22, column: 12, scope: !36)
!61 = !DILocation(line: 22, column: 3, scope: !36)
!62 = !DILocation(line: 23, column: 11, scope: !36)
!63 = !DILocation(line: 23, column: 15, scope: !36)
!64 = !DILocation(line: 23, column: 13, scope: !36)
!65 = !DILocation(line: 23, column: 18, scope: !36)
!66 = !DILocation(line: 23, column: 3, scope: !36)
!67 = !DILocation(line: 25, column: 12, scope: !36)
!68 = !DILocation(line: 25, column: 10, scope: !36)
!69 = !DILocation(line: 25, column: 19, scope: !36)
!70 = !DILocation(line: 25, column: 17, scope: !36)
!71 = !DILocation(line: 25, column: 15, scope: !36)
!72 = !DILocation(line: 25, column: 25, scope: !36)
!73 = !DILocation(line: 25, column: 29, scope: !36)
!74 = !DILocation(line: 25, column: 27, scope: !36)
!75 = !DILocation(line: 25, column: 22, scope: !36)
!76 = !DILocation(line: 25, column: 3, scope: !36)
!77 = !DILocation(line: 27, column: 3, scope: !36)

; ModuleID = 'bitwise_2/main.c'
source_filename = "bitwise_2/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define i32 @fun(i32* %arr, i32 %n) #0 !dbg !6 {
entry:
  %arr.addr = alloca i32*, align 8
  %n.addr = alloca i32, align 4
  %x = alloca i32, align 4
  %i = alloca i32, align 4
  store i32* %arr, i32** %arr.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %arr.addr, metadata !11, metadata !12), !dbg !13
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !14, metadata !12), !dbg !15
  call void @llvm.dbg.declare(metadata i32* %x, metadata !16, metadata !12), !dbg !17
  %0 = load i32*, i32** %arr.addr, align 8, !dbg !18
  %arrayidx = getelementptr inbounds i32, i32* %0, i64 0, !dbg !18
  %1 = load i32, i32* %arrayidx, align 4, !dbg !18
  store i32 %1, i32* %x, align 4, !dbg !17
  call void @llvm.dbg.declare(metadata i32* %i, metadata !19, metadata !12), !dbg !21
  store i32 1, i32* %i, align 4, !dbg !21
  br label %for.cond, !dbg !22

for.cond:                                         ; preds = %for.inc, %entry
  %2 = load i32, i32* %i, align 4, !dbg !23
  %3 = load i32, i32* %n.addr, align 4, !dbg !26
  %cmp = icmp slt i32 %2, %3, !dbg !27
  br i1 %cmp, label %for.body, label %for.end, !dbg !28

for.body:                                         ; preds = %for.cond
  %4 = load i32, i32* %x, align 4, !dbg !30
  %5 = load i32*, i32** %arr.addr, align 8, !dbg !31
  %6 = load i32, i32* %i, align 4, !dbg !32
  %idxprom = sext i32 %6 to i64, !dbg !31
  %arrayidx1 = getelementptr inbounds i32, i32* %5, i64 %idxprom, !dbg !31
  %7 = load i32, i32* %arrayidx1, align 4, !dbg !31
  %xor = xor i32 %4, %7, !dbg !33
  store i32 %xor, i32* %x, align 4, !dbg !34
  br label %for.inc, !dbg !35

for.inc:                                          ; preds = %for.body
  %8 = load i32, i32* %i, align 4, !dbg !36
  %inc = add nsw i32 %8, 1, !dbg !36
  store i32 %inc, i32* %i, align 4, !dbg !36
  br label %for.cond, !dbg !38, !llvm.loop !39

for.end:                                          ; preds = %for.cond
  %9 = load i32, i32* %x, align 4, !dbg !42
  ret i32 %9, !dbg !43
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !44 {
entry:
  %retval = alloca i32, align 4
  %arr = alloca [13 x i32], align 16
  %x = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata [13 x i32]* %arr, metadata !47, metadata !12), !dbg !51
  %arrayidx = getelementptr inbounds [13 x i32], [13 x i32]* %arr, i64 0, i64 0, !dbg !52
  store i32 9, i32* %arrayidx, align 16, !dbg !53
  %arrayidx1 = getelementptr inbounds [13 x i32], [13 x i32]* %arr, i64 0, i64 1, !dbg !54
  store i32 12, i32* %arrayidx1, align 4, !dbg !55
  %arrayidx2 = getelementptr inbounds [13 x i32], [13 x i32]* %arr, i64 0, i64 2, !dbg !56
  store i32 2, i32* %arrayidx2, align 8, !dbg !57
  %arrayidx3 = getelementptr inbounds [13 x i32], [13 x i32]* %arr, i64 0, i64 3, !dbg !58
  store i32 11, i32* %arrayidx3, align 4, !dbg !59
  %arrayidx4 = getelementptr inbounds [13 x i32], [13 x i32]* %arr, i64 0, i64 4, !dbg !60
  store i32 2, i32* %arrayidx4, align 16, !dbg !61
  %arrayidx5 = getelementptr inbounds [13 x i32], [13 x i32]* %arr, i64 0, i64 5, !dbg !62
  store i32 2, i32* %arrayidx5, align 4, !dbg !63
  %arrayidx6 = getelementptr inbounds [13 x i32], [13 x i32]* %arr, i64 0, i64 6, !dbg !64
  store i32 10, i32* %arrayidx6, align 8, !dbg !65
  %arrayidx7 = getelementptr inbounds [13 x i32], [13 x i32]* %arr, i64 0, i64 7, !dbg !66
  store i32 9, i32* %arrayidx7, align 4, !dbg !67
  %arrayidx8 = getelementptr inbounds [13 x i32], [13 x i32]* %arr, i64 0, i64 8, !dbg !68
  store i32 12, i32* %arrayidx8, align 16, !dbg !69
  %arrayidx9 = getelementptr inbounds [13 x i32], [13 x i32]* %arr, i64 0, i64 9, !dbg !70
  store i32 10, i32* %arrayidx9, align 4, !dbg !71
  %arrayidx10 = getelementptr inbounds [13 x i32], [13 x i32]* %arr, i64 0, i64 10, !dbg !72
  store i32 9, i32* %arrayidx10, align 8, !dbg !73
  %arrayidx11 = getelementptr inbounds [13 x i32], [13 x i32]* %arr, i64 0, i64 11, !dbg !74
  store i32 11, i32* %arrayidx11, align 4, !dbg !75
  %arrayidx12 = getelementptr inbounds [13 x i32], [13 x i32]* %arr, i64 0, i64 12, !dbg !76
  store i32 2, i32* %arrayidx12, align 16, !dbg !77
  call void @llvm.dbg.declare(metadata i32* %x, metadata !78, metadata !12), !dbg !79
  %arraydecay = getelementptr inbounds [13 x i32], [13 x i32]* %arr, i32 0, i32 0, !dbg !80
  %call = call i32 @fun(i32* %arraydecay, i32 10), !dbg !81
  store i32 %call, i32* %x, align 4, !dbg !79
  %0 = load i32, i32* %x, align 4, !dbg !82
  %cmp = icmp eq i32 %0, 9, !dbg !83
  %conv = zext i1 %cmp to i32, !dbg !83
  %call13 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !84
  ret i32 0, !dbg !85
}

declare i32 @assert(...) #2

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4}
!llvm.ident = !{!5}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (trunk 295264)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "bitwise_2/main.c", directory: "/home/rasika/llvm2goto/llvm2goto-regression-master")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{!"clang version 5.0.0 (trunk 295264)"}
!6 = distinct !DISubprogram(name: "fun", scope: !1, file: !1, line: 1, type: !7, isLocal: false, isDefinition: true, scopeLine: 2, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!7 = !DISubroutineType(types: !8)
!8 = !{!9, !10, !9}
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!11 = !DILocalVariable(name: "arr", arg: 1, scope: !6, file: !1, line: 1, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 1, column: 13, scope: !6)
!14 = !DILocalVariable(name: "n", arg: 2, scope: !6, file: !1, line: 1, type: !9)
!15 = !DILocation(line: 1, column: 24, scope: !6)
!16 = !DILocalVariable(name: "x", scope: !6, file: !1, line: 3, type: !9)
!17 = !DILocation(line: 3, column: 9, scope: !6)
!18 = !DILocation(line: 3, column: 13, scope: !6)
!19 = !DILocalVariable(name: "i", scope: !20, file: !1, line: 4, type: !9)
!20 = distinct !DILexicalBlock(scope: !6, file: !1, line: 4, column: 5)
!21 = !DILocation(line: 4, column: 14, scope: !20)
!22 = !DILocation(line: 4, column: 10, scope: !20)
!23 = !DILocation(line: 4, column: 21, scope: !24)
!24 = !DILexicalBlockFile(scope: !25, file: !1, discriminator: 2)
!25 = distinct !DILexicalBlock(scope: !20, file: !1, line: 4, column: 5)
!26 = !DILocation(line: 4, column: 25, scope: !24)
!27 = !DILocation(line: 4, column: 23, scope: !24)
!28 = !DILocation(line: 4, column: 5, scope: !29)
!29 = !DILexicalBlockFile(scope: !20, file: !1, discriminator: 2)
!30 = !DILocation(line: 5, column: 13, scope: !25)
!31 = !DILocation(line: 5, column: 17, scope: !25)
!32 = !DILocation(line: 5, column: 21, scope: !25)
!33 = !DILocation(line: 5, column: 15, scope: !25)
!34 = !DILocation(line: 5, column: 11, scope: !25)
!35 = !DILocation(line: 5, column: 9, scope: !25)
!36 = !DILocation(line: 4, column: 29, scope: !37)
!37 = !DILexicalBlockFile(scope: !25, file: !1, discriminator: 4)
!38 = !DILocation(line: 4, column: 5, scope: !37)
!39 = distinct !{!39, !40, !41}
!40 = !DILocation(line: 4, column: 5, scope: !20)
!41 = !DILocation(line: 5, column: 22, scope: !20)
!42 = !DILocation(line: 6, column: 12, scope: !6)
!43 = !DILocation(line: 6, column: 5, scope: !6)
!44 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 8, type: !45, isLocal: false, isDefinition: true, scopeLine: 9, isOptimized: false, unit: !0, variables: !2)
!45 = !DISubroutineType(types: !46)
!46 = !{!9}
!47 = !DILocalVariable(name: "arr", scope: !44, file: !1, line: 10, type: !48)
!48 = !DICompositeType(tag: DW_TAG_array_type, baseType: !9, size: 416, elements: !49)
!49 = !{!50}
!50 = !DISubrange(count: 13)
!51 = !DILocation(line: 10, column: 6, scope: !44)
!52 = !DILocation(line: 12, column: 2, scope: !44)
!53 = !DILocation(line: 12, column: 9, scope: !44)
!54 = !DILocation(line: 13, column: 2, scope: !44)
!55 = !DILocation(line: 13, column: 9, scope: !44)
!56 = !DILocation(line: 14, column: 2, scope: !44)
!57 = !DILocation(line: 14, column: 9, scope: !44)
!58 = !DILocation(line: 15, column: 2, scope: !44)
!59 = !DILocation(line: 15, column: 9, scope: !44)
!60 = !DILocation(line: 16, column: 2, scope: !44)
!61 = !DILocation(line: 16, column: 9, scope: !44)
!62 = !DILocation(line: 17, column: 2, scope: !44)
!63 = !DILocation(line: 17, column: 9, scope: !44)
!64 = !DILocation(line: 18, column: 2, scope: !44)
!65 = !DILocation(line: 18, column: 9, scope: !44)
!66 = !DILocation(line: 19, column: 2, scope: !44)
!67 = !DILocation(line: 19, column: 9, scope: !44)
!68 = !DILocation(line: 20, column: 2, scope: !44)
!69 = !DILocation(line: 20, column: 9, scope: !44)
!70 = !DILocation(line: 21, column: 2, scope: !44)
!71 = !DILocation(line: 21, column: 9, scope: !44)
!72 = !DILocation(line: 22, column: 2, scope: !44)
!73 = !DILocation(line: 22, column: 10, scope: !44)
!74 = !DILocation(line: 23, column: 2, scope: !44)
!75 = !DILocation(line: 23, column: 10, scope: !44)
!76 = !DILocation(line: 24, column: 2, scope: !44)
!77 = !DILocation(line: 24, column: 10, scope: !44)
!78 = !DILocalVariable(name: "x", scope: !44, file: !1, line: 25, type: !9)
!79 = !DILocation(line: 25, column: 6, scope: !44)
!80 = !DILocation(line: 25, column: 14, scope: !44)
!81 = !DILocation(line: 25, column: 10, scope: !44)
!82 = !DILocation(line: 27, column: 9, scope: !44)
!83 = !DILocation(line: 27, column: 10, scope: !44)
!84 = !DILocation(line: 27, column: 2, scope: !44)
!85 = !DILocation(line: 29, column: 2, scope: !44)

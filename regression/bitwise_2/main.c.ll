; ModuleID = 'bitwise_2/main.c'
source_filename = "bitwise_2/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @fun(i32* %arr, i32 %n) #0 !dbg !7 {
entry:
  %arr.addr = alloca i32*, align 8
  %n.addr = alloca i32, align 4
  %x = alloca i32, align 4
  %i = alloca i32, align 4
  store i32* %arr, i32** %arr.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %arr.addr, metadata !12, metadata !DIExpression()), !dbg !13
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !14, metadata !DIExpression()), !dbg !15
  call void @llvm.dbg.declare(metadata i32* %x, metadata !16, metadata !DIExpression()), !dbg !17
  %0 = load i32*, i32** %arr.addr, align 8, !dbg !18
  %arrayidx = getelementptr inbounds i32, i32* %0, i64 0, !dbg !18
  %1 = load i32, i32* %arrayidx, align 4, !dbg !18
  store i32 %1, i32* %x, align 4, !dbg !17
  call void @llvm.dbg.declare(metadata i32* %i, metadata !19, metadata !DIExpression()), !dbg !21
  store i32 1, i32* %i, align 4, !dbg !21
  br label %for.cond, !dbg !22

for.cond:                                         ; preds = %for.inc, %entry
  %2 = load i32, i32* %i, align 4, !dbg !23
  %3 = load i32, i32* %n.addr, align 4, !dbg !25
  %cmp = icmp slt i32 %2, %3, !dbg !26
  br i1 %cmp, label %for.body, label %for.end, !dbg !27

for.body:                                         ; preds = %for.cond
  %4 = load i32, i32* %x, align 4, !dbg !28
  %5 = load i32*, i32** %arr.addr, align 8, !dbg !29
  %6 = load i32, i32* %i, align 4, !dbg !30
  %idxprom = sext i32 %6 to i64, !dbg !29
  %arrayidx1 = getelementptr inbounds i32, i32* %5, i64 %idxprom, !dbg !29
  %7 = load i32, i32* %arrayidx1, align 4, !dbg !29
  %xor = xor i32 %4, %7, !dbg !31
  store i32 %xor, i32* %x, align 4, !dbg !32
  br label %for.inc, !dbg !33

for.inc:                                          ; preds = %for.body
  %8 = load i32, i32* %i, align 4, !dbg !34
  %inc = add nsw i32 %8, 1, !dbg !34
  store i32 %inc, i32* %i, align 4, !dbg !34
  br label %for.cond, !dbg !35, !llvm.loop !36

for.end:                                          ; preds = %for.cond
  %9 = load i32, i32* %x, align 4, !dbg !38
  ret i32 %9, !dbg !39
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !40 {
entry:
  %retval = alloca i32, align 4
  %arr = alloca [13 x i32], align 16
  %x = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata [13 x i32]* %arr, metadata !43, metadata !DIExpression()), !dbg !47
  %arrayidx = getelementptr inbounds [13 x i32], [13 x i32]* %arr, i64 0, i64 0, !dbg !48
  store i32 9, i32* %arrayidx, align 16, !dbg !49
  %arrayidx1 = getelementptr inbounds [13 x i32], [13 x i32]* %arr, i64 0, i64 1, !dbg !50
  store i32 12, i32* %arrayidx1, align 4, !dbg !51
  %arrayidx2 = getelementptr inbounds [13 x i32], [13 x i32]* %arr, i64 0, i64 2, !dbg !52
  store i32 2, i32* %arrayidx2, align 8, !dbg !53
  %arrayidx3 = getelementptr inbounds [13 x i32], [13 x i32]* %arr, i64 0, i64 3, !dbg !54
  store i32 11, i32* %arrayidx3, align 4, !dbg !55
  %arrayidx4 = getelementptr inbounds [13 x i32], [13 x i32]* %arr, i64 0, i64 4, !dbg !56
  store i32 2, i32* %arrayidx4, align 16, !dbg !57
  %arrayidx5 = getelementptr inbounds [13 x i32], [13 x i32]* %arr, i64 0, i64 5, !dbg !58
  store i32 2, i32* %arrayidx5, align 4, !dbg !59
  %arrayidx6 = getelementptr inbounds [13 x i32], [13 x i32]* %arr, i64 0, i64 6, !dbg !60
  store i32 10, i32* %arrayidx6, align 8, !dbg !61
  %arrayidx7 = getelementptr inbounds [13 x i32], [13 x i32]* %arr, i64 0, i64 7, !dbg !62
  store i32 9, i32* %arrayidx7, align 4, !dbg !63
  %arrayidx8 = getelementptr inbounds [13 x i32], [13 x i32]* %arr, i64 0, i64 8, !dbg !64
  store i32 12, i32* %arrayidx8, align 16, !dbg !65
  %arrayidx9 = getelementptr inbounds [13 x i32], [13 x i32]* %arr, i64 0, i64 9, !dbg !66
  store i32 10, i32* %arrayidx9, align 4, !dbg !67
  %arrayidx10 = getelementptr inbounds [13 x i32], [13 x i32]* %arr, i64 0, i64 10, !dbg !68
  store i32 9, i32* %arrayidx10, align 8, !dbg !69
  %arrayidx11 = getelementptr inbounds [13 x i32], [13 x i32]* %arr, i64 0, i64 11, !dbg !70
  store i32 11, i32* %arrayidx11, align 4, !dbg !71
  %arrayidx12 = getelementptr inbounds [13 x i32], [13 x i32]* %arr, i64 0, i64 12, !dbg !72
  store i32 2, i32* %arrayidx12, align 16, !dbg !73
  call void @llvm.dbg.declare(metadata i32* %x, metadata !74, metadata !DIExpression()), !dbg !75
  %arraydecay = getelementptr inbounds [13 x i32], [13 x i32]* %arr, i32 0, i32 0, !dbg !76
  %call = call i32 @fun(i32* %arraydecay, i32 10), !dbg !77
  store i32 %call, i32* %x, align 4, !dbg !75
  %0 = load i32, i32* %x, align 4, !dbg !78
  %cmp = icmp eq i32 %0, 9, !dbg !79
  %conv = zext i1 %cmp to i32, !dbg !79
  %call13 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !80
  ret i32 0, !dbg !81
}

declare dso_local i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 8.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "bitwise_2/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 8.0.0 "}
!7 = distinct !DISubprogram(name: "fun", scope: !1, file: !1, line: 1, type: !8, scopeLine: 2, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !11, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!12 = !DILocalVariable(name: "arr", arg: 1, scope: !7, file: !1, line: 1, type: !11)
!13 = !DILocation(line: 1, column: 13, scope: !7)
!14 = !DILocalVariable(name: "n", arg: 2, scope: !7, file: !1, line: 1, type: !10)
!15 = !DILocation(line: 1, column: 24, scope: !7)
!16 = !DILocalVariable(name: "x", scope: !7, file: !1, line: 3, type: !10)
!17 = !DILocation(line: 3, column: 9, scope: !7)
!18 = !DILocation(line: 3, column: 13, scope: !7)
!19 = !DILocalVariable(name: "i", scope: !20, file: !1, line: 4, type: !10)
!20 = distinct !DILexicalBlock(scope: !7, file: !1, line: 4, column: 5)
!21 = !DILocation(line: 4, column: 14, scope: !20)
!22 = !DILocation(line: 4, column: 10, scope: !20)
!23 = !DILocation(line: 4, column: 21, scope: !24)
!24 = distinct !DILexicalBlock(scope: !20, file: !1, line: 4, column: 5)
!25 = !DILocation(line: 4, column: 25, scope: !24)
!26 = !DILocation(line: 4, column: 23, scope: !24)
!27 = !DILocation(line: 4, column: 5, scope: !20)
!28 = !DILocation(line: 5, column: 13, scope: !24)
!29 = !DILocation(line: 5, column: 17, scope: !24)
!30 = !DILocation(line: 5, column: 21, scope: !24)
!31 = !DILocation(line: 5, column: 15, scope: !24)
!32 = !DILocation(line: 5, column: 11, scope: !24)
!33 = !DILocation(line: 5, column: 9, scope: !24)
!34 = !DILocation(line: 4, column: 29, scope: !24)
!35 = !DILocation(line: 4, column: 5, scope: !24)
!36 = distinct !{!36, !27, !37}
!37 = !DILocation(line: 5, column: 22, scope: !20)
!38 = !DILocation(line: 6, column: 12, scope: !7)
!39 = !DILocation(line: 6, column: 5, scope: !7)
!40 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 8, type: !41, scopeLine: 9, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!41 = !DISubroutineType(types: !42)
!42 = !{!10}
!43 = !DILocalVariable(name: "arr", scope: !40, file: !1, line: 10, type: !44)
!44 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 416, elements: !45)
!45 = !{!46}
!46 = !DISubrange(count: 13)
!47 = !DILocation(line: 10, column: 6, scope: !40)
!48 = !DILocation(line: 12, column: 2, scope: !40)
!49 = !DILocation(line: 12, column: 9, scope: !40)
!50 = !DILocation(line: 13, column: 2, scope: !40)
!51 = !DILocation(line: 13, column: 9, scope: !40)
!52 = !DILocation(line: 14, column: 2, scope: !40)
!53 = !DILocation(line: 14, column: 9, scope: !40)
!54 = !DILocation(line: 15, column: 2, scope: !40)
!55 = !DILocation(line: 15, column: 9, scope: !40)
!56 = !DILocation(line: 16, column: 2, scope: !40)
!57 = !DILocation(line: 16, column: 9, scope: !40)
!58 = !DILocation(line: 17, column: 2, scope: !40)
!59 = !DILocation(line: 17, column: 9, scope: !40)
!60 = !DILocation(line: 18, column: 2, scope: !40)
!61 = !DILocation(line: 18, column: 9, scope: !40)
!62 = !DILocation(line: 19, column: 2, scope: !40)
!63 = !DILocation(line: 19, column: 9, scope: !40)
!64 = !DILocation(line: 20, column: 2, scope: !40)
!65 = !DILocation(line: 20, column: 9, scope: !40)
!66 = !DILocation(line: 21, column: 2, scope: !40)
!67 = !DILocation(line: 21, column: 9, scope: !40)
!68 = !DILocation(line: 22, column: 2, scope: !40)
!69 = !DILocation(line: 22, column: 10, scope: !40)
!70 = !DILocation(line: 23, column: 2, scope: !40)
!71 = !DILocation(line: 23, column: 10, scope: !40)
!72 = !DILocation(line: 24, column: 2, scope: !40)
!73 = !DILocation(line: 24, column: 10, scope: !40)
!74 = !DILocalVariable(name: "x", scope: !40, file: !1, line: 25, type: !10)
!75 = !DILocation(line: 25, column: 6, scope: !40)
!76 = !DILocation(line: 25, column: 14, scope: !40)
!77 = !DILocation(line: 25, column: 10, scope: !40)
!78 = !DILocation(line: 27, column: 9, scope: !40)
!79 = !DILocation(line: 27, column: 10, scope: !40)
!80 = !DILocation(line: 27, column: 2, scope: !40)
!81 = !DILocation(line: 29, column: 2, scope: !40)

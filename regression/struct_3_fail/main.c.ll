; ModuleID = 'struct_3_fail/main.c'
source_filename = "struct_3_fail/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.QUEUE = type { [15 x i32], i32 }

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %queue = alloca %struct.QUEUE, align 4
  %n = alloca i32, align 4
  %i = alloca i32, align 4
  %sum = alloca i32, align 4
  %i3 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.QUEUE* %queue, metadata !11, metadata !DIExpression()), !dbg !20
  call void @llvm.dbg.declare(metadata i32* %n, metadata !21, metadata !DIExpression()), !dbg !22
  %0 = load i32, i32* %n, align 4, !dbg !23
  %cmp = icmp slt i32 %0, 15, !dbg !25
  br i1 %cmp, label %if.then, label %if.end, !dbg !26

if.then:                                          ; preds = %entry
  call void @llvm.dbg.declare(metadata i32* %i, metadata !27, metadata !DIExpression()), !dbg !30
  store i32 0, i32* %i, align 4, !dbg !30
  br label %for.cond, !dbg !31

for.cond:                                         ; preds = %for.inc, %if.then
  %1 = load i32, i32* %i, align 4, !dbg !32
  %2 = load i32, i32* %n, align 4, !dbg !34
  %cmp1 = icmp slt i32 %1, %2, !dbg !35
  br i1 %cmp1, label %for.body, label %for.end, !dbg !36

for.body:                                         ; preds = %for.cond
  %3 = load i32, i32* %i, align 4, !dbg !37
  %data = getelementptr inbounds %struct.QUEUE, %struct.QUEUE* %queue, i32 0, i32 0, !dbg !39
  %4 = load i32, i32* %i, align 4, !dbg !40
  %idxprom = sext i32 %4 to i64, !dbg !41
  %arrayidx = getelementptr inbounds [15 x i32], [15 x i32]* %data, i64 0, i64 %idxprom, !dbg !41
  store i32 %3, i32* %arrayidx, align 4, !dbg !42
  %size = getelementptr inbounds %struct.QUEUE, %struct.QUEUE* %queue, i32 0, i32 1, !dbg !43
  %5 = load i32, i32* %size, align 4, !dbg !44
  %inc = add nsw i32 %5, 1, !dbg !44
  store i32 %inc, i32* %size, align 4, !dbg !44
  br label %for.inc, !dbg !45

for.inc:                                          ; preds = %for.body
  %6 = load i32, i32* %i, align 4, !dbg !46
  %inc2 = add nsw i32 %6, 1, !dbg !46
  store i32 %inc2, i32* %i, align 4, !dbg !46
  br label %for.cond, !dbg !47, !llvm.loop !48

for.end:                                          ; preds = %for.cond
  call void @llvm.dbg.declare(metadata i32* %sum, metadata !50, metadata !DIExpression()), !dbg !51
  store i32 0, i32* %sum, align 4, !dbg !51
  call void @llvm.dbg.declare(metadata i32* %i3, metadata !52, metadata !DIExpression()), !dbg !54
  store i32 0, i32* %i3, align 4, !dbg !54
  br label %for.cond4, !dbg !55

for.cond4:                                        ; preds = %for.inc10, %for.end
  %7 = load i32, i32* %i3, align 4, !dbg !56
  %8 = load i32, i32* %n, align 4, !dbg !58
  %cmp5 = icmp slt i32 %7, %8, !dbg !59
  br i1 %cmp5, label %for.body6, label %for.end12, !dbg !60

for.body6:                                        ; preds = %for.cond4
  %data7 = getelementptr inbounds %struct.QUEUE, %struct.QUEUE* %queue, i32 0, i32 0, !dbg !61
  %9 = load i32, i32* %i3, align 4, !dbg !63
  %idxprom8 = sext i32 %9 to i64, !dbg !64
  %arrayidx9 = getelementptr inbounds [15 x i32], [15 x i32]* %data7, i64 0, i64 %idxprom8, !dbg !64
  %10 = load i32, i32* %arrayidx9, align 4, !dbg !64
  %11 = load i32, i32* %sum, align 4, !dbg !65
  %add = add nsw i32 %11, %10, !dbg !65
  store i32 %add, i32* %sum, align 4, !dbg !65
  br label %for.inc10, !dbg !66

for.inc10:                                        ; preds = %for.body6
  %12 = load i32, i32* %i3, align 4, !dbg !67
  %inc11 = add nsw i32 %12, 1, !dbg !67
  store i32 %inc11, i32* %i3, align 4, !dbg !67
  br label %for.cond4, !dbg !68, !llvm.loop !69

for.end12:                                        ; preds = %for.cond4
  %13 = load i32, i32* %sum, align 4, !dbg !71
  %14 = load i32, i32* %n, align 4, !dbg !72
  %sub = sub nsw i32 %14, 1, !dbg !73
  %15 = load i32, i32* %n, align 4, !dbg !74
  %mul = mul nsw i32 %sub, %15, !dbg !75
  %div = sdiv i32 %mul, 2, !dbg !76
  %cmp13 = icmp eq i32 %13, %div, !dbg !77
  %conv = zext i1 %cmp13 to i32, !dbg !77
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !78
  br label %if.end, !dbg !79

if.end:                                           ; preds = %for.end12, %entry
  ret i32 0, !dbg !80
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
!1 = !DIFile(filename: "struct_3_fail/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 8.0.0 "}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 13, type: !8, scopeLine: 14, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "queue", scope: !7, file: !1, line: 15, type: !12)
!12 = !DIDerivedType(tag: DW_TAG_typedef, name: "QUEUE", file: !1, line: 11, baseType: !13)
!13 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "QUEUE", file: !1, line: 5, size: 512, elements: !14)
!14 = !{!15, !19}
!15 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !13, file: !1, line: 7, baseType: !16, size: 480)
!16 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 480, elements: !17)
!17 = !{!18}
!18 = !DISubrange(count: 15)
!19 = !DIDerivedType(tag: DW_TAG_member, name: "size", scope: !13, file: !1, line: 8, baseType: !10, size: 32, offset: 480)
!20 = !DILocation(line: 15, column: 8, scope: !7)
!21 = !DILocalVariable(name: "n", scope: !7, file: !1, line: 16, type: !10)
!22 = !DILocation(line: 16, column: 6, scope: !7)
!23 = !DILocation(line: 20, column: 5, scope: !24)
!24 = distinct !DILexicalBlock(scope: !7, file: !1, line: 20, column: 5)
!25 = !DILocation(line: 20, column: 6, scope: !24)
!26 = !DILocation(line: 20, column: 5, scope: !7)
!27 = !DILocalVariable(name: "i", scope: !28, file: !1, line: 22, type: !10)
!28 = distinct !DILexicalBlock(scope: !29, file: !1, line: 22, column: 3)
!29 = distinct !DILexicalBlock(scope: !24, file: !1, line: 21, column: 2)
!30 = !DILocation(line: 22, column: 11, scope: !28)
!31 = !DILocation(line: 22, column: 7, scope: !28)
!32 = !DILocation(line: 22, column: 17, scope: !33)
!33 = distinct !DILexicalBlock(scope: !28, file: !1, line: 22, column: 3)
!34 = !DILocation(line: 22, column: 19, scope: !33)
!35 = !DILocation(line: 22, column: 18, scope: !33)
!36 = !DILocation(line: 22, column: 3, scope: !28)
!37 = !DILocation(line: 24, column: 20, scope: !38)
!38 = distinct !DILexicalBlock(scope: !33, file: !1, line: 23, column: 3)
!39 = !DILocation(line: 24, column: 10, scope: !38)
!40 = !DILocation(line: 24, column: 15, scope: !38)
!41 = !DILocation(line: 24, column: 4, scope: !38)
!42 = !DILocation(line: 24, column: 18, scope: !38)
!43 = !DILocation(line: 25, column: 12, scope: !38)
!44 = !DILocation(line: 25, column: 4, scope: !38)
!45 = !DILocation(line: 26, column: 3, scope: !38)
!46 = !DILocation(line: 22, column: 24, scope: !33)
!47 = !DILocation(line: 22, column: 3, scope: !33)
!48 = distinct !{!48, !36, !49}
!49 = !DILocation(line: 26, column: 3, scope: !28)
!50 = !DILocalVariable(name: "sum", scope: !29, file: !1, line: 28, type: !10)
!51 = !DILocation(line: 28, column: 7, scope: !29)
!52 = !DILocalVariable(name: "i", scope: !53, file: !1, line: 30, type: !10)
!53 = distinct !DILexicalBlock(scope: !29, file: !1, line: 30, column: 3)
!54 = !DILocation(line: 30, column: 11, scope: !53)
!55 = !DILocation(line: 30, column: 7, scope: !53)
!56 = !DILocation(line: 30, column: 17, scope: !57)
!57 = distinct !DILexicalBlock(scope: !53, file: !1, line: 30, column: 3)
!58 = !DILocation(line: 30, column: 19, scope: !57)
!59 = !DILocation(line: 30, column: 18, scope: !57)
!60 = !DILocation(line: 30, column: 3, scope: !53)
!61 = !DILocation(line: 32, column: 17, scope: !62)
!62 = distinct !DILexicalBlock(scope: !57, file: !1, line: 31, column: 3)
!63 = !DILocation(line: 32, column: 22, scope: !62)
!64 = !DILocation(line: 32, column: 11, scope: !62)
!65 = !DILocation(line: 32, column: 8, scope: !62)
!66 = !DILocation(line: 33, column: 3, scope: !62)
!67 = !DILocation(line: 30, column: 24, scope: !57)
!68 = !DILocation(line: 30, column: 3, scope: !57)
!69 = distinct !{!69, !60, !70}
!70 = !DILocation(line: 33, column: 3, scope: !53)
!71 = !DILocation(line: 35, column: 10, scope: !29)
!72 = !DILocation(line: 35, column: 19, scope: !29)
!73 = !DILocation(line: 35, column: 20, scope: !29)
!74 = !DILocation(line: 35, column: 24, scope: !29)
!75 = !DILocation(line: 35, column: 23, scope: !29)
!76 = !DILocation(line: 35, column: 26, scope: !29)
!77 = !DILocation(line: 35, column: 14, scope: !29)
!78 = !DILocation(line: 35, column: 3, scope: !29)
!79 = !DILocation(line: 36, column: 2, scope: !29)
!80 = !DILocation(line: 38, column: 2, scope: !7)

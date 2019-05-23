; ModuleID = 'struct_3/main.c'
source_filename = "struct_3/main.c"
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
  %i4 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.QUEUE* %queue, metadata !11, metadata !DIExpression()), !dbg !20
  call void @llvm.dbg.declare(metadata i32* %n, metadata !21, metadata !DIExpression()), !dbg !22
  %0 = load i32, i32* %n, align 4, !dbg !23
  %cmp = icmp slt i32 %0, 15, !dbg !25
  br i1 %cmp, label %land.lhs.true, label %if.end, !dbg !26

land.lhs.true:                                    ; preds = %entry
  %1 = load i32, i32* %n, align 4, !dbg !27
  %cmp1 = icmp sgt i32 %1, 0, !dbg !28
  br i1 %cmp1, label %if.then, label %if.end, !dbg !29

if.then:                                          ; preds = %land.lhs.true
  call void @llvm.dbg.declare(metadata i32* %i, metadata !30, metadata !DIExpression()), !dbg !33
  store i32 0, i32* %i, align 4, !dbg !33
  br label %for.cond, !dbg !34

for.cond:                                         ; preds = %for.inc, %if.then
  %2 = load i32, i32* %i, align 4, !dbg !35
  %3 = load i32, i32* %n, align 4, !dbg !37
  %cmp2 = icmp slt i32 %2, %3, !dbg !38
  br i1 %cmp2, label %for.body, label %for.end, !dbg !39

for.body:                                         ; preds = %for.cond
  %4 = load i32, i32* %i, align 4, !dbg !40
  %data = getelementptr inbounds %struct.QUEUE, %struct.QUEUE* %queue, i32 0, i32 0, !dbg !42
  %5 = load i32, i32* %i, align 4, !dbg !43
  %idxprom = sext i32 %5 to i64, !dbg !44
  %arrayidx = getelementptr inbounds [15 x i32], [15 x i32]* %data, i64 0, i64 %idxprom, !dbg !44
  store i32 %4, i32* %arrayidx, align 4, !dbg !45
  %size = getelementptr inbounds %struct.QUEUE, %struct.QUEUE* %queue, i32 0, i32 1, !dbg !46
  %6 = load i32, i32* %size, align 4, !dbg !47
  %inc = add nsw i32 %6, 1, !dbg !47
  store i32 %inc, i32* %size, align 4, !dbg !47
  br label %for.inc, !dbg !48

for.inc:                                          ; preds = %for.body
  %7 = load i32, i32* %i, align 4, !dbg !49
  %inc3 = add nsw i32 %7, 1, !dbg !49
  store i32 %inc3, i32* %i, align 4, !dbg !49
  br label %for.cond, !dbg !50, !llvm.loop !51

for.end:                                          ; preds = %for.cond
  call void @llvm.dbg.declare(metadata i32* %sum, metadata !53, metadata !DIExpression()), !dbg !54
  store i32 0, i32* %sum, align 4, !dbg !54
  call void @llvm.dbg.declare(metadata i32* %i4, metadata !55, metadata !DIExpression()), !dbg !57
  store i32 0, i32* %i4, align 4, !dbg !57
  br label %for.cond5, !dbg !58

for.cond5:                                        ; preds = %for.inc11, %for.end
  %8 = load i32, i32* %i4, align 4, !dbg !59
  %9 = load i32, i32* %n, align 4, !dbg !61
  %cmp6 = icmp slt i32 %8, %9, !dbg !62
  br i1 %cmp6, label %for.body7, label %for.end13, !dbg !63

for.body7:                                        ; preds = %for.cond5
  %data8 = getelementptr inbounds %struct.QUEUE, %struct.QUEUE* %queue, i32 0, i32 0, !dbg !64
  %10 = load i32, i32* %i4, align 4, !dbg !66
  %idxprom9 = sext i32 %10 to i64, !dbg !67
  %arrayidx10 = getelementptr inbounds [15 x i32], [15 x i32]* %data8, i64 0, i64 %idxprom9, !dbg !67
  %11 = load i32, i32* %arrayidx10, align 4, !dbg !67
  %12 = load i32, i32* %sum, align 4, !dbg !68
  %add = add nsw i32 %12, %11, !dbg !68
  store i32 %add, i32* %sum, align 4, !dbg !68
  br label %for.inc11, !dbg !69

for.inc11:                                        ; preds = %for.body7
  %13 = load i32, i32* %i4, align 4, !dbg !70
  %inc12 = add nsw i32 %13, 1, !dbg !70
  store i32 %inc12, i32* %i4, align 4, !dbg !70
  br label %for.cond5, !dbg !71, !llvm.loop !72

for.end13:                                        ; preds = %for.cond5
  %14 = load i32, i32* %sum, align 4, !dbg !74
  %15 = load i32, i32* %n, align 4, !dbg !75
  %sub = sub nsw i32 %15, 1, !dbg !76
  %16 = load i32, i32* %n, align 4, !dbg !77
  %mul = mul nsw i32 %sub, %16, !dbg !78
  %div = sdiv i32 %mul, 2, !dbg !79
  %cmp14 = icmp eq i32 %14, %div, !dbg !80
  %conv = zext i1 %cmp14 to i32, !dbg !80
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !81
  br label %if.end, !dbg !82

if.end:                                           ; preds = %for.end13, %land.lhs.true, %entry
  ret i32 0, !dbg !83
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
!1 = !DIFile(filename: "struct_3/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
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
!26 = !DILocation(line: 20, column: 9, scope: !24)
!27 = !DILocation(line: 20, column: 12, scope: !24)
!28 = !DILocation(line: 20, column: 13, scope: !24)
!29 = !DILocation(line: 20, column: 5, scope: !7)
!30 = !DILocalVariable(name: "i", scope: !31, file: !1, line: 22, type: !10)
!31 = distinct !DILexicalBlock(scope: !32, file: !1, line: 22, column: 3)
!32 = distinct !DILexicalBlock(scope: !24, file: !1, line: 21, column: 2)
!33 = !DILocation(line: 22, column: 11, scope: !31)
!34 = !DILocation(line: 22, column: 7, scope: !31)
!35 = !DILocation(line: 22, column: 17, scope: !36)
!36 = distinct !DILexicalBlock(scope: !31, file: !1, line: 22, column: 3)
!37 = !DILocation(line: 22, column: 19, scope: !36)
!38 = !DILocation(line: 22, column: 18, scope: !36)
!39 = !DILocation(line: 22, column: 3, scope: !31)
!40 = !DILocation(line: 24, column: 20, scope: !41)
!41 = distinct !DILexicalBlock(scope: !36, file: !1, line: 23, column: 3)
!42 = !DILocation(line: 24, column: 10, scope: !41)
!43 = !DILocation(line: 24, column: 15, scope: !41)
!44 = !DILocation(line: 24, column: 4, scope: !41)
!45 = !DILocation(line: 24, column: 18, scope: !41)
!46 = !DILocation(line: 25, column: 12, scope: !41)
!47 = !DILocation(line: 25, column: 4, scope: !41)
!48 = !DILocation(line: 26, column: 3, scope: !41)
!49 = !DILocation(line: 22, column: 24, scope: !36)
!50 = !DILocation(line: 22, column: 3, scope: !36)
!51 = distinct !{!51, !39, !52}
!52 = !DILocation(line: 26, column: 3, scope: !31)
!53 = !DILocalVariable(name: "sum", scope: !32, file: !1, line: 28, type: !10)
!54 = !DILocation(line: 28, column: 7, scope: !32)
!55 = !DILocalVariable(name: "i", scope: !56, file: !1, line: 30, type: !10)
!56 = distinct !DILexicalBlock(scope: !32, file: !1, line: 30, column: 3)
!57 = !DILocation(line: 30, column: 11, scope: !56)
!58 = !DILocation(line: 30, column: 7, scope: !56)
!59 = !DILocation(line: 30, column: 17, scope: !60)
!60 = distinct !DILexicalBlock(scope: !56, file: !1, line: 30, column: 3)
!61 = !DILocation(line: 30, column: 19, scope: !60)
!62 = !DILocation(line: 30, column: 18, scope: !60)
!63 = !DILocation(line: 30, column: 3, scope: !56)
!64 = !DILocation(line: 32, column: 17, scope: !65)
!65 = distinct !DILexicalBlock(scope: !60, file: !1, line: 31, column: 3)
!66 = !DILocation(line: 32, column: 22, scope: !65)
!67 = !DILocation(line: 32, column: 11, scope: !65)
!68 = !DILocation(line: 32, column: 8, scope: !65)
!69 = !DILocation(line: 33, column: 3, scope: !65)
!70 = !DILocation(line: 30, column: 24, scope: !60)
!71 = !DILocation(line: 30, column: 3, scope: !60)
!72 = distinct !{!72, !63, !73}
!73 = !DILocation(line: 33, column: 3, scope: !56)
!74 = !DILocation(line: 35, column: 10, scope: !32)
!75 = !DILocation(line: 35, column: 19, scope: !32)
!76 = !DILocation(line: 35, column: 20, scope: !32)
!77 = !DILocation(line: 35, column: 24, scope: !32)
!78 = !DILocation(line: 35, column: 23, scope: !32)
!79 = !DILocation(line: 35, column: 26, scope: !32)
!80 = !DILocation(line: 35, column: 14, scope: !32)
!81 = !DILocation(line: 35, column: 3, scope: !32)
!82 = !DILocation(line: 36, column: 2, scope: !32)
!83 = !DILocation(line: 38, column: 2, scope: !7)

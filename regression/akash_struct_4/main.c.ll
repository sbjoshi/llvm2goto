; ModuleID = 'akash_struct_4/main.c'
source_filename = "akash_struct_4/main.c"
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
  call void @llvm.dbg.declare(metadata %struct.QUEUE* %queue, metadata !11, metadata !DIExpression()), !dbg !19
  call void @llvm.dbg.declare(metadata i32* %n, metadata !20, metadata !DIExpression()), !dbg !21
  %0 = load i32, i32* %n, align 4, !dbg !22
  %cmp = icmp slt i32 %0, 15, !dbg !24
  br i1 %cmp, label %land.lhs.true, label %if.end, !dbg !25

land.lhs.true:                                    ; preds = %entry
  %1 = load i32, i32* %n, align 4, !dbg !26
  %cmp1 = icmp sgt i32 %1, 0, !dbg !27
  br i1 %cmp1, label %if.then, label %if.end, !dbg !28

if.then:                                          ; preds = %land.lhs.true
  call void @llvm.dbg.declare(metadata i32* %i, metadata !29, metadata !DIExpression()), !dbg !32
  store i32 0, i32* %i, align 4, !dbg !32
  br label %for.cond, !dbg !33

for.cond:                                         ; preds = %for.inc, %if.then
  %2 = load i32, i32* %i, align 4, !dbg !34
  %3 = load i32, i32* %n, align 4, !dbg !36
  %cmp2 = icmp slt i32 %2, %3, !dbg !37
  br i1 %cmp2, label %for.body, label %for.end, !dbg !38

for.body:                                         ; preds = %for.cond
  %4 = load i32, i32* %i, align 4, !dbg !39
  %data = getelementptr inbounds %struct.QUEUE, %struct.QUEUE* %queue, i32 0, i32 0, !dbg !41
  %5 = load i32, i32* %i, align 4, !dbg !42
  %idxprom = sext i32 %5 to i64, !dbg !43
  %arrayidx = getelementptr inbounds [15 x i32], [15 x i32]* %data, i64 0, i64 %idxprom, !dbg !43
  store i32 %4, i32* %arrayidx, align 4, !dbg !44
  %size = getelementptr inbounds %struct.QUEUE, %struct.QUEUE* %queue, i32 0, i32 1, !dbg !45
  %6 = load i32, i32* %size, align 4, !dbg !46
  %inc = add nsw i32 %6, 1, !dbg !46
  store i32 %inc, i32* %size, align 4, !dbg !46
  br label %for.inc, !dbg !47

for.inc:                                          ; preds = %for.body
  %7 = load i32, i32* %i, align 4, !dbg !48
  %inc3 = add nsw i32 %7, 1, !dbg !48
  store i32 %inc3, i32* %i, align 4, !dbg !48
  br label %for.cond, !dbg !49, !llvm.loop !50

for.end:                                          ; preds = %for.cond
  call void @llvm.dbg.declare(metadata i32* %sum, metadata !52, metadata !DIExpression()), !dbg !53
  store i32 0, i32* %sum, align 4, !dbg !53
  call void @llvm.dbg.declare(metadata i32* %i4, metadata !54, metadata !DIExpression()), !dbg !56
  store i32 0, i32* %i4, align 4, !dbg !56
  br label %for.cond5, !dbg !57

for.cond5:                                        ; preds = %for.inc11, %for.end
  %8 = load i32, i32* %i4, align 4, !dbg !58
  %9 = load i32, i32* %n, align 4, !dbg !60
  %cmp6 = icmp slt i32 %8, %9, !dbg !61
  br i1 %cmp6, label %for.body7, label %for.end13, !dbg !62

for.body7:                                        ; preds = %for.cond5
  %data8 = getelementptr inbounds %struct.QUEUE, %struct.QUEUE* %queue, i32 0, i32 0, !dbg !63
  %10 = load i32, i32* %i4, align 4, !dbg !65
  %idxprom9 = sext i32 %10 to i64, !dbg !66
  %arrayidx10 = getelementptr inbounds [15 x i32], [15 x i32]* %data8, i64 0, i64 %idxprom9, !dbg !66
  %11 = load i32, i32* %arrayidx10, align 4, !dbg !66
  %12 = load i32, i32* %sum, align 4, !dbg !67
  %add = add nsw i32 %12, %11, !dbg !67
  store i32 %add, i32* %sum, align 4, !dbg !67
  br label %for.inc11, !dbg !68

for.inc11:                                        ; preds = %for.body7
  %13 = load i32, i32* %i4, align 4, !dbg !69
  %inc12 = add nsw i32 %13, 1, !dbg !69
  store i32 %inc12, i32* %i4, align 4, !dbg !69
  br label %for.cond5, !dbg !70, !llvm.loop !71

for.end13:                                        ; preds = %for.cond5
  %14 = load i32, i32* %sum, align 4, !dbg !73
  %15 = load i32, i32* %n, align 4, !dbg !74
  %sub = sub nsw i32 %15, 1, !dbg !75
  %16 = load i32, i32* %n, align 4, !dbg !76
  %mul = mul nsw i32 %sub, %16, !dbg !77
  %div = sdiv i32 %mul, 2, !dbg !78
  %cmp14 = icmp eq i32 %14, %div, !dbg !79
  %conv = zext i1 %cmp14 to i32, !dbg !79
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !80
  br label %if.end, !dbg !81

if.end:                                           ; preds = %for.end13, %land.lhs.true, %entry
  ret i32 0, !dbg !82
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
!1 = !DIFile(filename: "akash_struct_4/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 8.0.0 "}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 12, type: !8, scopeLine: 12, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "queue", scope: !7, file: !1, line: 13, type: !12)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "QUEUE", file: !1, line: 5, size: 512, elements: !13)
!13 = !{!14, !18}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !12, file: !1, line: 6, baseType: !15, size: 480)
!15 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 480, elements: !16)
!16 = !{!17}
!17 = !DISubrange(count: 15)
!18 = !DIDerivedType(tag: DW_TAG_member, name: "size", scope: !12, file: !1, line: 7, baseType: !10, size: 32, offset: 480)
!19 = !DILocation(line: 13, column: 16, scope: !7)
!20 = !DILocalVariable(name: "n", scope: !7, file: !1, line: 14, type: !10)
!21 = !DILocation(line: 14, column: 7, scope: !7)
!22 = !DILocation(line: 16, column: 7, scope: !23)
!23 = distinct !DILexicalBlock(scope: !7, file: !1, line: 16, column: 7)
!24 = !DILocation(line: 16, column: 9, scope: !23)
!25 = !DILocation(line: 16, column: 13, scope: !23)
!26 = !DILocation(line: 16, column: 16, scope: !23)
!27 = !DILocation(line: 16, column: 18, scope: !23)
!28 = !DILocation(line: 16, column: 7, scope: !7)
!29 = !DILocalVariable(name: "i", scope: !30, file: !1, line: 17, type: !10)
!30 = distinct !DILexicalBlock(scope: !31, file: !1, line: 17, column: 5)
!31 = distinct !DILexicalBlock(scope: !23, file: !1, line: 16, column: 23)
!32 = !DILocation(line: 17, column: 14, scope: !30)
!33 = !DILocation(line: 17, column: 10, scope: !30)
!34 = !DILocation(line: 17, column: 21, scope: !35)
!35 = distinct !DILexicalBlock(scope: !30, file: !1, line: 17, column: 5)
!36 = !DILocation(line: 17, column: 25, scope: !35)
!37 = !DILocation(line: 17, column: 23, scope: !35)
!38 = !DILocation(line: 17, column: 5, scope: !30)
!39 = !DILocation(line: 18, column: 23, scope: !40)
!40 = distinct !DILexicalBlock(scope: !35, file: !1, line: 17, column: 33)
!41 = !DILocation(line: 18, column: 13, scope: !40)
!42 = !DILocation(line: 18, column: 18, scope: !40)
!43 = !DILocation(line: 18, column: 7, scope: !40)
!44 = !DILocation(line: 18, column: 21, scope: !40)
!45 = !DILocation(line: 19, column: 15, scope: !40)
!46 = !DILocation(line: 19, column: 7, scope: !40)
!47 = !DILocation(line: 20, column: 5, scope: !40)
!48 = !DILocation(line: 17, column: 29, scope: !35)
!49 = !DILocation(line: 17, column: 5, scope: !35)
!50 = distinct !{!50, !38, !51}
!51 = !DILocation(line: 20, column: 5, scope: !30)
!52 = !DILocalVariable(name: "sum", scope: !31, file: !1, line: 22, type: !10)
!53 = !DILocation(line: 22, column: 9, scope: !31)
!54 = !DILocalVariable(name: "i", scope: !55, file: !1, line: 24, type: !10)
!55 = distinct !DILexicalBlock(scope: !31, file: !1, line: 24, column: 5)
!56 = !DILocation(line: 24, column: 14, scope: !55)
!57 = !DILocation(line: 24, column: 10, scope: !55)
!58 = !DILocation(line: 24, column: 21, scope: !59)
!59 = distinct !DILexicalBlock(scope: !55, file: !1, line: 24, column: 5)
!60 = !DILocation(line: 24, column: 25, scope: !59)
!61 = !DILocation(line: 24, column: 23, scope: !59)
!62 = !DILocation(line: 24, column: 5, scope: !55)
!63 = !DILocation(line: 25, column: 20, scope: !64)
!64 = distinct !DILexicalBlock(scope: !59, file: !1, line: 24, column: 33)
!65 = !DILocation(line: 25, column: 25, scope: !64)
!66 = !DILocation(line: 25, column: 14, scope: !64)
!67 = !DILocation(line: 25, column: 11, scope: !64)
!68 = !DILocation(line: 26, column: 5, scope: !64)
!69 = !DILocation(line: 24, column: 29, scope: !59)
!70 = !DILocation(line: 24, column: 5, scope: !59)
!71 = distinct !{!71, !62, !72}
!72 = !DILocation(line: 26, column: 5, scope: !55)
!73 = !DILocation(line: 28, column: 12, scope: !31)
!74 = !DILocation(line: 28, column: 21, scope: !31)
!75 = !DILocation(line: 28, column: 23, scope: !31)
!76 = !DILocation(line: 28, column: 30, scope: !31)
!77 = !DILocation(line: 28, column: 28, scope: !31)
!78 = !DILocation(line: 28, column: 33, scope: !31)
!79 = !DILocation(line: 28, column: 16, scope: !31)
!80 = !DILocation(line: 28, column: 5, scope: !31)
!81 = !DILocation(line: 29, column: 3, scope: !31)
!82 = !DILocation(line: 31, column: 3, scope: !7)

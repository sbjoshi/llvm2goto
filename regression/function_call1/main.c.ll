; ModuleID = 'function_call1/main.c'
source_filename = "function_call1/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.str = type { i32, i32, i32, [4 x i32], [4 x i32] }

@s = common global %struct.str zeroinitializer, align 4, !dbg !0

; Function Attrs: noinline nounwind uwtable
define void @pass_through_struct_containing_arrays(i32 %q) #0 !dbg !20 {
entry:
  %q.addr = alloca i32, align 4
  %i = alloca i32, align 4
  %i1 = alloca i32, align 4
  store i32 %q, i32* %q.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %q.addr, metadata !23, metadata !24), !dbg !25
  %0 = load i32, i32* %q.addr, align 4, !dbg !26
  store i32 %0, i32* getelementptr inbounds (%struct.str, %struct.str* @s, i32 0, i32 0), align 4, !dbg !27
  store i32 0, i32* getelementptr inbounds (%struct.str, %struct.str* @s, i32 0, i32 1), align 4, !dbg !28
  call void @llvm.dbg.declare(metadata i32* %i, metadata !29, metadata !24), !dbg !31
  store i32 0, i32* %i, align 4, !dbg !31
  br label %for.cond, !dbg !32

for.cond:                                         ; preds = %for.inc, %entry
  %1 = load i32, i32* %i, align 4, !dbg !33
  %cmp = icmp slt i32 %1, 4, !dbg !36
  br i1 %cmp, label %for.body, label %for.end, !dbg !37

for.body:                                         ; preds = %for.cond
  %2 = load i32, i32* getelementptr inbounds (%struct.str, %struct.str* @s, i32 0, i32 0), align 4, !dbg !39
  %3 = load i32, i32* getelementptr inbounds (%struct.str, %struct.str* @s, i32 0, i32 1), align 4, !dbg !41
  %add = add nsw i32 %2, %3, !dbg !42
  %4 = load i32, i32* %i, align 4, !dbg !43
  %idxprom = sext i32 %4 to i64, !dbg !44
  %arrayidx = getelementptr inbounds [4 x i32], [4 x i32]* getelementptr inbounds (%struct.str, %struct.str* @s, i32 0, i32 3), i64 0, i64 %idxprom, !dbg !44
  store i32 %add, i32* %arrayidx, align 4, !dbg !45
  br label %for.inc, !dbg !46

for.inc:                                          ; preds = %for.body
  %5 = load i32, i32* %i, align 4, !dbg !47
  %inc = add nsw i32 %5, 1, !dbg !47
  store i32 %inc, i32* %i, align 4, !dbg !47
  br label %for.cond, !dbg !49, !llvm.loop !50

for.end:                                          ; preds = %for.cond
  call void @llvm.dbg.declare(metadata i32* %i1, metadata !53, metadata !24), !dbg !55
  store i32 0, i32* %i1, align 4, !dbg !55
  br label %for.cond2, !dbg !56

for.cond2:                                        ; preds = %for.inc9, %for.end
  %6 = load i32, i32* %i1, align 4, !dbg !57
  %cmp3 = icmp slt i32 %6, 4, !dbg !60
  br i1 %cmp3, label %for.body4, label %for.end11, !dbg !61

for.body4:                                        ; preds = %for.cond2
  %7 = load i32, i32* %i1, align 4, !dbg !63
  %idxprom5 = sext i32 %7 to i64, !dbg !65
  %arrayidx6 = getelementptr inbounds [4 x i32], [4 x i32]* getelementptr inbounds (%struct.str, %struct.str* @s, i32 0, i32 3), i64 0, i64 %idxprom5, !dbg !65
  %8 = load i32, i32* %arrayidx6, align 4, !dbg !65
  %9 = load i32, i32* %i1, align 4, !dbg !66
  %idxprom7 = sext i32 %9 to i64, !dbg !67
  %arrayidx8 = getelementptr inbounds [4 x i32], [4 x i32]* getelementptr inbounds (%struct.str, %struct.str* @s, i32 0, i32 4), i64 0, i64 %idxprom7, !dbg !67
  store i32 %8, i32* %arrayidx8, align 4, !dbg !68
  br label %for.inc9, !dbg !69

for.inc9:                                         ; preds = %for.body4
  %10 = load i32, i32* %i1, align 4, !dbg !70
  %inc10 = add nsw i32 %10, 1, !dbg !70
  store i32 %inc10, i32* %i1, align 4, !dbg !70
  br label %for.cond2, !dbg !72, !llvm.loop !73

for.end11:                                        ; preds = %for.cond2
  ret void, !dbg !76
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !77 {
entry:
  %retval = alloca i32, align 4
  %q = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %q, metadata !80, metadata !24), !dbg !81
  %0 = load i32, i32* %q, align 4, !dbg !82
  call void @pass_through_struct_containing_arrays(i32 %0), !dbg !83
  %1 = load i32, i32* %q, align 4, !dbg !84
  %2 = load i32, i32* getelementptr inbounds (%struct.str, %struct.str* @s, i32 0, i32 4, i64 3), align 4, !dbg !85
  %3 = load i32, i32* getelementptr inbounds (%struct.str, %struct.str* @s, i32 0, i32 1), align 4, !dbg !86
  %add = add nsw i32 %2, %3, !dbg !87
  %cmp = icmp eq i32 %1, %add, !dbg !88
  %conv = zext i1 %cmp to i32, !dbg !88
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !89
  ret i32 1, !dbg !90
}

declare i32 @assert(...) #2

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!17, !18}
!llvm.ident = !{!19}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "s", scope: !2, file: !3, line: 14, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.0 (trunk 295264)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "function_call1/main.c", directory: "/home/rasika/llvm2goto/llvm2goto-regression-master")
!4 = !{}
!5 = !{!0}
!6 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "str", file: !3, line: 5, size: 352, elements: !7)
!7 = !{!8, !10, !11, !12, !16}
!8 = !DIDerivedType(tag: DW_TAG_member, name: "x", scope: !6, file: !3, line: 7, baseType: !9, size: 32)
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DIDerivedType(tag: DW_TAG_member, name: "y", scope: !6, file: !3, line: 8, baseType: !9, size: 32, offset: 32)
!11 = !DIDerivedType(tag: DW_TAG_member, name: "z", scope: !6, file: !3, line: 9, baseType: !9, size: 32, offset: 64)
!12 = !DIDerivedType(tag: DW_TAG_member, name: "s", scope: !6, file: !3, line: 10, baseType: !13, size: 128, offset: 96)
!13 = !DICompositeType(tag: DW_TAG_array_type, baseType: !9, size: 128, elements: !14)
!14 = !{!15}
!15 = !DISubrange(count: 4)
!16 = !DIDerivedType(tag: DW_TAG_member, name: "t", scope: !6, file: !3, line: 11, baseType: !13, size: 128, offset: 224)
!17 = !{i32 2, !"Dwarf Version", i32 4}
!18 = !{i32 2, !"Debug Info Version", i32 3}
!19 = !{!"clang version 5.0.0 (trunk 295264)"}
!20 = distinct !DISubprogram(name: "pass_through_struct_containing_arrays", scope: !3, file: !3, line: 16, type: !21, isLocal: false, isDefinition: true, scopeLine: 17, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!21 = !DISubroutineType(types: !22)
!22 = !{null, !9}
!23 = !DILocalVariable(name: "q", arg: 1, scope: !20, file: !3, line: 16, type: !9)
!24 = !DIExpression()
!25 = !DILocation(line: 16, column: 49, scope: !20)
!26 = !DILocation(line: 18, column: 9, scope: !20)
!27 = !DILocation(line: 18, column: 7, scope: !20)
!28 = !DILocation(line: 19, column: 7, scope: !20)
!29 = !DILocalVariable(name: "i", scope: !30, file: !3, line: 21, type: !9)
!30 = distinct !DILexicalBlock(scope: !20, file: !3, line: 21, column: 3)
!31 = !DILocation(line: 21, column: 12, scope: !30)
!32 = !DILocation(line: 21, column: 8, scope: !30)
!33 = !DILocation(line: 21, column: 19, scope: !34)
!34 = !DILexicalBlockFile(scope: !35, file: !3, discriminator: 2)
!35 = distinct !DILexicalBlock(scope: !30, file: !3, line: 21, column: 3)
!36 = !DILocation(line: 21, column: 21, scope: !34)
!37 = !DILocation(line: 21, column: 3, scope: !38)
!38 = !DILexicalBlockFile(scope: !30, file: !3, discriminator: 2)
!39 = !DILocation(line: 23, column: 16, scope: !40)
!40 = distinct !DILexicalBlock(scope: !35, file: !3, line: 22, column: 3)
!41 = !DILocation(line: 23, column: 22, scope: !40)
!42 = !DILocation(line: 23, column: 18, scope: !40)
!43 = !DILocation(line: 23, column: 9, scope: !40)
!44 = !DILocation(line: 23, column: 5, scope: !40)
!45 = !DILocation(line: 23, column: 12, scope: !40)
!46 = !DILocation(line: 24, column: 3, scope: !40)
!47 = !DILocation(line: 21, column: 29, scope: !48)
!48 = !DILexicalBlockFile(scope: !35, file: !3, discriminator: 4)
!49 = !DILocation(line: 21, column: 3, scope: !48)
!50 = distinct !{!50, !51, !52}
!51 = !DILocation(line: 21, column: 3, scope: !30)
!52 = !DILocation(line: 24, column: 3, scope: !30)
!53 = !DILocalVariable(name: "i", scope: !54, file: !3, line: 26, type: !9)
!54 = distinct !DILexicalBlock(scope: !20, file: !3, line: 26, column: 3)
!55 = !DILocation(line: 26, column: 12, scope: !54)
!56 = !DILocation(line: 26, column: 8, scope: !54)
!57 = !DILocation(line: 26, column: 19, scope: !58)
!58 = !DILexicalBlockFile(scope: !59, file: !3, discriminator: 2)
!59 = distinct !DILexicalBlock(scope: !54, file: !3, line: 26, column: 3)
!60 = !DILocation(line: 26, column: 21, scope: !58)
!61 = !DILocation(line: 26, column: 3, scope: !62)
!62 = !DILexicalBlockFile(scope: !54, file: !3, discriminator: 2)
!63 = !DILocation(line: 28, column: 18, scope: !64)
!64 = distinct !DILexicalBlock(scope: !59, file: !3, line: 27, column: 3)
!65 = !DILocation(line: 28, column: 14, scope: !64)
!66 = !DILocation(line: 28, column: 9, scope: !64)
!67 = !DILocation(line: 28, column: 5, scope: !64)
!68 = !DILocation(line: 28, column: 12, scope: !64)
!69 = !DILocation(line: 29, column: 3, scope: !64)
!70 = !DILocation(line: 26, column: 29, scope: !71)
!71 = !DILexicalBlockFile(scope: !59, file: !3, discriminator: 4)
!72 = !DILocation(line: 26, column: 3, scope: !71)
!73 = distinct !{!73, !74, !75}
!74 = !DILocation(line: 26, column: 3, scope: !54)
!75 = !DILocation(line: 29, column: 3, scope: !54)
!76 = !DILocation(line: 31, column: 3, scope: !20)
!77 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 34, type: !78, isLocal: false, isDefinition: true, scopeLine: 35, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!78 = !DISubroutineType(types: !79)
!79 = !{!9}
!80 = !DILocalVariable(name: "q", scope: !77, file: !3, line: 36, type: !9)
!81 = !DILocation(line: 36, column: 7, scope: !77)
!82 = !DILocation(line: 38, column: 41, scope: !77)
!83 = !DILocation(line: 38, column: 3, scope: !77)
!84 = !DILocation(line: 40, column: 10, scope: !77)
!85 = !DILocation(line: 40, column: 15, scope: !77)
!86 = !DILocation(line: 40, column: 33, scope: !77)
!87 = !DILocation(line: 40, column: 29, scope: !77)
!88 = !DILocation(line: 40, column: 12, scope: !77)
!89 = !DILocation(line: 40, column: 3, scope: !77)
!90 = !DILocation(line: 42, column: 3, scope: !77)

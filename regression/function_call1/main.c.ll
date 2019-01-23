; ModuleID = 'function_call1/main.c'
source_filename = "function_call1/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.str = type { i32, i32, i32, [4 x i32], [4 x i32] }

@s = common dso_local global %struct.str zeroinitializer, align 4, !dbg !0

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @pass_through_struct_containing_arrays(i32 %q) #0 !dbg !21 {
entry:
  %q.addr = alloca i32, align 4
  %i = alloca i32, align 4
  %i1 = alloca i32, align 4
  store i32 %q, i32* %q.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %q.addr, metadata !24, metadata !DIExpression()), !dbg !25
  %0 = load i32, i32* %q.addr, align 4, !dbg !26
  store i32 %0, i32* getelementptr inbounds (%struct.str, %struct.str* @s, i32 0, i32 0), align 4, !dbg !27
  store i32 0, i32* getelementptr inbounds (%struct.str, %struct.str* @s, i32 0, i32 1), align 4, !dbg !28
  call void @llvm.dbg.declare(metadata i32* %i, metadata !29, metadata !DIExpression()), !dbg !31
  store i32 0, i32* %i, align 4, !dbg !31
  br label %for.cond, !dbg !32

for.cond:                                         ; preds = %for.inc, %entry
  %1 = load i32, i32* %i, align 4, !dbg !33
  %cmp = icmp slt i32 %1, 4, !dbg !35
  br i1 %cmp, label %for.body, label %for.end, !dbg !36

for.body:                                         ; preds = %for.cond
  %2 = load i32, i32* getelementptr inbounds (%struct.str, %struct.str* @s, i32 0, i32 0), align 4, !dbg !37
  %3 = load i32, i32* getelementptr inbounds (%struct.str, %struct.str* @s, i32 0, i32 1), align 4, !dbg !39
  %add = add nsw i32 %2, %3, !dbg !40
  %4 = load i32, i32* %i, align 4, !dbg !41
  %idxprom = sext i32 %4 to i64, !dbg !42
  %arrayidx = getelementptr inbounds [4 x i32], [4 x i32]* getelementptr inbounds (%struct.str, %struct.str* @s, i32 0, i32 3), i64 0, i64 %idxprom, !dbg !42
  store i32 %add, i32* %arrayidx, align 4, !dbg !43
  br label %for.inc, !dbg !44

for.inc:                                          ; preds = %for.body
  %5 = load i32, i32* %i, align 4, !dbg !45
  %inc = add nsw i32 %5, 1, !dbg !45
  store i32 %inc, i32* %i, align 4, !dbg !45
  br label %for.cond, !dbg !46, !llvm.loop !47

for.end:                                          ; preds = %for.cond
  call void @llvm.dbg.declare(metadata i32* %i1, metadata !49, metadata !DIExpression()), !dbg !51
  store i32 0, i32* %i1, align 4, !dbg !51
  br label %for.cond2, !dbg !52

for.cond2:                                        ; preds = %for.inc9, %for.end
  %6 = load i32, i32* %i1, align 4, !dbg !53
  %cmp3 = icmp slt i32 %6, 4, !dbg !55
  br i1 %cmp3, label %for.body4, label %for.end11, !dbg !56

for.body4:                                        ; preds = %for.cond2
  %7 = load i32, i32* %i1, align 4, !dbg !57
  %idxprom5 = sext i32 %7 to i64, !dbg !59
  %arrayidx6 = getelementptr inbounds [4 x i32], [4 x i32]* getelementptr inbounds (%struct.str, %struct.str* @s, i32 0, i32 3), i64 0, i64 %idxprom5, !dbg !59
  %8 = load i32, i32* %arrayidx6, align 4, !dbg !59
  %9 = load i32, i32* %i1, align 4, !dbg !60
  %idxprom7 = sext i32 %9 to i64, !dbg !61
  %arrayidx8 = getelementptr inbounds [4 x i32], [4 x i32]* getelementptr inbounds (%struct.str, %struct.str* @s, i32 0, i32 4), i64 0, i64 %idxprom7, !dbg !61
  store i32 %8, i32* %arrayidx8, align 4, !dbg !62
  br label %for.inc9, !dbg !63

for.inc9:                                         ; preds = %for.body4
  %10 = load i32, i32* %i1, align 4, !dbg !64
  %inc10 = add nsw i32 %10, 1, !dbg !64
  store i32 %inc10, i32* %i1, align 4, !dbg !64
  br label %for.cond2, !dbg !65, !llvm.loop !66

for.end11:                                        ; preds = %for.cond2
  ret void, !dbg !68
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !69 {
entry:
  %retval = alloca i32, align 4
  %q = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %q, metadata !72, metadata !DIExpression()), !dbg !73
  %0 = load i32, i32* %q, align 4, !dbg !74
  call void @pass_through_struct_containing_arrays(i32 %0), !dbg !75
  %1 = load i32, i32* %q, align 4, !dbg !76
  %2 = load i32, i32* getelementptr inbounds (%struct.str, %struct.str* @s, i32 0, i32 4, i64 3), align 4, !dbg !77
  %3 = load i32, i32* getelementptr inbounds (%struct.str, %struct.str* @s, i32 0, i32 1), align 4, !dbg !78
  %add = add nsw i32 %2, %3, !dbg !79
  %cmp = icmp eq i32 %1, %add, !dbg !80
  %conv = zext i1 %cmp to i32, !dbg !80
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !81
  ret i32 1, !dbg !82
}

declare dso_local i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!17, !18, !19}
!llvm.ident = !{!20}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "s", scope: !2, file: !3, line: 14, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 7.0.1 (https://github.com/llvm-mirror/clang.git 4519e2637fcc4bf6e3049a0a80e6a5e7b97667cb) (https://github.com/llvm-mirror/llvm.git cd98f42d0747826062fc3d2d2fad383aedf58dd6)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "function_call1/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
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
!19 = !{i32 1, !"wchar_size", i32 4}
!20 = !{!"clang version 7.0.1 (https://github.com/llvm-mirror/clang.git 4519e2637fcc4bf6e3049a0a80e6a5e7b97667cb) (https://github.com/llvm-mirror/llvm.git cd98f42d0747826062fc3d2d2fad383aedf58dd6)"}
!21 = distinct !DISubprogram(name: "pass_through_struct_containing_arrays", scope: !3, file: !3, line: 16, type: !22, isLocal: false, isDefinition: true, scopeLine: 17, flags: DIFlagPrototyped, isOptimized: false, unit: !2, retainedNodes: !4)
!22 = !DISubroutineType(types: !23)
!23 = !{null, !9}
!24 = !DILocalVariable(name: "q", arg: 1, scope: !21, file: !3, line: 16, type: !9)
!25 = !DILocation(line: 16, column: 49, scope: !21)
!26 = !DILocation(line: 18, column: 9, scope: !21)
!27 = !DILocation(line: 18, column: 7, scope: !21)
!28 = !DILocation(line: 19, column: 7, scope: !21)
!29 = !DILocalVariable(name: "i", scope: !30, file: !3, line: 21, type: !9)
!30 = distinct !DILexicalBlock(scope: !21, file: !3, line: 21, column: 3)
!31 = !DILocation(line: 21, column: 12, scope: !30)
!32 = !DILocation(line: 21, column: 8, scope: !30)
!33 = !DILocation(line: 21, column: 19, scope: !34)
!34 = distinct !DILexicalBlock(scope: !30, file: !3, line: 21, column: 3)
!35 = !DILocation(line: 21, column: 21, scope: !34)
!36 = !DILocation(line: 21, column: 3, scope: !30)
!37 = !DILocation(line: 23, column: 16, scope: !38)
!38 = distinct !DILexicalBlock(scope: !34, file: !3, line: 22, column: 3)
!39 = !DILocation(line: 23, column: 22, scope: !38)
!40 = !DILocation(line: 23, column: 18, scope: !38)
!41 = !DILocation(line: 23, column: 9, scope: !38)
!42 = !DILocation(line: 23, column: 5, scope: !38)
!43 = !DILocation(line: 23, column: 12, scope: !38)
!44 = !DILocation(line: 24, column: 3, scope: !38)
!45 = !DILocation(line: 21, column: 29, scope: !34)
!46 = !DILocation(line: 21, column: 3, scope: !34)
!47 = distinct !{!47, !36, !48}
!48 = !DILocation(line: 24, column: 3, scope: !30)
!49 = !DILocalVariable(name: "i", scope: !50, file: !3, line: 26, type: !9)
!50 = distinct !DILexicalBlock(scope: !21, file: !3, line: 26, column: 3)
!51 = !DILocation(line: 26, column: 12, scope: !50)
!52 = !DILocation(line: 26, column: 8, scope: !50)
!53 = !DILocation(line: 26, column: 19, scope: !54)
!54 = distinct !DILexicalBlock(scope: !50, file: !3, line: 26, column: 3)
!55 = !DILocation(line: 26, column: 21, scope: !54)
!56 = !DILocation(line: 26, column: 3, scope: !50)
!57 = !DILocation(line: 28, column: 18, scope: !58)
!58 = distinct !DILexicalBlock(scope: !54, file: !3, line: 27, column: 3)
!59 = !DILocation(line: 28, column: 14, scope: !58)
!60 = !DILocation(line: 28, column: 9, scope: !58)
!61 = !DILocation(line: 28, column: 5, scope: !58)
!62 = !DILocation(line: 28, column: 12, scope: !58)
!63 = !DILocation(line: 29, column: 3, scope: !58)
!64 = !DILocation(line: 26, column: 29, scope: !54)
!65 = !DILocation(line: 26, column: 3, scope: !54)
!66 = distinct !{!66, !56, !67}
!67 = !DILocation(line: 29, column: 3, scope: !50)
!68 = !DILocation(line: 31, column: 3, scope: !21)
!69 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 34, type: !70, isLocal: false, isDefinition: true, scopeLine: 35, flags: DIFlagPrototyped, isOptimized: false, unit: !2, retainedNodes: !4)
!70 = !DISubroutineType(types: !71)
!71 = !{!9}
!72 = !DILocalVariable(name: "q", scope: !69, file: !3, line: 36, type: !9)
!73 = !DILocation(line: 36, column: 7, scope: !69)
!74 = !DILocation(line: 38, column: 41, scope: !69)
!75 = !DILocation(line: 38, column: 3, scope: !69)
!76 = !DILocation(line: 40, column: 10, scope: !69)
!77 = !DILocation(line: 40, column: 15, scope: !69)
!78 = !DILocation(line: 40, column: 33, scope: !69)
!79 = !DILocation(line: 40, column: 29, scope: !69)
!80 = !DILocation(line: 40, column: 12, scope: !69)
!81 = !DILocation(line: 40, column: 3, scope: !69)
!82 = !DILocation(line: 42, column: 3, scope: !69)

; ModuleID = 'bitwise_3/main.c'
source_filename = "bitwise_3/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !6 {
entry:
  %retval = alloca i32, align 4
  %x = alloca i32, align 4
  %res1 = alloca i32, align 4
  %y = alloca i32, align 4
  %res2 = alloca i32, align 4
  %arr = alloca [5 x i32], align 16
  %res3 = alloca i32, align 4
  %res4 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %x, metadata !10, metadata !11), !dbg !12
  store i32 16, i32* %x, align 4, !dbg !12
  call void @llvm.dbg.declare(metadata i32* %res1, metadata !13, metadata !11), !dbg !14
  %0 = load i32, i32* %x, align 4, !dbg !15
  %shr = ashr i32 %0, 1, !dbg !16
  %shl = shl i32 %shr, 1, !dbg !17
  %shr1 = ashr i32 %shl, 3, !dbg !18
  %shl2 = shl i32 %shr1, 2, !dbg !19
  store i32 %shl2, i32* %res1, align 4, !dbg !14
  %1 = load i32, i32* %res1, align 4, !dbg !20
  %cmp = icmp eq i32 %1, 8, !dbg !21
  %conv = zext i1 %cmp to i32, !dbg !21
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !22
  call void @llvm.dbg.declare(metadata i32* %y, metadata !23, metadata !11), !dbg !25
  store i32 -1, i32* %y, align 4, !dbg !25
  call void @llvm.dbg.declare(metadata i32* %res2, metadata !26, metadata !11), !dbg !27
  %2 = load i32, i32* %y, align 4, !dbg !28
  %3 = load i32, i32* %y, align 4, !dbg !29
  %and = and i32 %2, %3, !dbg !30
  store i32 %and, i32* %res2, align 4, !dbg !27
  %4 = load i32, i32* %res2, align 4, !dbg !31
  %cmp3 = icmp slt i32 %4, 0, !dbg !32
  %conv4 = zext i1 %cmp3 to i32, !dbg !32
  %call5 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv4), !dbg !33
  call void @llvm.dbg.declare(metadata [5 x i32]* %arr, metadata !34, metadata !11), !dbg !38
  %arrayidx = getelementptr inbounds [5 x i32], [5 x i32]* %arr, i64 0, i64 0, !dbg !39
  store i32 2, i32* %arrayidx, align 16, !dbg !40
  %arrayidx6 = getelementptr inbounds [5 x i32], [5 x i32]* %arr, i64 0, i64 1, !dbg !41
  store i32 1, i32* %arrayidx6, align 4, !dbg !42
  %arrayidx7 = getelementptr inbounds [5 x i32], [5 x i32]* %arr, i64 0, i64 2, !dbg !43
  store i32 3, i32* %arrayidx7, align 8, !dbg !44
  %arrayidx8 = getelementptr inbounds [5 x i32], [5 x i32]* %arr, i64 0, i64 3, !dbg !45
  store i32 5, i32* %arrayidx8, align 4, !dbg !46
  %arrayidx9 = getelementptr inbounds [5 x i32], [5 x i32]* %arr, i64 0, i64 4, !dbg !47
  store i32 7, i32* %arrayidx9, align 16, !dbg !48
  call void @llvm.dbg.declare(metadata i32* %res3, metadata !49, metadata !11), !dbg !50
  %arrayidx10 = getelementptr inbounds [5 x i32], [5 x i32]* %arr, i64 0, i64 0, !dbg !51
  %5 = load i32, i32* %arrayidx10, align 16, !dbg !51
  %arrayidx11 = getelementptr inbounds [5 x i32], [5 x i32]* %arr, i64 0, i64 1, !dbg !52
  %6 = load i32, i32* %arrayidx11, align 4, !dbg !52
  %and12 = and i32 %5, %6, !dbg !53
  %arrayidx13 = getelementptr inbounds [5 x i32], [5 x i32]* %arr, i64 0, i64 2, !dbg !54
  %7 = load i32, i32* %arrayidx13, align 8, !dbg !54
  %and14 = and i32 %and12, %7, !dbg !55
  %arrayidx15 = getelementptr inbounds [5 x i32], [5 x i32]* %arr, i64 0, i64 3, !dbg !56
  %8 = load i32, i32* %arrayidx15, align 4, !dbg !56
  %and16 = and i32 %and14, %8, !dbg !57
  %arrayidx17 = getelementptr inbounds [5 x i32], [5 x i32]* %arr, i64 0, i64 4, !dbg !58
  %9 = load i32, i32* %arrayidx17, align 16, !dbg !58
  %and18 = and i32 %and16, %9, !dbg !59
  store i32 %and18, i32* %res3, align 4, !dbg !50
  %10 = load i32, i32* %res3, align 4, !dbg !60
  %cmp19 = icmp eq i32 %10, 0, !dbg !61
  %conv20 = zext i1 %cmp19 to i32, !dbg !61
  %call21 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv20), !dbg !62
  call void @llvm.dbg.declare(metadata i32* %res4, metadata !63, metadata !11), !dbg !64
  store i32 12, i32* %res4, align 4, !dbg !64
  %11 = load i32, i32* %res4, align 4, !dbg !65
  %cmp22 = icmp eq i32 %11, 12, !dbg !66
  %conv23 = zext i1 %cmp22 to i32, !dbg !66
  %call24 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv23), !dbg !67
  ret i32 0, !dbg !68
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @assert(...) #2

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4}
!llvm.ident = !{!5}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (trunk 295264)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "bitwise_3/main.c", directory: "/home/rasika/llvm2goto/llvm2goto-regression-master")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{!"clang version 5.0.0 (trunk 295264)"}
!6 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 1, type: !7, isLocal: false, isDefinition: true, scopeLine: 2, isOptimized: false, unit: !0, variables: !2)
!7 = !DISubroutineType(types: !8)
!8 = !{!9}
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DILocalVariable(name: "x", scope: !6, file: !1, line: 3, type: !9)
!11 = !DIExpression()
!12 = !DILocation(line: 3, column: 6, scope: !6)
!13 = !DILocalVariable(name: "res1", scope: !6, file: !1, line: 6, type: !9)
!14 = !DILocation(line: 6, column: 6, scope: !6)
!15 = !DILocation(line: 6, column: 13, scope: !6)
!16 = !DILocation(line: 6, column: 14, scope: !6)
!17 = !DILocation(line: 6, column: 17, scope: !6)
!18 = !DILocation(line: 6, column: 20, scope: !6)
!19 = !DILocation(line: 6, column: 23, scope: !6)
!20 = !DILocation(line: 7, column: 9, scope: !6)
!21 = !DILocation(line: 7, column: 13, scope: !6)
!22 = !DILocation(line: 7, column: 2, scope: !6)
!23 = !DILocalVariable(name: "y", scope: !6, file: !1, line: 9, type: !24)
!24 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!25 = !DILocation(line: 9, column: 15, scope: !6)
!26 = !DILocalVariable(name: "res2", scope: !6, file: !1, line: 10, type: !9)
!27 = !DILocation(line: 10, column: 6, scope: !6)
!28 = !DILocation(line: 10, column: 13, scope: !6)
!29 = !DILocation(line: 10, column: 15, scope: !6)
!30 = !DILocation(line: 10, column: 14, scope: !6)
!31 = !DILocation(line: 12, column: 9, scope: !6)
!32 = !DILocation(line: 12, column: 13, scope: !6)
!33 = !DILocation(line: 12, column: 2, scope: !6)
!34 = !DILocalVariable(name: "arr", scope: !6, file: !1, line: 15, type: !35)
!35 = !DICompositeType(tag: DW_TAG_array_type, baseType: !9, size: 160, elements: !36)
!36 = !{!37}
!37 = !DISubrange(count: 5)
!38 = !DILocation(line: 15, column: 6, scope: !6)
!39 = !DILocation(line: 16, column: 2, scope: !6)
!40 = !DILocation(line: 16, column: 9, scope: !6)
!41 = !DILocation(line: 16, column: 15, scope: !6)
!42 = !DILocation(line: 16, column: 22, scope: !6)
!43 = !DILocation(line: 16, column: 27, scope: !6)
!44 = !DILocation(line: 16, column: 34, scope: !6)
!45 = !DILocation(line: 16, column: 40, scope: !6)
!46 = !DILocation(line: 16, column: 47, scope: !6)
!47 = !DILocation(line: 16, column: 53, scope: !6)
!48 = !DILocation(line: 16, column: 60, scope: !6)
!49 = !DILocalVariable(name: "res3", scope: !6, file: !1, line: 18, type: !9)
!50 = !DILocation(line: 18, column: 6, scope: !6)
!51 = !DILocation(line: 18, column: 13, scope: !6)
!52 = !DILocation(line: 18, column: 22, scope: !6)
!53 = !DILocation(line: 18, column: 20, scope: !6)
!54 = !DILocation(line: 18, column: 31, scope: !6)
!55 = !DILocation(line: 18, column: 29, scope: !6)
!56 = !DILocation(line: 18, column: 40, scope: !6)
!57 = !DILocation(line: 18, column: 38, scope: !6)
!58 = !DILocation(line: 18, column: 49, scope: !6)
!59 = !DILocation(line: 18, column: 47, scope: !6)
!60 = !DILocation(line: 19, column: 9, scope: !6)
!61 = !DILocation(line: 19, column: 13, scope: !6)
!62 = !DILocation(line: 19, column: 2, scope: !6)
!63 = !DILocalVariable(name: "res4", scope: !6, file: !1, line: 22, type: !9)
!64 = !DILocation(line: 22, column: 6, scope: !6)
!65 = !DILocation(line: 23, column: 9, scope: !6)
!66 = !DILocation(line: 23, column: 14, scope: !6)
!67 = !DILocation(line: 23, column: 2, scope: !6)
!68 = !DILocation(line: 24, column: 2, scope: !6)
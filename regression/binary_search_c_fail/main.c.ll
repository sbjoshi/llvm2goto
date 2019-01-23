; ModuleID = 'binary_search_c_fail/main.c'
source_filename = "binary_search_c_fail/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %first = alloca i32, align 4
  %last = alloca i32, align 4
  %middle = alloca i32, align 4
  %n = alloca i32, align 4
  %search = alloca i32, align 4
  %array = alloca [10 x i32], align 16
  %found = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %first, metadata !11, metadata !DIExpression()), !dbg !12
  call void @llvm.dbg.declare(metadata i32* %last, metadata !13, metadata !DIExpression()), !dbg !14
  call void @llvm.dbg.declare(metadata i32* %middle, metadata !15, metadata !DIExpression()), !dbg !16
  call void @llvm.dbg.declare(metadata i32* %n, metadata !17, metadata !DIExpression()), !dbg !18
  store i32 5, i32* %n, align 4, !dbg !18
  call void @llvm.dbg.declare(metadata i32* %search, metadata !19, metadata !DIExpression()), !dbg !20
  call void @llvm.dbg.declare(metadata [10 x i32]* %array, metadata !21, metadata !DIExpression()), !dbg !25
  call void @llvm.dbg.declare(metadata i32* %found, metadata !26, metadata !DIExpression()), !dbg !27
  store i32 0, i32* %found, align 4, !dbg !27
  store i32 0, i32* %first, align 4, !dbg !28
  %0 = load i32, i32* %n, align 4, !dbg !29
  %sub = sub nsw i32 %0, 1, !dbg !30
  store i32 %sub, i32* %last, align 4, !dbg !31
  %1 = load i32, i32* %first, align 4, !dbg !32
  %2 = load i32, i32* %last, align 4, !dbg !33
  %add = add nsw i32 %1, %2, !dbg !34
  %div = sdiv i32 %add, 2, !dbg !35
  store i32 %div, i32* %middle, align 4, !dbg !36
  br label %while.cond, !dbg !37

while.cond:                                       ; preds = %if.end12, %entry
  %3 = load i32, i32* %first, align 4, !dbg !38
  %4 = load i32, i32* %last, align 4, !dbg !39
  %cmp = icmp slt i32 %3, %4, !dbg !40
  br i1 %cmp, label %while.body, label %while.end, !dbg !37

while.body:                                       ; preds = %while.cond
  %5 = load i32, i32* %middle, align 4, !dbg !41
  %6 = load i32, i32* %first, align 4, !dbg !43
  %cmp1 = icmp sge i32 %5, %6, !dbg !44
  br i1 %cmp1, label %land.rhs, label %land.end, !dbg !45

land.rhs:                                         ; preds = %while.body
  %7 = load i32, i32* %middle, align 4, !dbg !46
  %8 = load i32, i32* %last, align 4, !dbg !47
  %cmp2 = icmp sle i32 %7, %8, !dbg !48
  br label %land.end

land.end:                                         ; preds = %land.rhs, %while.body
  %9 = phi i1 [ false, %while.body ], [ %cmp2, %land.rhs ], !dbg !49
  %land.ext = zext i1 %9 to i32, !dbg !45
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %land.ext), !dbg !50
  %10 = load i32, i32* %middle, align 4, !dbg !51
  %idxprom = sext i32 %10 to i64, !dbg !53
  %arrayidx = getelementptr inbounds [10 x i32], [10 x i32]* %array, i64 0, i64 %idxprom, !dbg !53
  %11 = load i32, i32* %arrayidx, align 4, !dbg !53
  %12 = load i32, i32* %search, align 4, !dbg !54
  %cmp3 = icmp slt i32 %11, %12, !dbg !55
  br i1 %cmp3, label %if.then, label %if.else, !dbg !56

if.then:                                          ; preds = %land.end
  %13 = load i32, i32* %middle, align 4, !dbg !57
  %add4 = add nsw i32 %13, 1, !dbg !58
  store i32 %add4, i32* %first, align 4, !dbg !59
  br label %if.end12, !dbg !60

if.else:                                          ; preds = %land.end
  %14 = load i32, i32* %middle, align 4, !dbg !61
  %idxprom5 = sext i32 %14 to i64, !dbg !63
  %arrayidx6 = getelementptr inbounds [10 x i32], [10 x i32]* %array, i64 0, i64 %idxprom5, !dbg !63
  %15 = load i32, i32* %arrayidx6, align 4, !dbg !63
  %16 = load i32, i32* %search, align 4, !dbg !64
  %cmp7 = icmp eq i32 %15, %16, !dbg !65
  br i1 %cmp7, label %if.then8, label %if.else10, !dbg !66

if.then8:                                         ; preds = %if.else
  %17 = load i32, i32* %found, align 4, !dbg !67
  %add9 = add nsw i32 %17, 1, !dbg !69
  store i32 %add9, i32* %found, align 4, !dbg !70
  br label %while.end, !dbg !71

if.else10:                                        ; preds = %if.else
  %18 = load i32, i32* %middle, align 4, !dbg !72
  %sub11 = sub nsw i32 %18, 1, !dbg !73
  store i32 %sub11, i32* %last, align 4, !dbg !74
  br label %if.end

if.end:                                           ; preds = %if.else10
  br label %if.end12

if.end12:                                         ; preds = %if.end, %if.then
  %19 = load i32, i32* %first, align 4, !dbg !75
  %20 = load i32, i32* %last, align 4, !dbg !76
  %add13 = add nsw i32 %19, %20, !dbg !77
  %div14 = sdiv i32 %add13, 2, !dbg !78
  store i32 %div14, i32* %middle, align 4, !dbg !79
  br label %while.cond, !dbg !37, !llvm.loop !80

while.end:                                        ; preds = %if.then8, %while.cond
  %21 = load i32, i32* %first, align 4, !dbg !82
  %22 = load i32, i32* %last, align 4, !dbg !83
  %cmp15 = icmp sgt i32 %21, %22, !dbg !84
  br i1 %cmp15, label %land.lhs.true, label %lor.rhs, !dbg !85

land.lhs.true:                                    ; preds = %while.end
  %23 = load i32, i32* %found, align 4, !dbg !86
  %cmp16 = icmp eq i32 %23, 0, !dbg !87
  br i1 %cmp16, label %lor.end, label %lor.rhs, !dbg !88

lor.rhs:                                          ; preds = %land.lhs.true, %while.end
  %24 = load i32, i32* %first, align 4, !dbg !89
  %25 = load i32, i32* %last, align 4, !dbg !90
  %cmp17 = icmp sle i32 %24, %25, !dbg !91
  br i1 %cmp17, label %land.rhs18, label %land.end20, !dbg !92

land.rhs18:                                       ; preds = %lor.rhs
  %26 = load i32, i32* %found, align 4, !dbg !93
  %cmp19 = icmp sgt i32 %26, 0, !dbg !94
  br label %land.end20

land.end20:                                       ; preds = %land.rhs18, %lor.rhs
  %27 = phi i1 [ false, %lor.rhs ], [ %cmp19, %land.rhs18 ], !dbg !95
  br label %lor.end, !dbg !88

lor.end:                                          ; preds = %land.end20, %land.lhs.true
  %28 = phi i1 [ true, %land.lhs.true ], [ %27, %land.end20 ]
  %lor.ext = zext i1 %28 to i32, !dbg !88
  %call22 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %lor.ext), !dbg !96
  ret i32 0, !dbg !97
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 7.0.1 (https://github.com/llvm-mirror/clang.git 4519e2637fcc4bf6e3049a0a80e6a5e7b97667cb) (https://github.com/llvm-mirror/llvm.git cd98f42d0747826062fc3d2d2fad383aedf58dd6)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "binary_search_c_fail/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 7.0.1 (https://github.com/llvm-mirror/clang.git 4519e2637fcc4bf6e3049a0a80e6a5e7b97667cb) (https://github.com/llvm-mirror/llvm.git cd98f42d0747826062fc3d2d2fad383aedf58dd6)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 1, type: !8, isLocal: false, isDefinition: true, scopeLine: 2, isOptimized: false, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "first", scope: !7, file: !1, line: 3, type: !10)
!12 = !DILocation(line: 3, column: 8, scope: !7)
!13 = !DILocalVariable(name: "last", scope: !7, file: !1, line: 3, type: !10)
!14 = !DILocation(line: 3, column: 15, scope: !7)
!15 = !DILocalVariable(name: "middle", scope: !7, file: !1, line: 3, type: !10)
!16 = !DILocation(line: 3, column: 21, scope: !7)
!17 = !DILocalVariable(name: "n", scope: !7, file: !1, line: 4, type: !10)
!18 = !DILocation(line: 4, column: 8, scope: !7)
!19 = !DILocalVariable(name: "search", scope: !7, file: !1, line: 5, type: !10)
!20 = !DILocation(line: 5, column: 8, scope: !7)
!21 = !DILocalVariable(name: "array", scope: !7, file: !1, line: 6, type: !22)
!22 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 320, elements: !23)
!23 = !{!24}
!24 = !DISubrange(count: 10)
!25 = !DILocation(line: 6, column: 8, scope: !7)
!26 = !DILocalVariable(name: "found", scope: !7, file: !1, line: 8, type: !10)
!27 = !DILocation(line: 8, column: 8, scope: !7)
!28 = !DILocation(line: 10, column: 10, scope: !7)
!29 = !DILocation(line: 11, column: 11, scope: !7)
!30 = !DILocation(line: 11, column: 13, scope: !7)
!31 = !DILocation(line: 11, column: 9, scope: !7)
!32 = !DILocation(line: 12, column: 14, scope: !7)
!33 = !DILocation(line: 12, column: 20, scope: !7)
!34 = !DILocation(line: 12, column: 19, scope: !7)
!35 = !DILocation(line: 12, column: 25, scope: !7)
!36 = !DILocation(line: 12, column: 11, scope: !7)
!37 = !DILocation(line: 14, column: 4, scope: !7)
!38 = !DILocation(line: 14, column: 11, scope: !7)
!39 = !DILocation(line: 14, column: 19, scope: !7)
!40 = !DILocation(line: 14, column: 17, scope: !7)
!41 = !DILocation(line: 17, column: 14, scope: !42)
!42 = distinct !DILexicalBlock(scope: !7, file: !1, line: 14, column: 25)
!43 = !DILocation(line: 17, column: 24, scope: !42)
!44 = !DILocation(line: 17, column: 21, scope: !42)
!45 = !DILocation(line: 17, column: 30, scope: !42)
!46 = !DILocation(line: 17, column: 33, scope: !42)
!47 = !DILocation(line: 17, column: 42, scope: !42)
!48 = !DILocation(line: 17, column: 39, scope: !42)
!49 = !DILocation(line: 0, scope: !42)
!50 = !DILocation(line: 17, column: 7, scope: !42)
!51 = !DILocation(line: 19, column: 17, scope: !52)
!52 = distinct !DILexicalBlock(scope: !42, file: !1, line: 19, column: 11)
!53 = !DILocation(line: 19, column: 11, scope: !52)
!54 = !DILocation(line: 19, column: 27, scope: !52)
!55 = !DILocation(line: 19, column: 25, scope: !52)
!56 = !DILocation(line: 19, column: 11, scope: !42)
!57 = !DILocation(line: 20, column: 18, scope: !52)
!58 = !DILocation(line: 20, column: 25, scope: !52)
!59 = !DILocation(line: 20, column: 16, scope: !52)
!60 = !DILocation(line: 20, column: 10, scope: !52)
!61 = !DILocation(line: 22, column: 22, scope: !62)
!62 = distinct !DILexicalBlock(scope: !52, file: !1, line: 22, column: 16)
!63 = !DILocation(line: 22, column: 16, scope: !62)
!64 = !DILocation(line: 22, column: 33, scope: !62)
!65 = !DILocation(line: 22, column: 30, scope: !62)
!66 = !DILocation(line: 22, column: 16, scope: !52)
!67 = !DILocation(line: 23, column: 18, scope: !68)
!68 = distinct !DILexicalBlock(scope: !62, file: !1, line: 22, column: 41)
!69 = !DILocation(line: 23, column: 24, scope: !68)
!70 = !DILocation(line: 23, column: 16, scope: !68)
!71 = !DILocation(line: 24, column: 10, scope: !68)
!72 = !DILocation(line: 27, column: 17, scope: !62)
!73 = !DILocation(line: 27, column: 24, scope: !62)
!74 = !DILocation(line: 27, column: 15, scope: !62)
!75 = !DILocation(line: 29, column: 17, scope: !42)
!76 = !DILocation(line: 29, column: 25, scope: !42)
!77 = !DILocation(line: 29, column: 23, scope: !42)
!78 = !DILocation(line: 29, column: 30, scope: !42)
!79 = !DILocation(line: 29, column: 14, scope: !42)
!80 = distinct !{!80, !37, !81}
!81 = !DILocation(line: 31, column: 4, scope: !7)
!82 = !DILocation(line: 33, column: 13, scope: !7)
!83 = !DILocation(line: 33, column: 21, scope: !7)
!84 = !DILocation(line: 33, column: 19, scope: !7)
!85 = !DILocation(line: 33, column: 27, scope: !7)
!86 = !DILocation(line: 33, column: 30, scope: !7)
!87 = !DILocation(line: 33, column: 35, scope: !7)
!88 = !DILocation(line: 33, column: 40, scope: !7)
!89 = !DILocation(line: 33, column: 45, scope: !7)
!90 = !DILocation(line: 33, column: 52, scope: !7)
!91 = !DILocation(line: 33, column: 50, scope: !7)
!92 = !DILocation(line: 33, column: 58, scope: !7)
!93 = !DILocation(line: 33, column: 61, scope: !7)
!94 = !DILocation(line: 33, column: 66, scope: !7)
!95 = !DILocation(line: 0, scope: !7)
!96 = !DILocation(line: 33, column: 4, scope: !7)
!97 = !DILocation(line: 34, column: 4, scope: !7)

; ModuleID = '2003-04-22-Switch.c'
source_filename = "2003-04-22-Switch.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [3 x i8] c"C\0A\00", align 1
@.str.1 = private unnamed_addr constant [3 x i8] c"A\0A\00", align 1
@.str.2 = private unnamed_addr constant [3 x i8] c"B\0A\00", align 1
@.str.3 = private unnamed_addr constant [3 x i8] c"D\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %i, metadata !11, metadata !13), !dbg !14
  store i32 0, i32* %i, align 4, !dbg !15
  br label %for.cond, !dbg !17

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4, !dbg !18
  %cmp = icmp ult i32 %0, 10, !dbg !20
  br i1 %cmp, label %for.body, label %for.end, !dbg !21

for.body:                                         ; preds = %for.cond
  %1 = load i32, i32* %i, align 4, !dbg !22
  %call = call i32 @func(i32 %1), !dbg !23
  br label %for.inc, !dbg !23

for.inc:                                          ; preds = %for.body
  %2 = load i32, i32* %i, align 4, !dbg !24
  %inc = add i32 %2, 1, !dbg !24
  store i32 %inc, i32* %i, align 4, !dbg !24
  br label %for.cond, !dbg !25, !llvm.loop !26

for.end:                                          ; preds = %for.cond
  ret i32 0, !dbg !28
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @func(i32 %i) #0 !dbg !29 {
entry:
  %i.addr = alloca i32, align 4
  %X = alloca i32, align 4
  store i32 %i, i32* %i.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %i.addr, metadata !32, metadata !13), !dbg !33
  call void @llvm.dbg.declare(metadata i32* %X, metadata !34, metadata !13), !dbg !35
  store i32 4, i32* %X, align 4, !dbg !35
  %0 = load i32, i32* %i.addr, align 4, !dbg !36
  switch i32 %0, label %sw.default [
    i32 8, label %sw.bb
    i32 0, label %sw.bb1
    i32 3, label %sw.bb1
    i32 2, label %sw.bb1
    i32 1, label %sw.bb3
    i32 7, label %sw.bb3
    i32 9, label %sw.bb4
  ], !dbg !37

sw.bb:                                            ; preds = %entry
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i32 0, i32 0)), !dbg !38
  store i32 6, i32* %X, align 4, !dbg !40
  br label %sw.bb1, !dbg !41

sw.bb1:                                           ; preds = %entry, %entry, %entry, %sw.bb
  %call2 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.1, i32 0, i32 0)), !dbg !42
  br label %sw.epilog, !dbg !43

sw.bb3:                                           ; preds = %entry, %entry
  store i32 7, i32* %X, align 4, !dbg !44
  br label %sw.bb4, !dbg !45

sw.bb4:                                           ; preds = %entry, %sw.bb3
  %call5 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.2, i32 0, i32 0)), !dbg !46
  br label %sw.epilog, !dbg !47

sw.default:                                       ; preds = %entry
  %call6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.3, i32 0, i32 0)), !dbg !48
  store i32 1, i32* %X, align 4, !dbg !49
  br label %sw.epilog, !dbg !50

sw.epilog:                                        ; preds = %sw.default, %sw.bb4, %sw.bb1
  %1 = load i32, i32* %X, align 4, !dbg !51
  ret i32 %1, !dbg !52
}

declare i32 @printf(i8*, ...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "2003-04-22-Switch.c", directory: "/home/ubuntu/llvm2goto/regression/llvm_test_suit/single_source/unit-tests")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 20, type: !8, isLocal: false, isDefinition: true, scopeLine: 20, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "i", scope: !7, file: !1, line: 21, type: !12)
!12 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!13 = !DIExpression()
!14 = !DILocation(line: 21, column: 12, scope: !7)
!15 = !DILocation(line: 22, column: 10, scope: !16)
!16 = distinct !DILexicalBlock(scope: !7, file: !1, line: 22, column: 3)
!17 = !DILocation(line: 22, column: 8, scope: !16)
!18 = !DILocation(line: 22, column: 15, scope: !19)
!19 = distinct !DILexicalBlock(scope: !16, file: !1, line: 22, column: 3)
!20 = !DILocation(line: 22, column: 17, scope: !19)
!21 = !DILocation(line: 22, column: 3, scope: !16)
!22 = !DILocation(line: 23, column: 10, scope: !19)
!23 = !DILocation(line: 23, column: 5, scope: !19)
!24 = !DILocation(line: 22, column: 23, scope: !19)
!25 = !DILocation(line: 22, column: 3, scope: !19)
!26 = distinct !{!26, !21, !27}
!27 = !DILocation(line: 23, column: 11, scope: !16)
!28 = !DILocation(line: 24, column: 3, scope: !7)
!29 = distinct !DISubprogram(name: "func", scope: !1, file: !1, line: 4, type: !30, isLocal: true, isDefinition: true, scopeLine: 4, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!30 = !DISubroutineType(types: !31)
!31 = !{!10, !12}
!32 = !DILocalVariable(name: "i", arg: 1, scope: !29, file: !1, line: 4, type: !12)
!33 = !DILocation(line: 4, column: 26, scope: !29)
!34 = !DILocalVariable(name: "X", scope: !29, file: !1, line: 5, type: !10)
!35 = !DILocation(line: 5, column: 7, scope: !29)
!36 = !DILocation(line: 6, column: 11, scope: !29)
!37 = !DILocation(line: 6, column: 3, scope: !29)
!38 = !DILocation(line: 7, column: 11, scope: !39)
!39 = distinct !DILexicalBlock(scope: !29, file: !1, line: 6, column: 14)
!40 = !DILocation(line: 7, column: 49, scope: !39)
!41 = !DILocation(line: 7, column: 47, scope: !39)
!42 = !DILocation(line: 10, column: 11, scope: !39)
!43 = !DILocation(line: 10, column: 26, scope: !39)
!44 = !DILocation(line: 12, column: 13, scope: !39)
!45 = !DILocation(line: 12, column: 11, scope: !39)
!46 = !DILocation(line: 13, column: 11, scope: !39)
!47 = !DILocation(line: 13, column: 26, scope: !39)
!48 = !DILocation(line: 14, column: 12, scope: !39)
!49 = !DILocation(line: 14, column: 29, scope: !39)
!50 = !DILocation(line: 15, column: 3, scope: !39)
!51 = !DILocation(line: 16, column: 10, scope: !29)
!52 = !DILocation(line: 16, column: 3, scope: !29)
